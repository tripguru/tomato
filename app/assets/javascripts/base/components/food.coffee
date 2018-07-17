page_ready = () ->
  $('.food').click (e) ->
    console.log e
    $food = $(e.currentTarget)
    if $food.hasClass('active')
      $food.removeClass('active')
    else
      $food.addClass('active')

document.addEventListener 'turbolinks:load', page_ready