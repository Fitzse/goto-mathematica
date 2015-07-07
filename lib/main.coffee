{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'goto-mathematica:go-to-definition': => @goto()

  deactivate: ->
    @subscriptions.dispose()

  goto: ->
    editor = atom.workspace.getActivePaneItem()
    word = editor.getWordUnderCursor()
    console.log word
