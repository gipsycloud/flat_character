# Copilot instructions for FlatMate Character

## Project overview

FlatMate Character is a Rails 7.2 monolith running on Ruby 3.2.1 with PostgreSQL. It serves the public room/flatmate website and server-rendered HTML views, plus a JSON API under `/api/v1`. Redis is used by Action Cable and production caching. Active Job uses Solid Queue, with jobs run by `bin/jobs`; recurring production jobs are configured in `config/recurring.yml`.

The frontend is primarily ERB plus Tailwind CSS, Stimulus, Hotwire/Turbo, jQuery, and importmap. JavaScript dependencies such as Flowbite, Swiper, Mapbox GL, and Argon2 are managed with npm/yarn. Images are uploaded through CarrierWave and Cloudinary-related configuration. Render is the production host; `render.yaml` is the deployment source of truth.

## Build, run, and deployment commands

Install dependencies:

```bash
bundle install
npm install # or: yarn install
```

Prepare the PostgreSQL database and assets:

```bash
bin/rails db:prepare
bin/rails assets:precompile
```

Start development with the Procfile:

```bash
bin/dev
# Equivalent: foreman start
```

`Procfile.dev` starts Puma on port 3000, Tailwind CSS watch mode, and the Solid Queue worker. Redis must be available locally unless `REDIS_URL` points elsewhere. Docker users can use `docker compose up`; the compose file starts PostgreSQL, Redis, the web process, and a worker.

The Render build sequence is also available as:

```bash
bin/render-build.sh
```

That script installs gems, precompiles and cleans assets, and runs `db:prepare`. Do not put credentials in tracked files; production configuration is supplied through environment variables and encrypted Rails credentials.

## Tests

The project uses Rails Minitest with YAML fixtures and parallelized `ActiveSupport::TestCase` tests.

Run the full suite:

```bash
bundle exec rails test
```

Run one file or one test method:

```bash
bundle exec rails test test/models/room_test.rb
bundle exec rails test test/controllers/rooms_controller_test.rb:12
```

Run system tests explicitly:

```bash
bundle exec rails test:system
```

Tests use the PostgreSQL configuration in `config/database.yml`; ensure the test database is prepared before running them. Mailers use the test delivery method, uploads use the test service, and fixtures are loaded automatically from `test/fixtures`.

No repository-specific lint command is configured. When changing Ruby, use the project’s existing Bundler/Rails commands rather than introducing a new formatter or linter.

## Architecture and request boundaries

- `config/routes.rb` is the central map of several application surfaces:
  - Public website controllers such as `HomesController`, `RoomsController`, `PostsController`, and `SubscriptionsController` render ERB pages and JSON/Jbuilder representations.
  - `/auth` is the web Devise namespace for `User`; `/auth_admin` is the separate Devise namespace for `Admin`.
  - `/api/v1` is JSON-only. API Devise login/signup routes use custom controllers, and room endpoints are under `/api/v1/rooms/rooms`.
  - `/cable`, `/up`, `/health/redis`, and the authenticated `/logs` endpoint are operational/infrastructure surfaces.
- `ApplicationController` supplies HTML behavior, layouts, Devise parameter sanitization, unverified-user redirects, record-not-found handling, and CanCanCan access-denied handling. API controllers inherit from `Api::V1::BaseController`, which switches to JSON, disables CSRF checks for JSON, and authenticates bearer tokens.
- Web authentication is session-based Devise. API authentication is custom JWT logic in `app/controllers/concerns/json_web_token.rb`; API clients send `Authorization: Bearer <token>`. Keep API responses and error handling JSON-shaped.
- `User` is the main domain aggregate: it owns rooms, profile information, upgrades, payments, and a subscription. Creation callbacks schedule verification mail/PIN work and create related records. `Room` owns images/property data, geocodes its address, creates a slug with FriendlyId, and notifies subscribers after commit.
- Authorization is centralized in `app/models/ability.rb`: admins can manage everything, while members have room CRUD and `generate_details` permissions. Preserve this distinction when adding controller actions.
- Business logic that does not belong in a controller is placed under `app/services` and is autoloaded by `config/application.rb`. Background work belongs in `app/jobs`; recurring schedules belong in `config/recurring.yml`.
- Views generally have both HTML templates and Jbuilder partials/index/show representations. Follow the existing controller/view pairing instead of adding a second serialization layer.

## Codebase-specific conventions

- Use Rails route namespaces and controller namespaces consistently. API controllers should inherit from `Api::V1::BaseController`; do not mix web session assumptions into API actions.
- Use Devise’s separate `User` and `Admin` scopes and their existing custom controllers/routes. Add signup fields through `ApplicationController#configure_permitted_parameters`.
- Use `respond_to`/`respond_with` and the existing Jbuilder files for resource JSON output. Keep API endpoints under the `api/v1` namespace and preserve bearer-token authentication.
- Room enums use persisted string columns (`gender`, `roomType`, and `room_status`); existing compatibility helpers such as `room_type_nums` support older form code. Check the real column name before changing an enum or form helper.
- Room images use nested attributes and CarrierWave uploaders. Preserve `accepts_nested_attributes_for :room_images` and the existing uploader/dependent-destroy behavior when modifying room forms.
- Prefer model callbacks only for the existing domain side effects; schedule email and delayed verification work through Active Job rather than performing it inline in requests.
- Use the existing `RoomDetailsGenerator` service for AI-generated room descriptions. It reads `OPENAI_API_KEY` and `OPENAI_MODEL` from the environment and must fail explicitly when configuration is missing.
- Use environment variables for database, Redis, SMTP, Cloudinary, OpenAI, and deployment settings. Do not hard-code tokens, passwords, API keys, or replacement secrets in source.
- Keep frontend changes aligned with the current stack: Tailwind styles in the existing asset pipeline, Stimulus controllers under `app/javascript/controllers`, and importmap/npm dependencies according to how the surrounding feature is wired.
