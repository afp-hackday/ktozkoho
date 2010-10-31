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

  var keycode_map = {
    48: 0,
    49: 1,
    50: 2,
    51: 3,
    52: 4,
    53: 5
  }

  this.start = function() {
    stop_loading()
    setup_keyboard_control()
    next_candidate()
  }

  next_candidate = function() {
    current = buffer.pop()

    $("#company").text(current["company"])
    $("#current_address").text(current["address"])

    for(i = 0; i < 5; i++) {
      if(i < current.best_candidates.length) {
        name_address = current.best_candidates[i]["name"] + "; " + current.best_candidates[i]["address"]
          visibility = "visible"
      } else {
        name_address = ""
          visibility = "hidden"
      }

      $("#candidate" + i).text(name_address).css("visibility", visibility)
    }
  }
  this.next_candidate = next_candidate

  setup_keyboard_control = function() {
    $(document).keypress(function (event) {
      if(loading) return

      if(keycode_map[event.which]) {
        if(buffer.length > 0) {
          next_candidate()
        } else {
          load_buffer()
        }
      }
    })
  }

  start_loading = function() {
    loading = true
    $("#loading").show()
  }

  stop_loading = function() {
    loading = false
    $("#loading").hide()
  }

  load_buffer = function() {
    start_loading()
    $.getJSON('load_entities', {}, function(data, textStatus) {
      $.each(data, function(index, element) {
        buffer.push(element);
      })
      stop_loading()
      next_candidate()
    });
  }
}
