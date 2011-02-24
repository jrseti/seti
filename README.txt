setiQuest Explorer
==================

There are several Flex projects and a Rails project.



Rails Project
-------------

If you don't have the latest version of Ruby and Rails, then do this:

ruby -v
sudo gem update --system
ruby -v
sudo gem update


To build, run these commands in the rails directory

bundle
rake db:migrate
rails server

Then point your browser to http://localhost.seti.hg94.com:3000/

Then log in using your Facebook credentials

Then go back to the rails directory and do this:

rails console
u = User.first
u.role = :admin
u.save
exit

Now refresh your browser. You should get admin controls and be able to see the Flex app.


Flex Projects
-------------

(Instructions go here)