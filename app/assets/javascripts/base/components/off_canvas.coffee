window.Tomato = {} if window.Tomato == undefined

Tomato.offcanvas = () =>
  show: (side) ->
    if (side == 'right')
      $('.off-canvas').removeClass('move-right')
      $('.off-canvas').addClass('move-left')

    if (side == 'left')
      $('.off-canvas').removeClass('move-left')
      $('.off-canvas').addClass('move-right')

  close: () ->
    $('.off-canvas').removeClass('move-right')
    $('.off-canvas').removeClass('move-left')
    console.log('off-canvas close!')

page_ready = () ->
  $('.off-canvas-toggler-right').click (e) ->
    e.stopPropagation()
    e.preventDefault()
    $offCanvas = $('.off-canvas')
    if $offCanvas.hasClass('move-right') || $offCanvas.hasClass('move-left')
      Tomato.offcanvas().close()
    else
      Tomato.offcanvas().show('right')

  $('.off-canvas-toggler-left').click (e) ->
    e.stopPropagation()
    e.preventDefault()
    $offCanvas = $('.off-canvas')
    if $offCanvas.hasClass('move-right') || $offCanvas.hasClass('move-left')
      Tomato.offcanvas().close()
    else
      Tomato.offcanvas().show('left')

  $('.off-canvas-close').click (e) ->
    Tomato.offcanvas().close()

  $('.off-canvas-main').click (e) ->
    $offCanvas = $('.off-canvas')
    if $offCanvas.hasClass('move-left') || $offCanvas.hasClass('move-right')
      Tomato.offcanvas().close()

document.addEventListener 'turbolinks:load', page_ready