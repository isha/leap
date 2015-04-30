# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

controller = null

$(document).on 'click', '#record-button', ->
  button = $('#record-button')
  if button.text() == "Record"
    player().record()
    button.text("Stop")
  else
    player().finishRecording()
    $('gesture_compressed_data').val(player().recording.export())
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

ready = ->
  output_element = document.getElementById('leap-output')
  if output_element
    controller = new Leap.Controller({background: true})
    playback_options = {
      loop: true,
      pauseHotkey: false,
      pauseOnHand: false
    }
    controller
      .use('playback', playback_options)
      .use('boneHand', {
        targetEl: output_element,
        arm: true
        })
      .connect()
    

$(document).ready(ready)
$(document).on('page:load', ready)
