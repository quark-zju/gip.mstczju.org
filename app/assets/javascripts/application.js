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
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require turbolinks_support
//
//=require foundation/modernizr.foundation
//=require foundation/jquery.placeholder
//=require foundation/jquery.foundation.alerts
// require foundation/jquery.foundation.accordion
//=require foundation/jquery.foundation.buttons
//=require foundation/jquery.foundation.tooltips
//=require foundation/jquery.foundation.forms
//=require foundation/jquery.foundation.tabs
//=require foundation/jquery.foundation.navigation
//=require foundation/jquery.foundation.topbar
// require foundation/jquery.foundation.reveal
// require foundation/jquery.foundation.orbit
//=require foundation/jquery.foundation.mediaQueryToggle
//
//  // Use remote ACE instead, do not require them here
//  require ace
//  require mode-markdown
//  require mode-textile
//
//= require_tree .

// foundation/{index,app} runs at incorrect time, use own version
var initFoundation = function() {
  var $doc = $(document),
      Modernizr = window.Modernizr;
  
  // Some browser lies about touch (e.g. chrome)
  Modernizr.touch = false;

  // Make foundation happy with turbolinks
  $('.js-generated').remove();
  $('.top-bar .has-dropdown>a').die('click.fndtn');
  $('.top-bar .toggle-topbar').die('click.fndtn');
  $('.top-bar .has-dropdown .back').die('click.fndtn');

  $.fn.foundationAlerts           ? $doc.foundationAlerts() : null;
  $.fn.foundationButtons          ? $doc.foundationButtons() : null;
  $.fn.foundationAccordion        ? $doc.foundationAccordion() : null;
  $.fn.foundationNavigation       ? $doc.foundationNavigation() : null;
  $.fn.foundationTopBar           ? $doc.foundationTopBar({index : 0, initialized : false}) : null;
  $.fn.foundationCustomForms      ? $doc.foundationCustomForms() : null;
  $.fn.foundationMediaQueryViewer ? $doc.foundationMediaQueryViewer() : null;
  $.fn.foundationTabs             ? $doc.foundationTabs({callback : $.foundation.customForms.appendCustomMarkup}) : null;
  $.fn.foundationTooltips         ? $doc.foundationTooltips() : null;

  $('input, textarea').placeholder();
}

// for turbolink
$onPageLoad(initFoundation, true);
