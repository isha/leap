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
    $('#gesture_compressed_data').val(player().recording.export('json'))
    button.text("Record")

$(document).on 'click', '#playback-button', ->
  button = $('#playback-button')
  if button.text() == "Playback"
    player().play()
    button.text("Stop")
  else
    player().stop()
    button.text("Playback")

$(document).on 'click', '#test-button', ->
  # $.ajax '11/compressed_data.json.lz',
  #         type: 'GET'
  #         dataType: 'html'
  #         error: (jqXHR, textStatus, errorThrown) ->
  #           debugger
  #         success: (data, textStatus, jqXHR) ->
  #           debugger

player = ->
  controller.plugins.playback.player

ready = ->
  output_element = document.getElementById('leap-output')
  if output_element
    controller = new Leap.Controller({background: true})

    controller
      .use('playback', {
        recording: '13/compressed_data.json',
        loop: true,
        pauseHotkey: false,
        pauseOnHand: false
        })
      .use('boneHand', {
        targetEl: output_element,
        arm: true
        })
      .connect()
    

$(document).ready(ready)
$(document).on('page:load', ready)
