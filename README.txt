setiQuest Explorer
==================

There are several Flex projects and a Rails project.



Rails Project
-------------

Requires Ruby 1.8.7 and Rails 3. We all work in OSX.

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

All authentication is external, and uses omniauth. We did not check in the config file, because it contains the secret keys to our apps with Facebook and Twitter. So you will need to create /rails/config/initializers/omniauth.rb, and populate it with this code:

Rails.application.config.middleware.use OmniAuth::Builder do
#  //provider :facebook, '***APP_ID***', '***APP_SECRET***', :display=>:touch
#  //provider :twitter, '***APP_ID***', '***APP_SECRET***'
  provider :openid, nil, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id', :method => :get
end

Once that's set up, launch the server:

rails server

Then point your browser to http://localhost.seti.hg94.com:3000/

Then log in using your Google credentials

If you get this error:
SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed

If you are also running Ruby 1.9.x then there is a monkeypatch that may fix this issue. In the root rails dir there is a file named monkeypatch. Copy this file into rails/config/initializers. Then rename it to have a .rb extension. 

restart the rails server. and try again.

Once you're logged in the first time, you will need to give yourself admin privileges in order to actually do anything. So go back to the rails directory and do this:

rails console
u = User.first
u.role = :admin
u.save
exit

Now refresh your browser. You should get admin controls and be able to see the Flex app.

To implement any test code, the controller test must have "login_as_administrator" in the setup block.

Flex Projects
-------------

The Flex projects require the Flex 4.5 prerelease i6 build of the Flex SDK.
