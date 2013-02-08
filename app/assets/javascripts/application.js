// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
// = require jquery
// = require jquery.masonry.min
// = require jquery.infinitescroll.min
// = require jquery.lazyload.min
// = require jquery.lettering
// = require jquery.textillate
// = require manual-trigger
// = require facebox

/**
 * Top level namespace for Jasmine, a lightweight JavaScript BDD/spec/testing framework.
 * Using https://github.com/jschr/textillate for js text animations
 *
 * @namespace
 */
var tshultz = {};
var isCommonJS = typeof window == "undefined";
if (isCommonJS) exports.tshultz = tshultz;

tshultz.initialize_cats_infinite_scroll = function() {
  // Access the single container across all jquery
  var $container = $('#container');

  // Load the images into Masonry after page completes
  $container.imagesLoaded(function(){
    $container.masonry({
      itemSelector : '.item',
      columnWidth : 240
    });
  });

  $container.infinitescroll({
    navSelector  : '#page-nav',     // selector for the paged navigation
    nextSelector : '#page-nav a',   // selector for the NEXT link (to page 2)
    itemSelector : '.item',         // selector for all items you'll retrieve
    debug : false,
    loading: {
      img: "http://i.imgur.com/qkKy8.gif",
      finishedMsg: "No more Images to load.",
        img: "http://i.imgur.com/qkKy8.gif",
        msgText: "<em>Loading Images...</em>"
      },
    },

    // trigger Masonry as a callback
    function(newElements) {
      var $newElems = $(newElements).css({opacity: 0});
      $newElems.imagesLoaded(function(){
        $newElems.animate({ opacity: 1 });
        $container.masonry('appended', $newElems, true,function() {
          console.log('completed');
        });
      });
    }
  );
};


$(document).ready(function() {
	// Remove the pre load
	$("window").load(function() {
	  $("body").removeClass("preload");
	});
	
	// Lazy load the images
  $("img.item").lazyload({ 
      effect : "fadeIn"
  });
  
  // Setup click handlers for facebook rels
  $('a[rel*=facebox]').facebox();

	// Textillate the h1 text
	$('h1.theresa').textillate({ 
		in: { effect: 'fadeInDown' } 
	});
	
	// Fade in gravatar
	$('#gravatar').delay(1000).fadeIn(1000);
});