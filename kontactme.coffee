submitForm = (className, key, options={}) ->
  className = ".#{className}"
  $("#{className} input[type=submit]").attr disabled: true
  $.ajax
    url: "http://kontactme.com/applications/#{key}/messages.json"
    type: "POST"
    data:
      message:
        email: $("[name=email]", className).val()
        content: $("[name=content]", className).val()
        title: $("[name=title]", className).val()
        name: $("[name=name]", className).val()
    success: (response) ->
      $("#{className} input[type=submit]").attr disabled: false
      $(className)[0].reset()
      options.success(response) if options.success
    error: (error) ->
      $("#{className} input[type=submit]").attr disabled: false
      options.error(JSON.parse(error.responseText).errors) if options.error
  false

$.fn.kontactme = (key, options) ->
  @each (i) ->
    className = "kontactMe#{i}"
    $(@).addClass className
    $(@).on "submit", -> 
      submitForm(className, key, options)