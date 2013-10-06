crypto  = require('crypto')

class exports.Client

  @URL_PREFIX = 'http://api.url2png.com/v6/'
  
  constructor: (@apiKey, @privateKey, @options = {}) ->
    @validateOptions()

  validateOptions: ->
    throw new Error('apiKey required') unless @apiKey
    throw new Error('privateKey required') unless @privateKey
    
    if @options.viewport && (typeof(@options.viewport) != 'string' || !@options.viewport.match(/\d+x\d+/)) 
        throw new Error("viewport should be a string with the format \"{width}x{height}\"")  
    
    if @options.fullpage && typeof(@options.fullpage) != 'boolean'
        throw new Error('fullpage should be a boolean')

    if @options.thumbnail_max_width && typeof(@options.thumbnail_max_width) != 'number'
        throw new Error('thumbnail_max_width should be a number in pixels')  

    if @options.delay && typeof(@options.delay) != 'number'
        throw new Error('delay should be a number in seconds')

    if @options.force && typeof(@options.force) != 'boolean'
        throw new Error('force should be a boolean')  

    if @options.say_cheese && typeof(@options.say_cheese) != 'boolean'
        throw new Error('say_cheese should be a boolean, not ' + typeof(@options.say_cheese))  

  getApiUrl: (url) ->
    throw new Error('url required') unless url

    if typeof url != 'string' 
      throw new Error('url should be of type string (something like www.google.com)')  
        
    query = url: url
    
    for option of @options
      query[option] = @options[option]

    queryString = ''

    # this puts keys in alphabetical order
    for key of query
      v = query[key]
      queryString += "&#{key}=#{encodeURIComponent(v)}" if v?.toString().trim().length > 0
    
    token = crypto.createHash('md5').update(queryString + @privateKey).digest('hex')

    "#{Client.URL_PREFIX}#{@apiKey}/#{token}/png/?#{queryString}"
  


  

