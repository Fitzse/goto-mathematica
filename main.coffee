{CompositeDisposable} = require 'atom'
SymbolPaletteView = require './lib/views/symbol-palette-view'
Search = require './lib/search'

module.exports =
  subscriptions: null
  regexp: ""

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'goto-mathematica:go-to-cursor': => @gotoCursor()
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'goto-mathematica:go-to-symbol': => @gotoView()

  deactivate: ->
    @subscriptions.dispose()

  gotoView: ->
    @paletteView = new SymbolPaletteView()
    @paletteView.show()

  gotoCursor: ->
    editor = atom.workspace.getActivePaneItem()
    word = editor.getWordUnderCursor()
    Search.gotoWord(word)
