{View} = require 'space-pen'
{TextEditorView} = require 'atom-space-pen-views'
Search = require '../search'

module.exports =
class SymbolPaletteView extends View
  @content: ->
    @div class: 'symbol-palette', =>
      @div ''
      @subview 'symbolPaletteView', new TextEditorView(mini: true)

  initialize: ->
    atom.commands.add @element,
      'core:confirm': (event) =>
        @confirm()
        event.stopPropagation()

      'core:cancel': (event) =>
        @cancel()
        event.stopPropagation()

  show: ->
    @panel ?=atom.workspace.addModalPanel(item: this)
    @symbolPaletteView.focus()

  toggle: ->
    if @panel?.isVisible()
      @cancel()
    else
      @show()

  cancelled: -> @hide()

  hide: ->
    @panel?.destroy()

  cancel: -> @hide()

  confirm: ->
    Search.gotoWord(@symbolPaletteView.getText())
    @hide()
