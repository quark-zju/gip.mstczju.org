# for turbolink
window.$r = (func) ->
  $(func)
  document.addEventListener('page:change', func)
