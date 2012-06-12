# Spree Gift Sendgrid extension

The Spree sendgrid extension enables the use to express prferences for mail communications and subscribe to alerts and newsletters, being sent by sendgrid

## Installation

1. Add the following to your Gemfile

<pre>
    gem 'spree_sendgrid'
</pre>

2. Run `bundle install`

3. To setup the asset pipeline includes and copy migrations run: `rails g spree_sendgrid:install`


## Functions

1. Users with an account

They can opt-in / out to receive generic newsletter
They can opt-in / out to receive availability alerts, e.g. when shipping to a new state becomes available
They can opt-in / out to receive updates when new products become available

2. Users without an account

They can subscribe to receive the generic newsletter (from the homepage)
They can unsubscribe from within the newsletter
When they create an account, their existing subscription is ported over to the account, where they can consequently manage it


## Setup

1. Create recipients lists

In order to setup the sendgrid lists, use this piece of code. It will create on list for each notification type and environment.

<pre>
	require 'gatling_gun'
	sendgrid = GatlingGun.new("login", "password")
	environments = ['production','staging','development']
	kinds = ['newsletter', 'availability', 'new_product']

	environments.each do |env|
	 kinds.each do |kind|
	  response = sendgrid.add_list("#{kind}_#{env}")
	 end
	end
</pre>
