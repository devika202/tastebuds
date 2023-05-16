// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require my_validation_script
require("popper.js/dist/umd/popper.min")
import 'bootstrap';
import 'bootstrap/dist/js/bootstrap.bundle';
import "@hotwired/turbo-rails"
import "controllers"


import jquery from 'jquery';
window.$ = window.jquery = jquery;

document.addEventListener("DOMContentLoaded", function() {
    var dropdowns = document.querySelectorAll(".dropdown-toggle");
    dropdowns.forEach(function(dropdown) {
      new bootstrap.Dropdown(dropdown);
    });
  });
  
  import { Application } from "@hotwired/stimulus"

  const application = Application.start()
  
  // Configure Stimulus development experience
  application.debug = false
  window.Stimulus   = application
  
  export { application }
  

  $('.dropdown-toggle').dropdown();


  tinymce.init({
    selector: 'textarea',
    plugins: 'link image code',
    toolbar: 'undo redo | bold italic | alignleft aligncenter alignright | code'
  });