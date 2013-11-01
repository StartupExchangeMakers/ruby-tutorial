#This is supposed to be a pre-3DS intro to Rails.
#Brendan is actually the Rails expert, I really don't have that much experience
#with it, so I'm going to get you guys started and take a more conceptual approach.
#For specific questions, I'm sure if I can't help you, there is someoene here who
#can, and there is always google.

#Another great resource: http://ruby.railstutorial.org/ruby-on-rails-tutorial-book
#by Michael Hartl - this is just about all I know about RoR

# WHY RAILS?
# Rails is a RESTful MVC framework for Ruby. We will talk shortly about what this means.
# Benefits:
#	Framework, so it makes a lot of assumptions about what you want, and the core functionality is ready to go out of the box
#	Database agnostic, so no mucking with installing mysql/postgres, creating users/databases, or learning SQL
#	web server is built-in, so no installing Apache or mucking with .htaccess files
#	elegant, Rubyish structure
#	tons of 3rd party gems for handling common tasks. example: omniauth
#	Ruby language
#WHEN TO USE
#       your app is very object-oriented / data-driven
#       you want to get it up and running quickly
#       others will be working with your code
#WHEN TO NOT USE
#       you have mostly static pages, with maybe some javascript here or there
#       you want to have strong control over your database
#       your app deviates from "The Rails Way"



#Part Zero: installing
#=====================


#Windows/Mac: 
#http://railsinstaller.org/en
# installs everything you need (I think)


#Mac/Linux:
#If you don't already have Ruby, use RVM:
	curl -L https://get.rvm.io | bash -s stable
	rvm get stable
	rvm install 2.0.0
	gem update
	gem install rails
# you may also need to install a js framework, such as node.js. On ubuntu:
	sudo apt-get install nodejs

#NOTE: There is are some major differences between Rails 3.2 and Rails 4.0.
# I reccommend you learn 4.0 and don't worry about it. 



#Part One: MVC, REST, WTF?
#=========================
#REST - HTTP protocol has four commands: GET, PUT, POST, and DELETE
# these are from the dawn of websites. for a long time, GET was all anyone ever used
# then with forms, POST got a little use. You might already have some background in
# GET/POST requests. GET are in the url:
# http://example.com/mypage?attr1=val1&attr2=val2
# POST requests are in the header of the packet instead.
# REST utilizes all of these "verbs" to specify exactly what you are trying to do.
# FOR EXAMPLE: twitter.com/tweet/12345 is the url for some tweet
#	GET - just show me the tweet
#       POST - edit the tweet
#       PUT - does nothing
#       DELETE - delete the tweet
# for creating a tweet, you might use a POST request to twitter.com/tweet/new

#MVC - Model, View, Controller. A way of abstracting different data tasks.
#       MODEL- defines what data looks like. For example, a tweet object
#        has a 150 character string, a user who owns it, and a post time/date.
#        Basically the database for your data.
#       VIEW - how data is presented when requested. For example, print the tweet
#        on the screen with the profile picture to the left and the timestamp below
#       CONTROLLER - handles requests for data and manipulations of data. Example:
#        receives a POST request on tweet/new. checks that the user is logged in,
#       checks that the tweet is less than 150 characters, then sends it to the model
#        to be saved. Then decides which view to send to the browser.


#Part Two: Let's get started
#===========================
#make a new app:
	rails new testapp
#this makes all the core files and directories for you
# let's make sure it worked:
        rails server
#open a broswer to localhost:3000
#press Ctrl-C to get back to the terminal

Gemfile
#This is a list of all the gems your app uses. Notice the syntax for specifiying versions. If you need to use more gems, add them here.
#let's add Boostrap:
gem 'bootstrap-sass'
bundle update


#let's make a post object, which has just a title and a body.
#we could explicitly create the model individually:
        rails generate model post title:string body:text
# then, we'd have to migrate the database, and create a controller as well.
# instead, we can use scaffold to create everything for us. If you generated a model,
# you can undo it like so:
        rails destroy model post
#now we can generate a scaffold instead:
        rails generate scaffold post title:string body:text
#this made a model (app/models/post.rb),
#       a controller (app/controllers/posts_controller.rb), 
#       several views (app/views/posts/*.html.erb)
#       a database migration file (db/migrate/???????????_create_posts.rb)
#       and a bunch of other stuff (test files, helpers, etc)

#When you make any changes to the database (like adding a new model), you need to push those changes to the database (Called migrating)
        rake db:migrate
#test out all the stuff this did for us:
        rails s
#localhost:3000/posts
#we can also do stuff from an interactive ruby console:
        rails console
p= Post.new(title: "new post", body: "from the console")
p.save
#now Ctrl-D, rails s, refresh, and see the new post

#let's validate the input to this form. we can actually define that in the model
# (instead of javascript on the form). 
apps/models/post.rb 
  validates :body, presence: true
  validates :title, presence: true, length: { maximum: 500 }

#cool. maybe those pages could be a little prettier.
#we installed boostrap, let's include it. create a new SCSS file:
app/assets/stylesheets/custom.css.scss
        @import "bootstrap";
        a {
        font-style:italic;
        }
#we can also edit the HTML itself
app/views/posts/index.html.erb
#erb is for embedded ruby. ruby code between <%= %> prints the output to the page.
# <% %> is for ruby code to be executed (but not return a value).
# let's add some bootstrap:
<div class="container">
        ...
</div>
#now restart the server and refresh the page. notice our css has been applied

#cool. let's add some static pages as well. this will demonstrate generating controllers and whatnot by hand. First the controller
        rails generate controller StaticPages home --no-test-framework
# this made our controller app/controller/static_pages_controller.rb
# it also made our view for home. we could have given it more views to make.
# let's make our home page.
app/views/static_pages/home.html.erb
        <h1>Welcome!</h1>
        <p><%= link_to "Click here", posts_path %> to see all the posts.</p>
# rails s to see this in action. of course, http://localhost:3000/static_pages/home
# aint right, we want that on the home page (or maybe /home)

#This is where the all important routes.rb comes in. He is the REST master
config/routes.rb
#Routes decide what each url does for your application.
#notice our generate statements automatically added these lines to routes.rb
# resources :posts is the default for an object; lets the post_controller handle it
# then we have a statically defined route to static_pages/home
  root 'static_pages#home'
  match '/home', to: 'static_pages#home', via: 'get'
# now, /static_pages/home doesn't work anymore, but root and '/home' work fine

# let's take a closer look at how routing for our posts work.
app/controllers/posts_controller.rb
# notice the class has a method for every type of action that we can do to them.
# routes.rb assumes these methods exist and routes accordingly. 

#There is still a lot of Rails to be learned (particularly handling users and
# authentication), and a lot of preculiar ruby syntax for controllers and classes. 
# Still, this should be enough to get you started. I recommend going through a full
# tutorial like the one i posted at the beginning when you have time. 

# Also for you 3DSers, here is a little advice: what matters at the end of the weekend
# is the pitch. if you end up making a web app (on any platform, rails, django,
# whatever the latest JS library/framework is, etc) make it functional, but more
# important: make it pretty. It doesn't matter if it is full of security holes or
# some important functionality is missing. what you are building is a proof of concept
