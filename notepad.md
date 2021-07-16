## conversation naming convention:
    item_id-user1_id-user2-id, where:
        user1 is the user that posted the item
        user2 is the user that messaged user1 through the item listing


## creating a conversation:
    -when user2 clicks item listing, it should create a conversation instance with name item_id-user1_id-user2-id; if it already exists, just redirect to that conversation

## for starting redis server as service:
    run 'sudo service redis-server start'

## for heroku redis:
    1. run: heroku addons:create heroku-redis:hobby-dev
    2. also, set config vars in heroku: REDIS_PROVIDER = REDIS_URL
    3. then restart heroku

## bugs to fix:
    1. when user is not logged in, clicking a listing with comments returns an error
    
    2. when an exchange happened in a conversation, sometimes clicking on another conversation and clicking back to the previous conversation, the previous conversation doesn't show the recent exchange

    3. after subscribing to a conversation, clicking a link other than the conversation links does not unsubscribe the user in the current conversation channel; clicking kalakalph which redirects the user to root should terminate the channel subscription


