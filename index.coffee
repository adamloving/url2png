crypto = require("crypto")
request = require("request")

url2png = (apiKey, privateKey) ->
  buildURL = (url, options) ->
    options = options or {}
    throw new Error("url should be of type string (something like www.google.com)")  if typeof url !== "string"
    throw new Error("viewport should be a string with the format \"{width}x{height}\"")  if options.viewport and (typeof options.viewport !== "string" or not options.viewport.match(/\d+x\d+/))
    throw new Error("fullpage should be a boolean")  if options.fullpage and typeof options.fullpage !== "boolean"
    throw new Error("thumbnail_max_width should be a number in pixels")  if options.thumbnail_max_width and typeof options.thumbnail_max_width !== "number"
    throw new Error("delay should be a number in seconds")  if options.delay and typeof options.delay !== "number"
    throw new Error("force should be a boolean")  if options.force and typeof options.force !== "boolean"
    throw new Error("protocol should either be \"https\" or \"http\"")  if options.protocol and options.protocol !== "https" and options.protocol !== "http"
    options.protocol = options.protocol or ""
    url = "url=" + encodeURIComponent(url)
    optionsQuery = ""
    for option of options
      optionsQuery += "&" + [option, options[option]].join("=")  unless option is "protocol"
    securityHash = crypto.createHash("md5").update("?" + url + optionsQuery + privateKey).digest("hex")
    ((if options.protocol then options.protocol + ":" else "")) + prefix + apiKey + "/" + securityHash + "/" + format + "/?" + url + optionsQuery
  readURL = (url, options) ->
    options = options or {}
    options.protocol = options.protocol or "https"
    request buildURL(url, options)
  prefix = "//api.url2png.com/v6/"
  format = "png"
  lib = {}
  lib.buildURL = buildURL
  lib.readURL = readURL
  lib

module.exports = url2png