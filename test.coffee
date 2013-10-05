assert = require('assert')
Client = require('./client').Client

# to run this test: 
# mocha --compilers coffee:coffee-script test.coffee

describe 'Server Slide model', ->
  @timeout(10000)

  it 'should be constructable', ->
    assert new Client('API_KEY', 'PRIVATE_KEY')

  it 'should generate URL given viewport, say_cheese, and unique parameters', ->
    client = new Client('API_KEY', 'PRIVATE_KEY',
      viewport: '1024x768'
      unique: 'something'
      sayCheese: true
    )

    console.log 'getApiUrl', client.getApiUrl('http://www.google.com')
    assert client.getApiUrl('http://www.google.com')