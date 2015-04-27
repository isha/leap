# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

recording = false
frames = []
controller = null

$(document).on 'click', '#record-button', ->
  button = $('#record-button')
  if button.text() == "Record"
    if frames.length > 0
      frames = []
    recording = true
    button.text("Stop")
  else
    recording = false
    button.text("Record")

$(document).on 'click', '#playback-button', ->
  if frames.length > 0
    controller.use('playback', {
      recording: {frames: frames},
      loop: true
      })
    .connect()
    
  else
    console.log "Nothing recorded yet!"

onFrame = (frame) ->
  if recording
    frames.push frame

ready = ->
  controller = new Leap.Controller({background: true})
  controller
    .use('boneHand', {
      targetEl: document.getElementById('output'),
      arm: true
    })
    .connect()

  controller.on('frame', onFrame)

$(document).ready(ready)
$(document).on('page:load', ready)
