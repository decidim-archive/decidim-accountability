// = require jquery.browser
// = require_self

$(() => {
  /* Show category list on click when we are on a small scren */
  if ($(window).width() < 768) {
    $('.category--section').click((e) => {
      $(e.currentTarget).next('.category--elements').toggleClass('active');
    });
  }
})
