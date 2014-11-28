# Petstore

Ruby client for the Pet Store sample API http://petstore.swagger.wordnik.com

## Installation

Add this line to your application's Gemfile:

    gem 'petstore', git: 'git@github.com:Le6ow5k1/petstore.git'

And then execute:

    $ bundle

## Configuration

```ruby
# Through a configure block
Petstore.configure |config|
  # set timeout for requests for 2 seconds
  config.timeout = 2
end

# or you can pass options directly when creating an endpoint
petstore = Petstore.new(timeout: 2, url: 'http://my_petstore_host.com/api')
```

## Usage

```ruby
require 'petstore'

petstore = Petstore.new
pets = petstore.pets

# Get pet by id
pets.get 1

# Find pets by status
pets.find_by_status :sold

# Find pets by tags
pets.find_by_tags [:cat, :dog]

# Add new pet to the store
pets.create id: 1, name: 'Ratmir', status: 'available'

# Replace (update) an existing pet
pets.replace id: 1, category: { id: 0, name: 'cats'}, name: 'RinTinTin'

# Update some attributes of an existing pet
pets.update 1, status: 'sold'

# Delete pet
pets.delete 1

# Upload image
pets.upload_image 'path_to_image.jpg'
```

## Handling Errors

There are 4 kinds of errors that can be raised while invoking methods on resources. They corresponds to the status codes returned from API.

* `Petstore::Errors::NotFound`
* `Petstore::Errors::InvalidRequest`
* `Petstore::Errors::NotAllowed`
* `Petstore::Errors::ServerError`

```ruby
pets.get 696
# => Petstore::Errors::NotFound: Pet not found
```

