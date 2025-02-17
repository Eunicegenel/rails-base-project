## conversation naming convention:
    item_id-user1_id-user2-id, where:
        user1 is the user that posted the item
        user2 is the user that messaged user1 through the item listing


## creating a conversation:
    -when user2 clicks item listing, it should create a conversation instance with name item_id-user1_id-user2-id; if it already exists, just redirect to that conversation

## for starting redis server as service:
    run 'sudo service redis-server start'

## active storage
    1. rails active_storage:install
    2. rails db:migrate
    3. update storage.yml:
        test:
            service: Disk
            root: <%= Rails.root.join("tmp/storage") %>

        local:
            service: Disk
            root: <%= Rails.root.join("storage") %>
    4. update config/environments/development.rb:
        config.active_storage.service = :local
    5. update config/environments/test.rb:
        config.active_storage.service = :test

## imagemagick install
    run: sudo apt-get install imagemagick

## to copy master.key contents to heroku
    run: heroku config:set RAILS_MASTER_KEY=`cat config/master.key`

## bugs to fix:
    1. after subscribing to a conversation, clicking a link other than the conversation links does not unsubscribe the user in the current conversation channel; clicking kalakalph which redirects the user to root should terminate the channel subscription

    2. timestamp not working for newly sent messages but refreshing the page fixes it
        - maybe time interval between two consecutive messages should be calculated in the background job

    3. if a user who participated in any conversation is deleted, app gets an error in displaying conversation partners

    4. when attempting to create or update a listing with validation errors; validation errors don't appear

    5. No button to redirect to home when user is not signed in
    
    6. Chat avatar is late to appear when a message is sent

    7. (not a bug) create and delete of transaction is kinda hacky; can't make nested forms work so resorted to the workaround for now

    8. listings fail to edit in production
## minor details to add:
    1. add channel broadcast when item's status is changed
    2. deleting listing should prompt a verification modal
    3. entire conversation history between 2 users should not be loaded all at once when visiting a conversation show page
    4. in user's profile page, items should be grouped in terms of status

## major details to add:
    1. pagination in root page
    2. proper user profile page layout