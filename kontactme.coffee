submitForm = (className, key, options) ->
  className = ".#{className}"
  $.ajax
    url: "http://kontactme.com/applications/#{key}/messages.json"
    type: "POST"
    data:
      message:
        email: $("[name=email]", className).val()
        content: $("[name=content]", className).val()
        title: $("[name=title]", className).val()
      domain: window.location.hostname
    success: (response) ->
      options.success(response) if options.success
    error: (error) ->
      options.error(JSON.parse(error.responseText).errors) if options.error
  false

$.fn.kontactme = (key, options) ->
  @each (i) ->
    className = "kontactMe#{i}"
    $(@).addClass className
    $(@).on "submit", -> 
      submitForm(className, key, options)