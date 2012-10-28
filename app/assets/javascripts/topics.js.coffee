# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

window.EditComment = (id)->
  $(".comment-#{id}-body").hide()
  e = $(".comment-#{id}-edit").show()
  $("textarea", e).focus()

# tab, enter friendly in textarea
# $ ->
#   $(document).delegate 'textarea', 'keydown', (e) ->
#     keyCode = e.keyCode || e.which
#     if keyCode == 9
#       e.preventDefault()
#       obj = $(this)
#       ctl = obj.get(0)
#       text = obj.val()
#       start = ctl.selectionStart
#       end = ctl.selectionEnd
#       # set textarea value to: text before caret + tab + text after caret
#       # obj.val("#{text.substring(0, start)}\t#{text.substring(end)}")
#       # put caret at right position again
#       # control.selectionStart = control.selectionEnd = start + 1


