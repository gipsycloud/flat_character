
## FlatMate Character

Every 3 minutes someone finds a flatmate on SpareRoom. With the biggest selection of ads, you'll find yours.



### Tech Stack

**Client:** HTML, CSS, TailwindCSS, Javascript, jQuery, Ajax

**Server:** Ruby on Rails, Postgresql, Redis, Sidekiq, Delay Job

**Cloud Service:** Cloudinary

**Host:** Render Server

**Version Control:** rbenv, asdf, git, github

**Node:** npm install or yarn install

**Dev Operation:** Docker, Jenkins

**Analysis:** Google Analysis, Datadog

**Manage:** Foreman



## Appendix

* ruby 3.2.1 (2023-02-08 revision 31819e82c8)

* Rails 7.0.8 

* System dependencies [x86_64-linux]

* Configuration
  hotwire, cloudinary (coming soon)

* Database creation (Postgresql)

* Database initialization
    https://www.datadoghq.com/

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.) (comming soon)

* Deployment instructions (rails s or bin/dev or foreman start)

* stopping of mailcatcher
  sudo lsof -nP -iTCP:1025 -sTCP:LISTEN


## Features

- Coming Soon

## Run Locally

Clone the project

```bash
  git clone https://link-to-project
```

Go to the project directory

```bash
  cd my-project
```

Install dependencies

```bash
   bundle install
```

```bash
   rails assets:precompile
```

Start the server

```bash
   foreman start
```


## Acknowledgements

 - [Tailwind CSS, Flowbite Components](https://flowbite.com)
 - [Tailwind CSS Breadcrumbs](https://tw-elements.com/docs/standard/navigation/breadcrumbs/)
 - [Tailwindcomponents Cheatsheet](https://tailwindcomponents.com/cheatsheet/)
 - [Tailwind CSS Ruby on Rails ](https://flowbite.com/docs/getting-started/rails/)
 - [Swiper](https://www.jsdelivr.com/package/npm/swiper)
 - [SmartLook](https://www.smartlook.com)
 - [HyperUI](https://www.hyperui.dev/)
 - [Live Chat (Brevo.com)](https://login.brevo.com/?target=https%3A%2F%2Fconversations-app.brevo.com%2Fconversations%2FMbTxss4zWbjRkPWxA)
 - [ClouDNS](https://www.cloudns.net/zone-update-info/domain/5905280/)
 - [Readme Editor](https://readme.so/editor)
 - [Ruby Style Guide](https://github.com/rubocop/ruby-style-guide#naming)

#### Rails Knowledge

Tailwind
  - [Tailwind overscroll y not working properly](https://stackoverflow.com/questions/72191704/tailwind-overscroll-y-not-working-properly)

Devise
  - [Multiple Resources with Devise](https://www.driftingruby.com/episodes/multiple-resources-with-devise?query=devise)

Image Upload  
  - [Multiple Upload Image with CarrierWave](https://bobintornado.github.io/rails/2015/12/29/Multiple-Images-Uploading-With-CarrierWave-and-PostgreSQL-Array.html)
  - [DatatypeMismatch: ERROR: in rails (in migration)](https://stackoverflow.com/questions/63373790/pgdatatypemismatch-error-column-status-cannot-be-cast-automatically-to-typ)
  - [fixing for null image data auto saving to database for multiple upload using Carrierwave gem](https://stackoverflow.com/questions/72317021/rails-multi-file-upload-produces-one-empty-entry)
  - [Uploading Multiple Images using CarrierWave](https://railsless.blogspot.com/2015/09/uploading-multiple-images-using.html)
  - [CarrierWave Upload Multiple Images](https://kolosek.com/carrierwave-upload-multiple-images/)
  - [Carrierwave, Rails 4, and Multiple Uploads](https://stackoverflow.com/questions/19712816/carrierwave-rails-4-and-multiple-uploads)
  - [Uploading multiple files with Carrierwave in Rails 4](https://www.discretelogix.com/uploading-multiple-files-with-carrierwave-in-rails-4/)
  - [Upload Multiple Files in Rails API using CarrierWave](https://blog.francium.tech/upload-multiple-files-in-rails-api-using-carrierwave-1f37aaad2b07)

CanCanCan  
  - [temp_authorized_webpage_for_cancancan](https://www.vector-logic.com/blog/posts/authorizing-controller-endpoints-in-rails-punit-versus-cancan)
  - [Controlling authorization in rails with CanCanCan gem](https://blog.francium.tech/controlling-authorization-in-rails-with-cancancan-gem-1c2dfeecb26c)
  - [Authorization Gems in Ruby: Pundit and CanCanCan](https://blog.appsignal.com/2023/03/22/authorization-gems-in-ruby-pundit-and-cancancan.html)

User Profile
  - [update_user_info](https://stackoverflow.com/questions/36051782/rails-devise-add-profile-information-to-separate-table)

Notification
  - [User notifications with Rails, Noticed, and Hotwire](https://www.colby.so/posts/user-notifications-with-rails-noticed-and-hotwire)

Search Function
  - [Simplify Data Filtering in Ruby on Rails with Ransack](https://reinteractive.com/articles/simplify-data-filtering-in-ruby-on-rails-with-ransack#:~:text=Ransack%20is%20highly%20customizable.,without%20needing%20to%20know%20SQL)
  - [Rails6 Search function](https://stackoverflow.com/questions/63469102/rails6-search-function)

Background Job
  - [ruby on rails using the sidekiq + sidekiq-cron making the cron job](https://medium.com/@ashwinborkar1997/ruby-on-rails-using-the-sidekiq-sidekiq-cron-making-the-cron-job-f466a7edeb22)

#### Docker Comment Lines
  - [Clear Docker Cache](https://forums.docker.com/t/clear-docker-cache/110176)  
  - [viewing database with docker](https://www.baeldung.com/ops/docker-databases)
  - [Docker Basics for Ruby on Rails Developers](https://www.youtube.com/watch?v=J7hUHnQtFNo)
  - [My Docker Cheat Sheet](https://medium.com/statuscode/dockercheatsheet-9730ce03630d)
  - [Docker & Postgres: Failed to bind tcp 0.0.0.0:5432 address already in use](https://stackoverflow.com/questions/38249434/docker-postgres-failed-to-bind-tcp-0-0-0-05432-address-already-in-use)
  - [push a docker image to a private repository](https://stackoverflow.com/questions/28349392/how-to-push-a-docker-image-to-a-private-repository)
  - [A Step-by-Step guide to Build and Push Your Own Docker Images to DockerHub](https://medium.com/@komalminhas.96/a-step-by-step-guide-to-build-and-push-your-own-docker-images-to-dockerhub-709963d4a8bc)
  - [Docker: Redis no config file specified](https://stackoverflow.com/questions/76764903/docker-redis-no-config-file-specified)

#### JWT Token
  - [Secure Your Ruby App with JSON Web Tokens](https://blog.appsignal.com/2023/08/23/secure-your-ruby-app-with-json-web-tokens.html)
  - [A Complete Guide to Rails Authentication Using JWT](https://dev.to/mohhossain/a-complete-guide-to-rails-authentication-using-jwt-403p#:~:text=Rails%20JWT%20authentication,client%20in%20a%20REST%20API.)

#### Rails Comment Lines
  - [Generating Devise Controllers - Rails Devise](https://stackoverflow.com/questions/41972575/generating-devise-controllers-rails-devise)


#### Command Line

```bash
  sudo docker builder prune
```

update code
```bash
  docker build -t hotfix .
  docker images
  docker run -d -p 3000:3000 <image_id>
  docker ps
  # docker run -dp 127.0.0.1:3000:3000 hotfix
  docker compose up
```

ActiveSupport::MessageEncryptor::InvalidMessage 
```bash
  1. rm -rf config/credentials.yml.enc
  2. EDITOR=vim rails credentials:edit
```

JWT_SECRET_KEY
```bash
  1. rails secret
  2. EDITOR="nano" bin/rails credentials:edit 
```

```bash
  Identify what is running in port 5432: sudo lsof -i :5432
  Kill all the processes that are running under this port: sudo kill -9 <pid>
  Run the command again to verify no process is running now: sudo lsof -i :5432
```
    


## API Reference

#### Get all items

```http
  GET {{base_url}}/api/v1/login
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### Get item

```http
  GET /api/items/${id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | **Required**. Id of item to fetch |

#### add(num1, num2)

Takes two numbers and returns the sum.


## License

[MIT](https://choosealicense.com/licenses/mit/)


## Support

For support, email fake@fake.com or join our Slack channel.


## Authors

- [@aungwin](https://aungthiwin.github.io/)
