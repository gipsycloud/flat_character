document.addEventListener("DOMContentLoaded", function () {
  if (document.body.classList.contains('homes-room_detail')) {
    $('#reserve').on("click", function (event) {
      event.preventDefault();
      $('span.validation').remove();
      var room_type = document.getElementById('room_type').getAttribute('data-value');
      var room_price = document.getElementById('room_price').getAttribute('data-value');
      var service_fee = document.getElementById('service_fee').getAttribute('data-value');
      var sum = parseInt(room_price) + parseInt(service_fee);
      var start_date = $('#start_date').val();
      var end_date = $('#end_date').val();
      if (start_date < 1) {
        $('#start_date').after('<span class="text-sm text-red-800 validation">*Please choose start date</span>');
        return false;
      }

      if (end_date < 1) {
        $('#end_date').after('<span class="text-sm text-red-800 validation">*Please choose end date</span>');
        return false;
      }

      let formdata = {
        room_id: $('#room_id').val(),
        room_type: room_type,
        service_fee: service_fee,
        start_date: start_date,
        end_date: end_date,
        price: room_price,
        total: sum,
        customer_phone: $('#customer_phone').val(),
      }
      // save localstorage
      localStorage.setItem('formdata', JSON.stringify(formdata));
      window.location.href = '/web/reserve';

      console.log(room_price, service_fee);
      console.log(sum);



      // $.ajax({
      //   type: "POST",
      //   url: $('#room_checkout').attr('action'),
      //   data: $('#room_checkout').serialize(),
      //   dataType: "json",
      //   success: function (response) {
      //     console.log('success', response);
      //   },
      //   error: function (jqXHR, textStatus, errorThrown) {
      //     alert(jqXHR.status);
      //     alert(textStatus);
      //     alert(errorThrown);
      //   }
      // });

    });
  }
});

document.addEventListener("DOMContentLoaded", function () {
  if (document.body.classList.contains('properties-reserve')) {
    let formdata = JSON.parse(localStorage.getItem('formdata'));
    if (formdata) {
      $('#room_id').val(formdata.room_id);
      $('#room_type').val(formdata.room_type);
      $('#start_date').text(formdata.start_date);
      $('#end_date').text(formdata.end_date);
      $('#price_input').val(formdata.price);
      $('#total_input').val(formdata.total);
      $('#customer_phone').val(formdata.customer_phone);
    }
  }
});


//   $.ajax({
//     type: "POST",
//     url: $('#room_checkout').attr('action'),
//     data: $('#room_checkout').serialize(),
// });
