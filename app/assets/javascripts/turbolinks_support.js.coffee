# for turbolink
window.$r = (func) ->
  $ ->
    func(true)
  document.addEventListener 'page:change', ->
    func(false)
  document.addEventListener 'page:restore', ->
    func(false)

