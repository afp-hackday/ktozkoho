// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function ManualMapping(buffer, maintain_buffer_size, entity_type) {
  var buffer = buffer
  var maintain_buffer_size = maintain_buffer_size
  var entity_type = entity_type
  var current

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
    load_buffer_if_neccessary()
    current = buffer.pop()

    $("#company").text(current["company"] || '')
    $("#current_address").text(current["address"] || '')

    for(i = 0; i < 5; i++) {
      if(i < current.best_candidates.length) {
        name_address = build_company_info_html(current.best_candidates[i])
        historical_addresses = build_addresses_html(current.best_candidates[i])
        visibility = "visible"
      } else {
        name_address = ""
        visibility = "hidden"
        historical_addresses = ''
      }

      $("#candidate" + i).empty().append(name_address).append(historical_addresses).css("visibility", visibility).css('background-color', '')
    }
  }
  this.next_candidate = next_candidate

  build_company_info_html = function(subject) {
    html = '<strong class="company">'
    html += subject["name"]
    html += '</strong>'
    return html
  }

  build_addresses_html = function(subject) {
    lis = ''
    lis += '<li>' + subject.address + '</li>'

    if(subject["addresses"].length > 1) {
      $.each(subject["addresses"], function(index, address) {
        lis += '<li>' + address["address"] + '</li>'
      })
    }

    return '<ul class="addresses">' + lis + '</ul>'
  }

  setup_keyboard_control = function() {
    $(document).keypress(function (event) {
      if(waiting_for_buffer) return

      if(typeof keycode_map[event.which] != 'undefined') {
        if(current.best_candidates.length < keycode_map[event.which]) {
          add_message('Firma s číslom ' + keycode_map[event.which] + ' neexistuje.', 'warn', 2000)
          return
        }

        $("#candidate" + (keycode_map[event.which] - 1)).css('background-color', '#ffffcc')

        if(buffer.length > 0) {
          setTimeout('next_candidate()', 200)
        } else {
          setTimeout('load_buffer()', 200)
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
    $.getJSON('load', {'type': entity_type}, new_data_received_callback)
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
        add_message('Všetky firmy sú už priradené.', 'info', 10000)
      }
    }
  }

  load_buffer_if_neccessary = function() {
    if(buffer.length < maintain_buffer_size) {
      load_buffer()
    }
  }

  add_message = function(message, type, timeout) {
    id = Math.floor(Math.random()*1000+1)
    html = '<div id="' + id + '" class="message ' + type + '">' + message + '</div>'
    $('#messages').append(html);

    if(timeout != null) {
      setTimeout('$("#' + id + '").fadeOut()', 3000)
    }
  }
}
