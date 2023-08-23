# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Dependencies
    * Ruby 2.6.5
    * postgresql 14.8
* How to setup
    1. Clone the repository: Begin by cloning the repository to your local machine using Git.
    2. Start PostgreSQL: Start the PostgreSQL database server by running the pg_ctl start command in your terminal.
    3. Install dependencies: Install the required dependencies for the application by running the bundle install command in your terminal. This will install any missing gems that are required by the application.
    4. Run database migrations: Initialize the database by running the rails db:migrate command in your terminal. This will create the necessary database tables and schema for the application.
    5. Edit .env file: Edit the .env file to make sure you have all necessary variables. The file should contain the following variables:
        ```
        HOST=https://test_host.app
        SHOPIFY_API_KEY=your_api_key
        SHOPIFY_API_SECRET=your_api_secret
        DB_USERNAME=
        DB_PASSWORD=
        ```
    6. start the service: Start the service by running bundle exec rails.
    7. Use ngrok: 
       1. Use [ngrok](https://ngrok.com/) to get a public HTTPS for the local server by running `./ngrok http 3000`
       2. Copy the url generatined in step 1 and past it as the `HOST` in `.env` file
       3. Update the `App URL` and `Allowed redirection URL(s)` in your Shopify app settings.
    9. start the service: Start the service by running `bundle exec rails s`.
    

Now you're ready to use the application.