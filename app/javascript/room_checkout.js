document.addEventListener("DOMContentLoaded", function () {
  if (document.body.classList.contains('homes-room_detail')) {
    // $('#room_price').text();
    var room_price = document.getElementById('room_price').getAttribute('data-value');
    var service_fee = document.getElementById('service_fee').getAttribute('data-value');
    var sum = parseInt(room_price) + parseInt(service_fee);
    console.log(room_price , service_fee);
    console.log(sum);

    $('#checkout').on("click", function (event) {
      event.preventDefault();

      var room_price = document.getElementById('room_price').getAttribute('data-value');
      var service_fee = document.getElementById('service_fee').getAttribute('data-value');
      var sum = parseInt(room_price) + parseInt(service_fee);
      var start_date = $('#start_date').val();
      var end_date = $('#end_date').val();
      $('#price-input').val(room_price);
      $('#total-input').val(sum);
      if (start_date < 1){
        $('#start_date').after('<span class="text-sm text-red-800">*Please choose start date</span>');
        return false;
      }

      if (end_date < 1){
        $('#end_date').after('<span class="text-sm text-red-800">*Please choose end date</span>');
        return false;
      }
      
      console.log(room_price , service_fee);
      console.log(sum);
      $.ajax({
        type: "POST",
        url: $('#room_checkout').attr('action'),
        data: $('#room_checkout').serialize(),
        dataType: "json",
        success: function (response) {
          console.log('success', response);
        },
        error: function(jqXHR, textStatus, errorThrown) {
          alert(jqXHR.status);
          alert(textStatus);
          alert(errorThrown);
        }
      });
    });
  }
});