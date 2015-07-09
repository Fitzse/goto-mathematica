fs = require 'fs'
{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null
  regexp: ""

  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-text-editor',
      'goto-mathematica:go-to-definition': => @goto()

  deactivate: ->
    @subscriptions.dispose()

  goto: ->
    editor = atom.workspace.getActivePaneItem()
    word = editor.getWordUnderCursor()
    @regexp = new RegExp("\\b"+word+"\\[.*\\]:=")
    directories = atom.project.getDirectories()
    found = false
    index = 0
    while !found and index < directories.length
      found = @testPath directories[index]
      index++

  testPath: (file) ->
    found = false
    if file.isFile()
      return @testFile(file)
    else if !file.path.includes(".git") and !file.path.includes("Tests")
      entries = file.getEntriesSync()
      index = 0
      while !found and index < entries.length
        found = @testPath entries[index]
        index++
    return found

  testFile: (file) ->
    if file.path.endsWith(".m")
      contents = fs.readFileSync(file.path)
      if @regexp.test(contents)
        atom.workspace.open(file.path)
        return true
    return false
