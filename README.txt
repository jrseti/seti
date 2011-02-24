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

If you are on windows and do not have sqllite previously installed, go here: http://www.sqlite.org/download.html and grab:
	1. sqlite-shell-win32-x86-3070500.zip
	2. sqlite-dll-win32-x86-3070500.zip
	3. sqlite-analyzer-win32-x86-3070500.zip

	or the latest versions of those files.

Extract them and place all files into your ruby/bin dir.


rake db:migrate
rails server

Then point your browser to http://localhost.seti.hg94.com:3000/

Then log in using your Facebook credentials

If you get this error:
SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed

If you are also running Ruby 1.9.x then there is a monkeypatch that may fix this issue. In the root rails dir there is a file named monkeypatch. Copy this file into rails/config/initializers. Then rename it to have a .rb extension. 

restart the rails server. and try again. If it works then...

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