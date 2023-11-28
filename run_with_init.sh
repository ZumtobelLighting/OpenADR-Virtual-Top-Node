#!/bin/bash

# init only once
if [ ! -f config/initializers/secret_token.rb ]
then
    bundle exec rake db:setup
    bundle exec rake assets:precompile
    
    TOKEN=`bundle exec rake secret`
    
    cat >config/initializers/secret_token.rb <<EoF
# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

# generate a token by running: rake secret
# replace 'place token here' with the output from the command above
Oadr::Application.config.secret_token = '$TOKEN'
EoF

fi

bundle exec rails s
