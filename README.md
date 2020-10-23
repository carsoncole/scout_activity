# ScoutActivity

ScoutActivity is a Ruby on Rails application for helping Scout troops solicit and poll for interest in Scouting acitivities. Parents and Scouts can be asked to enter their own ideas, which can then be voted on by everyone.

## Features

* Activity authoring, viewing and voting
* Vote tallying and showing ranking of activities


## Installation

The application is configured to be hosted on Heroku, but can be hosted anywhere. The following ENV variables for sending forgotten password emails must be populated in a production environment:

```ruby
ACTION_MAILER_SMTP_ADDRESS
ACTION_MAILER_SMTP_USER_NAME
ACTION_MAILER_SMTP_PASSWORD
```

In development, you need to use Rails secure credentials and have a`credentials.yml.enc` file with the following:

```ruby
email:
  address: smtp.gmail.com
  user_name: username
  password: password
```

