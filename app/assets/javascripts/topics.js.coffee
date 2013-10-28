window.EditComment = (id)->
  $(".comment-#{id}-body").hide()
  e = $(".comment-#{id}-edit").show()
  $("textarea", e).focus()
