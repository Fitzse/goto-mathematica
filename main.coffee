{CompositeDisposable} = require 'atom'
SymbolPaletteView = require './lib/views/symbol-palette-view'
Search = require './lib/search'

module.exports =
  subscriptions: null
  regexp: ""

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'goto-mathematica:go-to-cursor': => @gotoCursor(false)
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'goto-mathematica:go-to-cursor-pane': => @gotoCursor(true)
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'goto-mathematica:go-to-symbol': => @gotoView(false)
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'goto-mathematica:go-to-symbol-pane': => @gotoView(true)

  deactivate: ->
    @subscriptions.dispose()

  gotoView: (openPane) ->
    @paletteView = new SymbolPaletteView()
    @paletteView.show(openPane)

  gotoCursor: (openPane) ->
    editor = atom.workspace.getActivePaneItem()
    word = editor.getWordUnderCursor()
    Search.gotoWord(word, openPane)
