# for turbolink
window.$r = (func, force=false) ->
  $(func)
  for event in (if force then ['page:change', 'page:restore'] else ['page:load'])
    document.removeEventListener event, func
    document.addEventListener event, func

$ ->
  # show 'loading' and disable link clicks when loading pages by turbolinks
  disabledEventHandler = (e) ->
    e.preventDefault
    false
  document.addEventListener 'page:fetch', ->
    $('a').live 'click', disabledEventHandler
    $('#loading').delay(200).fadeIn(100)
  document.addEventListener 'page:change', ->
    $('a').die 'click', disabledEventHandler
    $('#loading').fadeOut(10)
