var room_price = document.getElementById('room_price').getAttribute('value');
var service_fee = document.getElementById('service_fee').getAttribute('value');
var sum = parseInt(room_price) + parseInt(service_fee);
setInterval(function() {
  document.getElementById('total').innerHTML = sum;
}, 1000);

// b = parseFloat($('#b').val()).toFixed(2);
// console.log('roomprice = ' + room_price, 'servicefee = ' + service_fee);
// alert(sum);