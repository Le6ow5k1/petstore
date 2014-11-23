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
petstore = Petstore.new(timeout: 2)
```

## Usage

```ruby
petstore = Petstore.new

# Get pet by id
petstore.pet.get 1

# Find pets by status
petstore.pet.find_by_status :sold

# Find pets by tags
petstore.pet.find_by_tags [:cat, :dog]

# Add new pet to the store
petstore.pet.create { id: 1, name: 'Ratmir', status: 'available'}

# Replace (update) an existing pet
petstore.pet.replace { id: 1, category: { id: 0, name: 'cats'}, name: 'Ratmir',
                    tags: [{ id: 0, name: 'Gypsy'}], status: 'pending'}

# Update some attributes of an existing pet
petstore.pet.update 1, status: 'sold'

# Delete pet
petstore.pet.delete 1
```

## Contributing

1. Fork it ( https://github.com/Le6ow5k1/petstore/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
