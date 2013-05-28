$("#create_new_disorder").click(function() {
  $.post("/disorders/new", function(data) {
    var results = data("results")
  };
};