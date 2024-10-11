document.addEventListener("DOMContentLoaded", function() {
  if (document.body.classList.contains('homes-room_detail')) {
    var room_price = document.getElementById('room_price').getAttribute('value');
    var service_fee = document.getElementById('service_fee').getAttribute('value');
    var sum = parseInt(room_price) + parseInt(service_fee);
    console.log(sum);
    setInterval(function() {
        document.getElementById('total').innerHTML = sum;
        // location.reload();
      }, 1000);
    
  }
});

// setTimeout(function() {
//   document.getElementById('total').innerHTML = sum;
//   // location.reload();
// }, 1000);

// b = parseFloat($('#b').val()).toFixed(2);
// console.log('roomprice = ' + room_price, 'servicefee = ' + service_fee);
// alert(sum);