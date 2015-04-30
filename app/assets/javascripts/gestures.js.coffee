# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

controller = null
compressed_data = ""

$(document).on 'click', '#record-button', ->
  button = $('#record-button')
  if button.text() == "Record"
    player().record()
    button.text("Stop")
  else
    player().finishRecording()
    $('#gesture_compressed_data').val(player().recording.export())
    button.text("Record")

$(document).on 'click', '#playback-button', ->
  button = $('#playback-button')
  if button.text() == "Playback"
    player().play()
    button.text("Stop")
  else
    player().stop()
    button.text("Playback")

player = ->
  controller.plugins.playback.player

clear_controller = ->
  if controller
    controller.disconnect()
    controller.stopUsing('playback')
    controller.stopUsing('boneHand')

ready = ->
  clear_controller()

  output_element = document.getElementById('leap-output')
  if output_element
    controller = new Leap.Controller({background: true})

    playback_options = {
      loop: true,
      pauseHotkey: false,
      pauseOnHand: false
    }

    if (id = $('#gesture_id').val())
      playback_options['recording'] = id + '/compressed_data.json.lz'

    controller.use('playback', playback_options).use('boneHand', {
      targetEl: output_element,
      arm: true
    }).connect()
    

$(document).ready(ready)
$(document).on('page:load', ready)
