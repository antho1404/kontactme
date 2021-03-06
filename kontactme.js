// Generated by CoffeeScript 1.6.3
(function() {
  var submitForm;

  submitForm = function(className, key, options) {
    if (options == null) {
      options = {};
    }
    className = "." + className;
    $("" + className + " input[type=submit]").attr({
      disabled: true
    });
    $.ajax({
      url: "http://kontactme.com/applications/" + key + "/messages.json",
      type: "POST",
      data: {
        message: {
          email: $("[name=email]", className).val(),
          content: $("[name=content]", className).val(),
          title: $("[name=title]", className).val(),
          name: $("[name=name]", className).val()
        }
      },
      success: function(response) {
        $("" + className + " input[type=submit]").attr({
          disabled: false
        });
        $(className)[0].reset();
        if (options.success) {
          return options.success(response, $("form" + className));
        }
      },
      error: function(error) {
        $("" + className + " input[type=submit]").attr({
          disabled: false
        });
        if (options.error) {
          return options.error(JSON.parse(error.responseText).errors, $("form" + className));
        }
      }
    });
    return false;
  };

  $.fn.kontactme = function(key, options) {
    return this.each(function(i) {
      var className;
      className = "kontactMe" + i;
      $(this).addClass(className);
      return $(this).on("submit", function() {
        return submitForm(className, key, options);
      });
    });
  };

}).call(this);
