document.addEventListener("DOMContentLoaded", function () {
  if (document.body.classList.contains('homes-room_detail')) {
    var room_price_detail = document.getElementById('room_price_detail').getAttribute('data-value');
    var default_guest_count = document.getElementById('guests-count').getAttribute('data-value');
    var service_fee = document.getElementById('service_fee').getAttribute('data-value');
    var maxPersons = document.getElementById('maxPersons').getAttribute('data-value');
    $('#room_price').text(room_price_detail);   // showing price for website
    $('#guests-count').text(default_guest_count);
    $('#total_checkout').text(parseInt(room_price_detail) + parseInt(service_fee));

    let counts = {
      adults: 1,
      // children: 0,
      // infant: 0
    };
    const maxLimits = {
      adults: parseInt(maxPersons),
      // children: 5,
      // infant: 5 
    }

    function updateCount(type, change) {
      const newCount = counts[type] + change;
      if (newCount >= 0 && newCount <= maxLimits[type]) {
        counts[type] = newCount;
        document.getElementById(`${type}-count`).textContent = counts[type];
        updateDisplayAndPricing();
      }

      function updateDisplayAndPricing() {
        document.getElementById('guests-count').textContent = `${type}` + " " + counts.adults;

        var element = document.getElementById('guests-count');
        element.setAttribute('data-value', `${type}` + " " + counts.adults);
        element.setAttribute('guest-count', counts.adults);

        var room_price_detail = document.getElementById('room_price_detail').getAttribute('data-value');
        var guest_count = document.getElementById('guests-count').getAttribute('guest-count');
        var room_price = parseInt(room_price_detail) * parseInt(guest_count);

        $('#room_price').text(room_price);   // showing price for website

        var total_checkout = document.getElementById('total_checkout');
        total_checkout.setAttribute('data-value', room_price);
        $('#total_checkout').text(room_price + parseInt(service_fee));
      }

      // if (counts[type] + change >= 0) {
      //   counts[type] += change;
      //   document.getElementById(`${type}-count`).textContent = counts[type];
      // }
      // else {
      //   counts[type] = 0;
      //   document.getElementById(`${type}-count`).textContent = counts[type];
      // }

      // document.getElementById('guests-count').textContent = `${type}` + " " + counts.adults;

      // var element = document.getElementById('guests-count');
      // element.setAttribute('data-value', `${type}` + " " + counts.adults);
      // element.setAttribute('guest-count', counts.adults);

      // var default_guest_value = document.getElementById('guests-count').getAttribute('guest-count');  // default 1
      // var room_price_detail = document.getElementById('room_price_detail').getAttribute('data-value');
      // var guest_count = document.getElementById('guests-count').getAttribute('guest-count');
      // var room_price = parseInt(room_price_detail) * parseInt(guest_count);

      // $('#room_price').text(room_price);   // showing price for website

      // var total_checkout = document.getElementById('total_checkout');
      // total_checkout.setAttribute('data-value', room_price);
      // $('#total_checkout').text(room_price + parseInt(service_fee));

    }

    // Add event listeners for buttons
    document.getElementById('decrease-adults').addEventListener('click', () => updateCount('adults', -1));
    document.getElementById('increase-adults').addEventListener('click', () => updateCount('adults', 1));

    // var room_price = document.getElementById('room_price').getAttribute('data-value');
    // var room_price_detail = document.getElementById('room_price_detail').getAttribute('data-value');
    var room_type = document.getElementById('room_type').getAttribute('data-value');
    var service_fee = document.getElementById('service_fee').getAttribute('data-value');
    var start_date = $('#start_date').val();
    var end_date = $('#end_date').val();
    // var room_price = room_price_detail.replace(/,/g, ''); // remove comma from price
    // var guest_count = document.getElementById('guests-count').getAttribute('guest-count');
    // var room_price = parseInt(room_price_detail) + parseInt(guest_count);
    // console.log(room_price + ' guest count');
    // $('#room_price').text(room_price);    // showing price for website

    $('#reserve').on("click", function (event) {
      event.preventDefault();
      $('span.validation').remove();
      // var sum = parseInt(room_price) + parseInt(service_fee);
      // var room_price_sum = parseInt(room_price) * parseInt(guest_count);
      // var service_fee_sum = parseInt(service_fee) * parseInt(guest_count);
      // var sum = room_price_sum + service_fee_sum;

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
        guest_count: guest_count,
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
    });
  }
});

document.addEventListener("DOMContentLoaded", function () {
  if (document.body.classList.contains('properties-reserve')) {
    let formdata = JSON.parse(localStorage.getItem('formdata'));
    if (formdata) {
      $('#room_id').text(formdata.room_id);
      $('#room_type').text(formdata.room_type);
      $('#guest_count').text(formdata.guest_count);
      $('#start_date').text(formdata.start_date);
      $('#end_date').text(formdata.end_date);
      $('#price_input').text(formdata.price);
      $('#total_input').text(formdata.total);
      $('#customer_phone').text(formdata.customer_phone);
    }

    $('#confirm_reserve').on("click", function (event) {
      // event.preventDefault();
      $.ajax({
        url: '/web/confirm_reserve',
        type: 'POST',
        data: JSON.stringify(formdata),
        contentType: 'application/json',
        beforeSend: function (xhr) {
          xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
        },
        success: function (response) {
          console.log('success', response);
          localStorage.removeItem('formdata');
          window.location.href = '/'
        },
        error: function (jqXHR, textStatus, errorThrown) {
          console.log('error', jqXHR, textStatus, errorThrown);
        }
      })

      // var customer_name = document.getElementById('customer_name').value;
      // var customer_email = document.getElementById('customer_email').value;
      // var customer_phone = document.getElementById('customer_phone').value;
      // var customer_address = document.getElementById('customer_address').value;

      // if (customer_name.length < 1) {
      //   $('#customer_name').after('<span class="text-sm text-red-800 validation">*Please enter your name</span>');
      //   return false;
      // }

      // if (customer_email.length < 1) {
      //   $('#customer_email').after('<span class="text-sm text-red-800 validation">*Please enter your email</span>');
      //   return false;
      // }
    });
  }
});


//   $.ajax({
//     type: "POST",
//     url: $('#room_checkout').attr('action'),
//     data: $('#room_checkout').serialize(),
// });




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