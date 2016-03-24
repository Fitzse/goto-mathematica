fs = require 'fs'
_ = require 'underscore-plus'
{CompositeDisposable} = require 'atom'

module.exports =
  regexp: ""

  gotoWord: (word, openPane) ->
    @regexp = new RegExp("\\b"+word+"\\[.*\\]\\s*:=")
    directories = atom.project.getDirectories()
    path = @testPaths directories
    if _.isString(path)
      options = {}
      if openPane 
        options.pending = true
        options.split = 'right'
      atom.workspace.open(path,options).then (editor) =>
        editor.scan @regexp, (matchInfo) =>
          marker = editor.markBufferRange(matchInfo.range)
          position = marker.getStartScreenPosition()
          editor.setCursorScreenPosition(position)
          
  testPaths: (files) ->
    reducer = (foundPath, path) =>
      if _.isString(foundPath)
        return foundPath
      return @testPath path
    return _.reduce files, reducer, false

  testPath: (file) ->
    if file.isFile()
      return @testFile(file)
    else if !file.path.includes(".git") and !file.path.includes("Tests")
      entries = file.getEntriesSync()
      return @testPaths entries
    return false

  testFile: (file) ->
    if file.path.endsWith(".m")
      contents = fs.readFileSync(file.path)
      if @regexp.test(contents)
        return file.path
    return false
