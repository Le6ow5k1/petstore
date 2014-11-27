Feature: Pets resource
  As a person who like pets
  I want to interact with pets resource

  Background:
    Given a petstore api endpoint

  Scenario: Get single pet
    When I call "get" method on "pets" resource with 1
    Then response should be a hash
    And response at "id" should be 1

  Scenario: Find pets by status
    When I call "find_by_status" method on "pets" resource with sold
    Then response should be an array
    Then response should have 2 entries

  Scenario: Find pets by tags
    When I call "find_by_tags" method on "pets" resource with array:
      | tag1 |
      | tag2 |
    Then response should be an array
    Then response should have 1 entry

  Scenario: Create pet
    When I call "create" method on "pets" resource with hash:
      | id   | 1   |
      | name | Rex |
    Then response should be nil

  Scenario: Replace pet
    When I call "replace" method on "pets" resource with hash:
      | id   | 2         |
      | name | RinTinTin |
    Then response should be a hash
    And response at "id" should be 2
    And response at "name" should be RinTinTin

  Scenario: Delete a pet
    When I call "delete" method on "pets" resource with 1
    Then response should be nil
