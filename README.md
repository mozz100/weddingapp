Weddingapp
==========

A Ruby on Rails application, free and open source, to help you run
a small 'wedsite' (that's a website about a wedding, in case you didn't know).

It's easy to deploy and customise, but you'll need to know about setting up websites,
or get someone who does know to help you out.

Once you have it up and running, it contains a CMS (content management system) called
Refinery, which means you can create pages, edit the text, upload images and so on.

It'll also let you manage RSVPs from your guests.

Getting Started
===============

1. Clone the source code from github.  Then run `bundle install`.
2. Strongly recommended: use Ruby 1.9.3 and rvm
3. Set up database and edit your copy of `config/databases.yml` - you need to provide details
for the 'production' database
4. `RAILS_ENV=production rake db:create` (if you need to)
5. `RAILS_ENV=production rake db:migrate db:seed`
6. Read the "Customisation" section


Customisation
=============

First, look in the file `config/initializers/custom.rb`.  You need to set at least the name of the whole site.
You should also put other configuration in this file. For instance, to be able to send emails, your site will 
almost certainly need valid credentials for an SMTP server.

**To add/edit pages, pictures and things**

Use the Refinery CMS - it lets you do exactly this.  The first time you hit it with your browser, if it's correctly configured, it invites you to 
create a user.

**To change the colour scheme**

Add Twitter Bootstrap overrides in `app/assets/stylesheets/bootstrap_and_overrides.less`.

**More control over Javascript, CSS**

Inject anything into the `<head>` tag of every page by creating and then editing `app/views/custom/_head.html.erb`.

**To change the layout completely**

See `app/views/refinery`.  Beyond that - you've got the source code, knock yourself out!  If you improve
things, please share your improvements with the community.

Getting Help
=============

TODO.  Mention bugs vs. set up assistance

Licence
=======

<a rel="license" href="http://creativecommons.org/licenses/by-sa/2.0/uk/"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/2.0/uk/88x31.png" /></a><br />This work by <span xmlns:cc="http://creativecommons.org/ns#" property="cc:attributionName">Richard Morrison</span> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/2.0/uk/">Creative Commons Attribution-ShareAlike 2.0 UK: England &amp; Wales License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="https://github.com/mozz100/weddingapp" rel="dct:source">github.com</a>.
