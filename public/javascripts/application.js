// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery(function($) {

  $.fn.followLink = function(){
    this.attr('href', function(){ 
      window.location = this.href;
    });
  };

  $(document).keydown(function(event) {
    switch(event.keyCode) {

      case 37:
      console.info("previous");
      $("a[rel=prev]").followLink();
      break;

      case 39:
      console.info("next");
      $("a[rel=next]").followLink();
      break;

    }
  });
  
});
