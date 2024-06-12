
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



## Installation

```bash
  git clone ...
  cd blog
  bundle install
  rails db:create db:migrate db:seed
  rails assets:precompile
  foreman start
```
    
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
  npm install
```

Start the server

```bash
  npm run start
```


## Support

For support, email fake@fake.com or join our Slack channel.


## License

[MIT](https://choosealicense.com/licenses/mit/)



# README

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

* Tailwind CSS, Flowbite Components
  https://flowbite.com/

https://tw-elements.com/docs/standard/navigation/breadcrumbs/

https://tailwindcomponents.com/cheatsheet/

Adding Google Analysis, SmartLook, CloudDNS

https://www.cloudns.net/zone-update-info/domain/5905280/

https://app.smartlook.com/org/72768cb3ba0e834e85c1f0b7/project/2k3k3zlh26qtdtxkdsogg798/recordings?segment=active

https://flowbite.com/docs/getting-started/rails/

https://www.hyperui.dev/

https://www.jsdelivr.com/package/npm/swiper

https://stackoverflow.com/questions/41972575/generating-devise-controllers-rails-devise

admin sidebar menu fixed position when scrolling page
https://stackoverflow.com/questions/72191704/tailwind-overscroll-y-not-working-properly

Live Chat (Brevo.com)
https://conversations-app.brevo.com/conversations/MbTxss4zWbjRkPWxA
https://account-app.brevo.com/account/login?target=https%3A%2F%2Fconversations-app.brevo.com%2Fconversations%2FMbTxss4zWbjRkPWxA

Multiple User
https://www.driftingruby.com/episodes/multiple-resources-with-devise?query=devise

Multiple Upload Image with CarrierWave
https://bobintornado.github.io/rails/2015/12/29/Multiple-Images-Uploading-With-CarrierWave-and-PostgreSQL-Array.html

DatatypeMismatch: ERROR: in rails (in migration)
https://stackoverflow.com/questions/63373790/pgdatatypemismatch-error-column-status-cannot-be-cast-automatically-to-typ

temp_authorized_webpage_for_cancancan
https://www.vector-logic.com/blog/posts/authorizing-controller-endpoints-in-rails-punit-versus-cancan
https://blog.francium.tech/controlling-authorization-in-rails-with-cancancan-gem-1c2dfeecb26c
https://blog.appsignal.com/2023/03/22/authorization-gems-in-ruby-pundit-and-cancancan.html

update_user_info
https://stackoverflow.com/questions/36051782/rails-devise-add-profile-information-to-separate-table

adding text
https://amberstudent.com/blog/post/tips-for-living-with-a-roommatew

real-time notification
https://www.colby.so/posts/user-notifications-with-rails-noticed-and-hotwire


https://blog.francium.tech/upload-multiple-files-in-rails-api-using-carrierwave-1f37aaad2b07
https://www.discretelogix.com/uploading-multiple-files-with-carrierwave-in-rails-4/
https://stackoverflow.com/questions/19712816/carrierwave-rails-4-and-multiple-uploads
https://kolosek.com/carrierwave-upload-multiple-images/
https://railsless.blogspot.com/2015/09/uploading-multiple-images-using.html

fixing for null image data auto saving to database for multiple upload using Carrierwave gem
https://stackoverflow.com/questions/72317021/rails-multi-file-upload-produces-one-empty-entry

sidekiq scheduled 
https://medium.com/@ashwinborkar1997/ruby-on-rails-using-the-sidekiq-sidekiq-cron-making-the-cron-job-f466a7edeb22

https://qiita.com/Dai_Kentaro/items/efef71b4d2cd0b76f227#%E5%AE%9F%E8%A1%8C

Search Function
https://reinteractive.com/articles/simplify-data-filtering-in-ruby-on-rails-with-ransack#:~:text=Ransack%20is%20highly%20customizable.,without%20needing%20to%20know%20SQL.
https://stackoverflow.com/questions/63469102/rails6-search-function

Docker
  viewing database with docker
    https://www.baeldung.com/ops/docker-databases
    https://www.youtube.com/watch?v=J7hUHnQtFNo

    clear cache
    https://forums.docker.com/t/clear-docker-cache/110176
    sudo docker builder prune

    docker cheat sheet for command
    https://medium.com/statuscode/dockercheatsheet-9730ce03630d

    stop postgresql 
    https://stackoverflow.com/questions/38249434/docker-postgres-failed-to-bind-tcp-0-0-0-05432-address-already-in-use
    
    Identify what is running in port 5432: sudo lsof -i :5432

    Kill all the processes that are running under this port: sudo kill -9 <pid>

    Run the command again to verify no process is running now: sudo lsof -i :5432

    redis config
      https://stackoverflow.com/questions/76764903/docker-redis-no-config-file-specified

    docker push
      https://stackoverflow.com/questions/28349392/how-to-push-a-docker-image-to-a-private-repository

      https://medium.com/@komalminhas.96/a-step-by-step-guide-to-build-and-push-your-own-docker-images-to-dockerhub-709963d4a8bc

    update code .
      docker build -t hotfix .
      docker images
      docker run -d -p 3000:3000 <image_id>
      docker ps
      # docker run -dp 127.0.0.1:3000:3000 hotfix
      docker compose up
