# Simple Delayed Job Recipe 

The purpose of this recipe is to stop and start a delayed job process that is running in your rails app.

It looks for the node app_directory, to know where you deployed your app.

It looks for the node application, to know the name of the app.

Then it runs

    script/delayed_job stop RAILS_ENV=production
    
    script/delayed_job start RAILS_ENV=production
    
    
To recycle your job serivce