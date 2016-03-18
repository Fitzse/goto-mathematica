# Overview
Atom plugin providing approximate implementation navigation to function definition for Mathematica (Wolfram Language) projects. Adds support for go-to definition of symbol under cursor and search for a specific symbol via key-bindings.

# Settings
## Split Pane
Configures whether or not to open the file in a new pending pane or to open it in the existing pane.
- Key: ```goto-mathematica.splitPane```
- Default: true

# Key-Bindings
- F10  -  attempts to find the file containing the definition for the symbol under the cursor and open the file to that position.
- F9  -  opens an input dialog and upon hitting enter will attempt to find the file containing the definition for the symbol entered and open the file to that position.

# Caveats
- Relies on at least 1 project folder being added, will not work if just opening a single file.
- Uses a rather naive regex to attempt to find the function definition for a given symbol, likely will not work in all cases. If you find an edge case open an issue.

# Contributing
Contributions are appreciated, still figuring out how best to implement Atom packages so any feedback/assistance is welcome. Feel free to fork the repository and open a pull request with any improvements you may have.
