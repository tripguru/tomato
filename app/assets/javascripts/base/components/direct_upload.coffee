displayFileUploadProcessing = () ->
  $body = $('body')
  $body.append("<div class='processing'><i class='fas fa-spinner fa-pulse fa-4x'></i></div>")

page_ready = () ->
  inputs = $("footer input[type='file']")

  inputs.each (index, input) ->
    $input = $(input)

    fileName = ""
    $input.change (e) =>
      displayFileUploadProcessing()
      $input.parent('form').submit()

    fileName

document.addEventListener 'turbolinks:load', page_ready