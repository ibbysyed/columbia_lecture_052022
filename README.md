
# Columbia Lecture

This repository is supposed to go along with a lecture that
I am delivering at Columbia university on all of the data
jobs that are possible in the space.

### Structure
Basically, each of the folders is *supposed* to be for each of the 
slides. Data engineering is complete, and as long as you install each 
of the items that are in the import files, you'll be fine. Data science 
and analytics engineering are also fine, and data analysis is basically
just hooking up metabase to the events table that we've created, which is fine


### Data Engineering

Make sure that you have postgresql installed and running (I would suggest https://postgresapp.com) 
as the way to handle the postgres installation, and make sure the server is running at 5431 (or change it
in the notebooks themselves), and pip install all of the headers (not including a requirements.txt file)
>
The file itself uses https://github.com/andresionek91/fake-web-events/tree/master/fake_web_events, an amazing
repo for making fake events. I've customized it a little to have events similar to a "Netflix" style business,
and if you look at the other files that are in the module, you can see the changes that I made. It's really easy
to add a new class to the file system. 

### Analytics Engineering

For this one, the best way to run the file post running the data engineering script, and just copy it sraight into 
PgAdmin. You can also run it in psql if you want to, but I find that that is harder to show people how to do. 

### Data science

This is just a regular notebook, and does some simple analytics

### Data analysis

Install yourself metabase. https://www.metabase.com/docs/latest/operations-guide/running-metabase-on-docker.html
will show you how to do it, it's really straightforward to run in a docker container. When metabase asks for the host, 
make sure that you put it to host.docker.internal, because localhost isn't going to work. 