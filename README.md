![image](https://user-images.githubusercontent.com/15303963/84329869-3dc6c880-ab5c-11ea-9cff-37a78887e75b.png)

<div align="center"><strong>Start your next Rails 6 + GraphQL API project in seconds</strong></div>

![Github Actions badge](https://github.com/loopstudio/rails-graphql-api-boilerplate/workflows/Tests%20and%20Linters/badge.svg)
[![Codebeat badge](https://codebeat.co/badges/05ab59ff-1c2e-4d80-af7f-3d6b92ad8513)](https://codebeat.co/a/loopstudio/projects/github-com-loopstudio-rails-graphql-api-boilerplate-master)

<sub> Created and maintained with ❤️ by <a href="[https://loopstudio.dev/](https://loopstudio.dev/)">LoopStudio</a> </sub>

<div align="center">A foundation with a focus on performance and best practices</div>

## Table of Contents

- [Main Characteristics](#main-characteristics)
- [Other Gems](#other-gems)
- [Getting Started](#getting-started)
- [Code quality](#code-quality)
- [Tests](#tests)
- [Graphiql](#graphiql)
- [Pagination](#pagination)
- [Continuous Deployment](#continuous-deployment)
- [Contributing](#contributing)
- [License](#license)

## Main Characteristics

- Language: Ruby 2.7.2+
- Framework: Rails 6.1.1+
- Query language: GraphQL 1.12.2+
- Webserver: Puma
- Test Framework: RSpec
- Databases: Postgres & Redis
- Async Processor: Sidekiq

## Other Gems

#### dotenv-rails
For environment variables.

#### graphql
For the implementation of [GraphQL](https://github.com/rmosolgo/graphql-ruby) query language in ruby.

#### graphiql-rails
[graphiql](https://github.com/graphql/graphiql) is an interactive in-browser IDE that simplifies the testing of your API and exposes the API available mutations, queries, and subscriptions.

#### bullet
For detecting N+1 issues.

#### graphql-batch
For allowing queries to be batched to avoid the N+1 issues. You can read the documentation [Here](https://github.com/Shopify/graphql-batch#usage).

#### JWT
To generate the tokens required to authenticate we use [JWT](https://github.com/jwt/ruby-jwt).

## Getting Started

1.  Make sure that you have Rails 6, PostgreSQL, git cli, and bundle installed.
2.  Clone this repo using `git clone --depth=1 https://github.com/LoopStudio/rails-graphql-api-boilerplate.git <YOUR_PROJECT_NAME>`
3.  Update the values of the `.env.template` file to match your app
4.  Create your `.env` file. You have an example at `.env.template`. You should be able to copy it and set your own values.
    _It's a good practice to keep the `.env.template` updated every time you need a new environment variable._
5.  It is required to set the ENV variable `JWT_ENCODING_KEY` with the result of running `OpenSSL::Digest.new('sha256')` on the rails console to enable the token authentication.
6.  Run `bundle install`
7.  Run `bundle exec rake db:create`
8.  Run `bundle exec rake db:migrate`
9.  Run `bundle exec rake db:seed`
10.  Check the test are passing running `rspec`
    _At this point you can run `rails s`  and start making your API calls at `http://localhost:3000`_
11.  Edit or delete the `CODEOWNERS` file in `.github` directory
12. Edit this README file to match your project title and description
 _It's a good practice to keep this file updated as you make important changes to the installation instructions or project characteristics._
13. Delete the `.github/workflows/deploy.yml` file, and uncomment the other workflows or configure your continuous deployment workflow since you might use different environments.
14. Modify the `.github/CODEOWNERS` file

## Tests

You can run the unit tests with `rspec` or `rspec` followed by a specific test file or directory.

## Code Quality

With `rake linters` you can run the code analysis tool, you can omit rules with:

- [Rubocop](https://github.com/bbatsov/rubocop/blob/master/config/default.yml) Edit `.rubocop.yml`

  When you update RuboCop version, sometimes you need to change `.rubocop.yml`. If you use [mry](https://github.com/pocke/mry), you can update `.rubocop.yml` to the latest version automatically.

- [Reek](https://github.com/troessner/reek#configuration-file) Edit `config.reek`

Pass the `-a` option to auto-fix (only for some linters).

## Graphiql

Graphiql will be mounted on the path `/graphiql`, only if you have set the environment variable `EXPOSE_API_INSIGHTS` in `"true"`.

For example `http://localhost:3000/graphiql` if you are running your server on 3000 port.

GraphiQL does not allow us to send headers in the request so if you want to use it as a signed-in user you should get the session token and set it as the environment variables `GRAPHIQL_SESSION_TOKEN`, restart the server and then you should be good to go.

## Pagination

You can find a detailed guide on how to implement pagination [here](PAGINATION.md).

## Features

You can always check all the Mutations and Queries available by going to `/graphiql` and looking at the Docs.

### Mutations

- Sign up
- Sign in
- Update profile
- Delete user

### Queries

- Show profile

## Continuous Deployment

**This boilerplate contains commented out code for a quick Continuous Deployment setup using Github actions and deploying to the Heroku platform.**

*(If you are not using those two tools you might simply want to remove the workflows directory and disregard the rest of these instructions.)*

Since we are used to using git-flow for branching and having **three different environments (dev, staging, and production)**, this boilerplate includes three commented out files on the `.github/workflows` folder so that, when using this repo for an actual project, you can keep these environments updated simply by doing a proper use of the branches.

* **Deploy to dev**: Triggered every time `develop` branch gets pushed to. For instance, whenever a new feature branch gets merged into the develop branch.

* **Deploy to staging**: Triggered every time somebody creates (or updates) a Pull Request to master. We usually call these branches using the format: `release/vx.y.z` but it will work regardless of the branch name. We create a release Pull Request at the end of each sprint to deploy to staging the new set of changes, and we leave the Pull Request `On Hold` until we are ready to ship to production.

* **Deploy to production**: Once the staging changes are approved by the Product Owner, we merge the release branch Pull Request into master, triggering a push on the master branch which deploys to production.

For this to work you will need the configure some Secrets on your GitHub repository. To add these go to your Github project, click on `Settings`, and then `Secrets`.

You need to add the following Secrets:

* **HEROKU_EMAIL**: Email of the owner account of the Heroku apps.
* **HEROKU_API_KEY**: API Key of the owner account of the Heroku apps. Get it by going to your Heroku account, `Account Settings` and Scroll down to reveal the `API KEY`.
* **HEROKU_DEV_APP**: Name of the development app. Eg. `my-project-develop-api`
* **HEROKU_PROD_APP**: Name of the production app. Eg. `my-project-api`
* **HEROKU_STAGING_APP**: Name of the staging app. Eg. `my-project-staging-api`

### Notes on Continuous Deployment

* You can disregard and remove the `deploy.yml` file since we use it to deploy the boilerplate code itself as we work on it, but it will probably be useless to you once you clone this repo for your real-world use case.

* If you use a different branching strategy or different environments layout, simply delete the files under the workflows directory and set up your own.

## Contributing

If you've noticed a bug or find something that needs to be refactored, feel free to open an issue or even better, a Pull Request!

## License

This project is licensed under the MIT license.

Copyright (c) 2020 LoopStudio.

For more information see [`LICENSE`](LICENSE)

--------

[<img src='https://loopstudio.dev/wp-content/uploads/2019/05/logoblack.png' width='300'/>](https://loopstudio.dev)
