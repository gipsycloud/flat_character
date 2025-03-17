document.addEventListener("DOMContentLoaded", function () {
  if (document.body.classList.contains('homes-room_detail')) {
    setUpDatepicker();
    var room_price_detail = document.getElementById('room_price_detail').getAttribute('data-value');  // get value from detail information
    var room_price_reserve = document.getElementById('room_price');                                   // get value from reserve checkout
    var default_guest_count = document.getElementById('guests-count').getAttribute('data-value');
    var service_fee = document.getElementById('service_fee').getAttribute('data-value');
    var room_type = document.getElementById('room_type').getAttribute('data-value');
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
        updateDisplayAndPricing(type);
      }
    }

    function updateDisplayAndPricing(type) {
      document.getElementById('guests-count').textContent = `${type}` + " " + counts.adults;
      var element = document.getElementById('guests-count');
      element.setAttribute('data-value', `${type}` + " " + counts.adults);
      element.setAttribute('guest-count', counts.adults);

      const dayCount = document.getElementById('days-count');
      if (dayCount) {
        dayCount.textContent = `${numberOfDays} night${numberOfDays !== 1 ? 's' : ''}`;
      }

      // var room_price_detail = document.getElementById('room_price_detail').getAttribute('data-value'); // get price from html
      var guest_count = document.getElementById('guests-count').getAttribute('guest-count');
      var room_price = parseInt(room_price_detail) * parseInt(guest_count) * (numberOfDays || 1);
      room_price_reserve.setAttribute('reserve-value', room_price);
      $('#room_price').text(room_price);   // showing price for website

      var total_checkout = document.getElementById('total_checkout');
      total_checkout.setAttribute('data-value', room_price + parseInt(service_fee));
      $('#total_checkout').text(room_price + parseInt(service_fee));
    }

    let start_date = null;
    let end_date = null;
    let numberOfDays = 0;

    function calculateDays() {
      if (start_date && end_date) {
        const oneDay = 24 * 60 * 60 * 1000;
        const diff = end_date - start_date;
        numberOfDays = Math.round(diff / oneDay);
        return numberOfDays >= 0 ? numberOfDays : 0;
      }
      console.log(numberOfDays);
      return 0;
    }

    function setUpDatepicker() {
      const start_date_input = document.getElementById('start_date');
      const end_date_input = document.getElementById('end_date');

      start_date_input.addEventListener('change', (e) => {
        start_date = new Date(e.target.value);
        if (end_date && start_date > end_date) {
          end_date = null;
          end_date_input.value = '';
        }
        numberOfDays = calculateDays();
        updateDisplayAndPricing();
      });

      end_date_input.addEventListener('change', (e) => {
        end_date = new Date(e.target.value);
        if (start_date && start_date > end_date) {
          start_date = null;
          start_date_input.value = '';
        }
        numberOfDays = calculateDays();
        updateDisplayAndPricing();
      });
    }

    function updateDisplayAndPricing(type) {
      document.getElementById('guests-count').textContent = `${type}` + " " + counts.adults;

      var element = document.getElementById('guests-count');
      element.setAttribute('data-value', `${type}` + " " + counts.adults);
      element.setAttribute('guest-count', counts.adults);

      const dayCount = document.getElementById('days-count');
      if (dayCount) {
        dayCount.textContent = `${numberOfDays} night${numberOfDays !== 1 ? 's' : ''}`;
      }

      var room_price_detail = document.getElementById('room_price_detail').getAttribute('data-value'); // get price from html
      var guest_count = document.getElementById('guests-count').getAttribute('guest-count');
      var room_price = parseInt(room_price_detail) * parseInt(guest_count) * (numberOfDays || 1);
      $('#room_price').text(room_price);   // showing price for website

      var total_checkout = document.getElementById('total_checkout');
      total_checkout.setAttribute('data-value', room_price);
      $('#total_checkout').text(room_price + parseInt(service_fee));
    }

    // Add event listeners for buttons
    document.getElementById('decrease-adults').addEventListener('click', () => updateCount('adults', -1));
    document.getElementById('increase-adults').addEventListener('click', () => updateCount('adults', 1));

    $('#reserve').on("click", function (event) {
      event.preventDefault();
      $('span.validation').remove();
      var sum = document.getElementById('total_checkout').getAttribute('data-value');
      var guest = document.getElementById('guests-count').getAttribute('data-value');
      var reserve = room_price_reserve.getAttribute('reserve-value');

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
        room_price_reserve: reserve,
        price: room_price_detail,
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

  if (document.body.classList.contains('properties-reserve')) {
    let formdata = JSON.parse(localStorage.getItem('formdata'));
    if (formdata) {
      $('#room_id').text(formdata.room_id);
      $('#room_type').text(formdata.room_type);
      $('#guest_count').text(formdata.guest_count);
      $('#start_date').text(formdata.start_date);
      $('#end_date').text(formdata.end_date);
      $('#room_price').text(formdata.price);
      $('#room_price_reserve').text(formdata.room_price_reserve);
      $('#total_price').text(formdata.total);
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

      // var start_date = $('#start_date').val();
      // var end_date = $('#end_date').val();
      // var room_price = room_price_detail.replace(/,/g, ''); // remove comma from price
    });
  }
});

















// document.addEventListener("DOMContentLoaded", function () {

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