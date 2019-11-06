$(document).ready(function() {
  $("#open").on("click", function() {
    $("#popup").fadeIn("slow");
    $(".popup-overlay").fadeIn("slow");
    $(".popup-overlay").height($(window).height());
    return false;
  });

  $("#close").on("click", function() {
    $("#popup").fadeOut("slow");
    $(".popup-overlay").fadeOut("slow");
    return false;
  });

  $(".dropdown-submenu a.test").on("click", function(e) {
    $(this)
      .next("ul")
      .toggle();
    e.stopPropagation();
    e.preventDefault();
  });
});
