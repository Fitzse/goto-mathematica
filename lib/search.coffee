fs = require 'fs'
{CompositeDisposable} = require 'atom'

module.exports =
  regexp: ""

  gotoWord: (word)->
    @regexp = new RegExp("\\b"+word+"\\[.*\\]\\s*:=")
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
        atom.workspace.open(file.path).then (editor) =>
          editor.scan @regexp, (matchInfo) =>
            marker = editor.markBufferRange(matchInfo.range)
            position = marker.getStartScreenPosition()
            editor.setCursorScreenPosition(position)
        return true
    return false
