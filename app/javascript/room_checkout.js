document.addEventListener("DOMContentLoaded", function() {
  if (document.body.classList.contains('homes-room_detail')) {
    // $('#room_price').text();
    var room_price = document.getElementById('room_price').getAttribute('data-value');
    var service_fee = document.getElementById('service_fee').getAttribute('data-value');
    var sum = parseInt(room_price) + parseInt(service_fee);
    console.log(room_price , service_fee);
    console.log(sum);

    $('#checkout').on("click", function (event) {
      event.preventDefault();
      console.log('click');
      $('#price-input').val(room_price);
      $('#total-input').val(sum);
      $.ajax({
        type: "POST",
        url: $('#room_checkout').attr('action'),
        data: $('#room_checkout').serialize(),
        dataType: "json",
        success: function (response) {
          console.log('success', response);
        },
        error: function (xhr, status, error) {
          console.log('error', error);
        }
      });
    });
  }
});