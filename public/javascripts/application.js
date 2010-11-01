// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
  mapping = new ManualMapping(unmapped_entities_buffer, 9)
  mapping.start()
});

function ManualMapping(buffer, maintain_buffer_size) {
  var buffer = buffer
  var maintain_buffer_size = maintain_buffer_size
  this.buffer = buffer

  var loading = false
  var waiting_for_buffer = false

  var keycode_map = {
    48: 0,
    49: 1,
    50: 2,
    51: 3,
    52: 4,
    53: 5
  }

  this.start = function() {
    waiting_for_buffer_stop()
    setup_keyboard_control()
    next_candidate()
  }

  next_candidate = function() {
    current = buffer.pop()

    $("#company").text(current["company"] || '')
    $("#current_address").text(current["address"] || '')

    for(i = 0; i < 5; i++) {
      if(i < current.best_candidates.length) {
        name_address = current.best_candidates[i]["name"] + "; " + current.best_candidates[i]["address"]
        historical_addresses = build_historical_addresses_html(current.best_candidates[i]["addresses"])
        visibility = "visible"
      } else {
        name_address = ""
        visibility = "hidden"
        historical_addresses = ''
      }

      $("#candidate" + i).text(name_address).append(historical_addresses).css("visibility", visibility)
    }

    load_buffer_if_neccessary()
  }
  this.next_candidate = next_candidate

  build_historical_addresses_html = function(addresses) {
    lis = ''
    $.each(addresses, function(index, address) {
      lis += '<li>' + address["address"] + '</li>'
    })
    return '<ul>' + lis + '</ul>'
  }

  setup_keyboard_control = function() {
    $(document).keypress(function (event) {
      if(waiting_for_buffer) return

      if(keycode_map[event.which]) {
        if(buffer.length > 0) {
          next_candidate()
        } else {
          load_buffer()
        }
      }
    })
  }

  waiting_for_buffer_start = function() {
    waiting_for_buffer = true
    $("#loading").show()
  }

  waiting_for_buffer_stop = function() {
    waiting_for_buffer = false
    $("#loading").hide()
  }

  load_buffer = function() {
    if(buffer.length == 0) waiting_for_buffer_start()
    if(loading) return

    loading = true
    $.getJSON('load_entities', {}, new_data_received_callback)
  }

  new_data_received_callback = function(data, textStatus) {
    loading = false

    $.each(data, function(index, element) {
      buffer.push(element);
    })

    next_or_finish_if_waiting(data)
    waiting_for_buffer_stop()
  }

  next_or_finish_if_waiting = function(data) {
    if(waiting_for_buffer) {
      if(data.length > 0) {
        next_candidate()
      } else {
        alert('Hotovo')
      }
    }
  }

  load_buffer_if_neccessary = function() {
    if(buffer.length < maintain_buffer_size) {
      load_buffer()
    }
  }
}
