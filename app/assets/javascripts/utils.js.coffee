# for turbolink
window.$r = (func) ->
  $ ->
    func(true)
  document.addEventListener 'page:change', ->
    func(false)
