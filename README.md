# Hacktoberfest

## Features

* Static pages
* Airtable backed events and FAQs
* Issue discovery by language
* Log in with GitHub
* Multi-step registration
* Pull request timeline
* Challenge completion validation
* Prize distribution

## Components

There are three major components that are entirely separate from one another:

1. Issue discovery - Fetches issues from GitHub with the label `hacktoberfest` and persists them in the database to be featured on the homepage based on a randomized quality filter.

2. Content pages - Primarily static pages that are supplemented with dynamic data from Airtable.

3. Participant management - Allows users to register to participate in Hacktoberfest, tracks user progress, and distributes prizes based on availability. The majority of the business logic is implemented with a state machine, validating that various conditions are met before a user may be transitioned to a new state and with certain actions being triggered on successful state transitions.


## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Ensure your os is the latest MacOS

- Have brew installed (Run the following command in a mac os terminal to install):

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

## Application Setup

1) [Install and Setup](#installing)
2) [Setup Oauth Token](#setup-oauth-token)
3) [Configure remaining environment variales](#env-variables)
4) [Create first user](#create-first-user)
5) [Import Projects](#import-projects)

### Installing

Clone the repo:

```
git clone https://github.com/raise-dev/hacktoberfest
```

In your local repository, run script/setup, which will install all necessary dependencies for you:

```
script/setup
```

### Setup Oauth Token

Hacktoberfest uses `GITHUB_CLIENT_ID` & `GITHUB_CLIENT_SECRET` variables to configure OmniAuth.

This allows users to be authorized for Hacktoberfest via Github.

For this, you will have to create a Github OAuth App (https://developer.github.com/apps/building-oauth-apps)

Be sure your OAuth app is configured with the following URLs

![Oauth Config](https://user-images.githubusercontent.com/7976757/66855839-fd259980-ef51-11e9-808b-26a9251841bf.png)

> Homepage URL: `http:///localhost:3000`\
> Authorization callback URL: `http:///localhost:3000/auth/github/callback`

The Client ID and Client Secret are right above this configuration. Use them to set the following ENV variables: 

```
GITHUB_CLIENT_ID=
GITHUB_CLIENT_SECRET=
```

### ENV Variables

#### Start Date & End Date

Hacktoberfest is officially active from October 1st - October 31st (in any timezone)

The app can be in three different states:

* Pre-launch 
  - Users can sign up and all pages are reachable, but the profile page is not yet tracking pull requests
* Active
  - All pages are active and the profile is tracking PRs
* Finished
  - Hacktoberfest has declared its winners

So your dates can look something like this if you're developing in October 2019 and you want the app in the Active state.

```bash
 START_DATE="2019-09-30 10:00:00 UTC"
 END_DATE="2019-11-01 12:00:00 UTC"
```

(These timestamps account for the furthest positive UTC offset (+14 in Kiribati), where they’ll see 1st Oct 00:00 on 30th Sept 10:00 UTC and the furthest negative UTC offset (-12 in the US Outlying Islands), where they’ll see 1st Nov 00:00 on 1st Nov 12:00 UTC).

If you want to work on the app in the `Pre-Launch` state, set the start date to a future date.
If you want to work on the app in the `Finished` state, set the end date to a past date.

#### Airtable API Key & Airtable App ID

Hacktoberfest uses Airtable as a CMS to hold useful data such as:
  - Events
  - FAQ
  - Spam Repositories

For your convenience we have created two options:

##### Create an Airtable Database:

We created a read-only copy of what the Airtable database should look like.

With this you can create your own schema by following this format:
(https://airtable.com/shrqM142bVC1Gj2t8)

After you’ve created and configured the schema of an Airtable base from the graphical interface,

your Airtable base will provide its own API to create, read, update, and destroy records.

You should update these variables accordingly in your `.env`

##### Use Placeholder Airtable Service

If configuring your own Airtable schema does not sound like your cup of tea - don't fret.

We have created placeholder service objects that will render test data if your Airtable keys are not set.

This service will be used as default.

You can find this service in `app/services/airtable_placehoder_service.rb`

### Create First User

1) Spin up the server by running `script/server`

2) Now, open your browser of choice and visit `localhost:3000`

3) Click `START HACKING` on the top right of the navigation bar

![start hacking](https://user-images.githubusercontent.com/7976757/66863220-8e9c0800-ef60-11e9-8100-87af508fdf3d.png)

4) Log in with your github account

5) Agree to the terms and conditions and continue

### Import Projects

This task imports repositories to the hacktoberfest app(these are displayed on the homepage). If you don't run the task, there simply won't be any repositories on the homepage aside from the hard-coded climate change repos.

1) Spin up sidekiq:

```
script/sidekiq
```

2) In a separate terminal window, run the import script:

```bash
bin/rails github:fetch_popular_languages_projects
```

## Running the project

There are two commands you will need for running the project.

First, spin up the rails server locally:

```
script/server
```

If you will be running any background jobs through sidekiq, run the following command in a separate terminal window from `script/server` which will spin up both redis and sidekiq:

```
script/sidekiq
```

## Contributing

Hacktoberfest is open source and we welcome contributions. See [CONTRIBUTING.md](/CONTRIBUTING.md) for more info.

## Code of Conduct

This project uses the Contributor Covenant Code of Conduct. See [CODE_OF_CONDUCT.md](/CODE_OF_CONDUCT.md) for more info.

## Credits

The Hacktoberfest app is built and maintained for DigitalOcean by developers from [Raise.dev](https://raise.dev).

## License

Licensed under the [MIT License](http://en.wikipedia.org/wiki/MIT_License).
The full license text is available in [LICENSE.md](/LICENSE.md).
