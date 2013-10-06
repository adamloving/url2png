assert = require('assert')
Client = require('./client').Client

# to run this test: 
# mocha --compilers coffee:coffee-script test.coffee

describe 'Server Slide model', ->
  @timeout(10000)

  it 'should be constructable', ->
    assert new Client('API_KEY', 'PRIVATE_KEY')

  it 'should generate URL given viewport, say_cheese, and unique parameters', ->

    client = new Client(process.env.URL2PNG_APIKEY, process.env.URL2PNG_SECRET,
      viewport: '1024x768'
      unique: 'something'
      say_cheese: true
    )

    console.log 'getApiUrl', client.getApiUrl('http://url2png.com/tests/say_cheese-wait-for-images/')
    assert client.getApiUrl('http://www.google.com')