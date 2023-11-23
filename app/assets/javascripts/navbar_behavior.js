// app/assets/javascripts/navbar_behavior.js
document.addEventListener('DOMContentLoaded', function() {
  var navbarIcon = document.getElementById('navbarIcon');
  var offcanvasNavbar = document.getElementById('offcanvasNavbar');

  navbarIcon.addEventListener('click', function() {
    if (offcanvasNavbar) {
      var offcanvas = new bootstrap.Offcanvas(offcanvasNavbar);
      offcanvas.toggle();
    }
  });
});
