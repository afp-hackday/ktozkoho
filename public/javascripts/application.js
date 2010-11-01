// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
  mapping = new ManualMapping(unmapped_entities_buffer)
  mapping.start()
});

function ManualMapping(start_buffer) {
  var buffer = start_buffer
  this.buffer = buffer

  var loading = false
  var loading_notification = false

  var keycode_map = {
    48: 0,
    49: 1,
    50: 2,
    51: 3,
    52: 4,
    53: 5
  }

  this.start = function() {
    loading_notification_stop()
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
      if(loading_notification) return

      if(keycode_map[event.which]) {
        if(buffer.length > 0) {
          next_candidate()
        } else {
          load_buffer()
        }
      }
    })
  }

  loading_notification_start = function() {
    loading_notification = true
    $("#loading").show()
  }

  loading_notification_stop = function() {
    loading_notification = false
    $("#loading").hide()
  }

  load_buffer = function() {
    if(buffer.length == 0) loading_notification_start()
    if(loading) return

    loading = true
    $.getJSON('load_entities', {}, function(data, textStatus) {
      $.each(data, function(index, element) {
        buffer.push(element);
      })

      loading = false
      if(loading_notification) next_candidate()
      loading_notification_stop()
    });
  }

  load_buffer_if_neccessary = function() {
    if(buffer.length < 10) {
      load_buffer()
    }
  }
}
