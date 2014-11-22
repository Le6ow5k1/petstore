# Petstore

Ruby client for the Pet Store sample API http://petstore.swagger.wordnik.com

## Installation

Add this line to your application's Gemfile:

    gem 'petstore', git: 'git@github.com:Le6ow5k1/petstore.git'

And then execute:

    $ bundle

## Usage

```ruby
petstore = Petstore.new()

# GET /pet/1
petstore.pet.get 1

# GET /pet/FindByStatus?status=sold
petstore.pet.find_by_status :sold

# GET /pet/FindByTags?tags=cat,dog
petstore.pet.find_by_tags [:cat, :dog]

# POST /pet/1
petstore.pet.post { id: 1, category: { id: 0, name: 'cats'}, name: 'Ratmir',
                    tags: [{ id: 0, name: 'Gypsy'}], status: 'available'}

# PUT /pet/1
petstore.pet.put 1, { id: 1, category: { id: 0, name: 'cats'}, name: 'Ratmir',
                    tags: [{ id: 0, name: 'Gypsy'}], status: 'pending'}

# PATCH /pet/1
petstore.pet.patch 1, status: 'sold'

# DELETE /pet/1
petstore.pet.delete 1
```

## Contributing

1. Fork it ( https://github.com/Le6ow5k1/petstore/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
