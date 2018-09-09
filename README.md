# Vim Pandoc Markdown Previewer

![alt text](./preview.gif "Preview")

## Dependencies

* vim
* pandoc
* a pdf viewer:
    * Evince (Works on Mac)
    * Mupdf
    * Okular

For async support (Compiling in background)

* vim version >= 8.00
* [asyncrun.vim](https://github.com/skywind3000/asyncrun.vim)

## Installation

Just like any other vim plugin

## Usage

### Starting the preview

To start the preview mode:
```
:StartMdPreview
```
This will compile your markdown document and open it in one of the above pdf viewers.

After every save the previewer will be refreshed.

### Choosing a previewer

Stick the following in your vimrc, replacing <previewer> with the name of your preferred pdf viewer.

```
let g:md_pdf_viewer="<previewer>"
```
