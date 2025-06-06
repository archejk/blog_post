# Blog Spot - Ruby on Rails Blog Application

A simple blog application built with Ruby on Rails, featuring user authentication, email notifications, and TailwindCSS styling for a modern and responsive UI.

---

## Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Installation & Setup](#installation--setup)
  - [1. Clone Repository](#1-clone-repository)
  - [2. Install dependencies](#2-install-dependencies)
  - [3. Database Set up](#3-database-set-up)
  - [4. Environment Config](#4-environment-config)
- [Run Tests](#run-tests)
- [Running the Application](#running-the-application)
- [Demo](#demo)
- [Key Changes & Development Log](#key-changes--development-log)
---

## Features
- **User Authentication** - Login/registration with Devise, Edit Profile Information with avatar upload
- **Blog Post Management** - CRUD function in blog posts
- **Feedback System** - Users can leave feedback on blog posts except their own
- **Email Notifications** - Authors receive email notifications when feedback is submitted (via SendGrid Service API)
- **Filtering & Pagination** – Filter blog posts by author and feedback presence with Kaminari gem pagination
- **Responsive Design** - Built with Tailwind CSS for a modern, mobile-friendly interface
- **Testing** - Fully tested with passing RSpec specs

---

## Tech Stack

| Layer         | Technology                                                      |
|---------------|------------------------------------------------------------------|
| Backend       | [Ruby on Rails 7.x](https://rubyonrails.org)                    |
| Database      | PostgreSQL                                                      |
| Authentication| [Devise](https://github.com/heartcombo/devise)                  |
| Emails        | [SendGrid API](https://sendgrid.com/)                           |
| Pagination    | [Kaminari Gem](https://github.com/kaminari/kaminari)                                                    |
| Frontend      | [Tailwind CSS](https://tailwindcss.com), [Stimulus JS](https://stimulus.hotwired.dev) |
| Testing       | [RSpec](https://rspec.info), [FactoryBot](https://github.com/thoughtbot/factory_bot_rails) |

---

## Prerequisites
- Ruby `3.0` or higher
- Rails `7.0` or higher
- PostgreSQL
- Node.js `16` or higher
- Yarn or npm
- Git

---

## Installation & Setup

### 1. Clone Repository
```
git clone https://github.com/archejk/blog_post.git
```

### 2. Install dependencies
```rb
# install ruby gems
bundle install

# install js javascript packages
yarn install or npm install
```

### 3. Database Set up
```rb
# create and setup db
rails db:create
rails db:migrate

# load data in the db (optional)
rails db:seed
```

### 4. Environment Config
- Create `.env` file in the root directory and add these env variables:
```rb
# database credentials
DATABASE_USERNAME=your_username
DATABASE_PASSWORD=your_password

# Sendgrid email delivery service
SENDGRID_API_KEY=your_sendgrid_api_key
```
  - refer to the documentation on how to generate API key: https://www.twilio.com/docs/sendgrid/for-developers/sending-email/getting-started-smtp
  - your_sendgrid_api_key or use this key from my test account:
  ![image](https://github.com/user-attachments/assets/f6b312da-f540-4dfa-b5af-5f057193c3cc)
---

## Run Tests
```rb
# all tests (models, controllers, etc.)
bundle exec rspec

# run specific test files
bundle exec rspec spec/models
bundle exec rspec spec/controllers
bundle exec rspec spec/mailers
bundle exec rspec spec/services
bundle exec rspec spec/helpers
bundle exec rspec spec/requests
```

---

## Running the Application
1. Start rails server
```rb
rails s
```

2. Start tailwind css watcher (in separate terminal)
```rb
rails tailwindcss:watch

# or

yarn build:css
```

3. Access the application
- Visit: http://localhost:3000

---

 ## Demo

https://github.com/user-attachments/assets/c7cca9c4-a34b-4c4a-bf95-f0f8e3ba1bfb

[BlogPost filtering and pagination.webm](https://github.com/user-attachments/assets/55516ba5-8aa6-4ccd-9708-9a139cc15ed8)

---

## Key Changes & Development Log
- Initial Commit: Create and setup Blog Post with feedback mailer
  - [View Commit ›](https://github.com/archejk/blog_post/commit/6532a80ec87f800e7ccb1e36a201eb8c6ecee042)
- UI Improvement: Integrated Tailwind CSS for responsive design
  - [View Commit ›](https://github.com/archejk/blog_post/commit/d70da34b5875f1f1771334f1343cd33d9ba50b85)
- Email Notifications: Set up email delivery via SendGrid service
  - [View PR #2 ›](https://github.com/archejk/blog_post/pull/2)
- User Authentication: Integrated Devise for registration/login
  - [View PR #4 ›](https://github.com/archejk/blog_post/pull/4)
- User Profiles: Avatar upload with Active Storage and profile management
  - [View Commit ›](https://github.com/archejk/blog_post/commit/69518f94384549de2cadfc6416b1681e90f6a709)
- Bug Fix: Ensure delete button sends correct DELETE request with Turbo
  - [View Commit ›](https://github.com/archejk/blog_post/commit/04a86044e020e3ea34d63766edb69a87d435a8c2)
- Test: Set up Unit Test Framework
  - [View Commit ›](https://github.com/archejk/blog_post/commit/ba1282f132cea6d39583593e503d16b98635623c)
- Feature: BlogPost Filtering & Pagination
  - [View PR #7 ›](https://github.com/archejk/blog_post/pull/7)

