/**
* Template Name: Valera
* Updated: Mar 10 2023 with Bootstrap v5.2.3
* Template URL: https://bootstrapmade.com/valera-free-bootstrap-theme/
* Author: BootstrapMade.com
* License: https://bootstrapmade.com/license/
*/
(function() {
  console.log('hh')
  function showSpinner() {
    document.getElementById('spinner').style.display = 'block';
    document.getElementById('cst-tab').style.display = 'none';
  }

  function hideSpinner() {
    document.getElementById('spinner').style.display = 'none';
    document.getElementById('cst-tab').style.display = 'block';
  }
  
  window.onload = function () {
    document.getElementById('cst-tab').style.display = 'none';
    
    setTimeout(function () {
      hideSpinner();
    }, 2000);
  };

})()