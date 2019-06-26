# Vim Pandoc Markdown Previewer

![alt text](./preview.gif "Preview")

## Dependencies

* vim
* pandoc
* a pdf viewer:
    * Evince (Works on Mac)
    * Mupdf
    * Okular

many other pdf readers should work, above is a list that I have tested.

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

If the preview is currently running every save will recompile the document and the previewer will
be refreshed.

To stop the preview mode:
```
:StopMdPreview
```

Once the preview is stopped the document won't be automatically compiled when saved.


### Choosing a previewer

Stick the following in your vimrc, replacing `<previewer>` with the name of your preferred pdf viewer.

```
let g:md_pdf_viewer="<previewer>"
```

### Passing arguments to pandoc

You can make use of the `g:md_arg`_ variable to pass arguments to pandoc. For example, taken from my vimrc.

```
let g:md_args = "--template eisvogel --listings"
```

This compiles markdown using the [eisvogel](https://github.com/Wandmalfarbe/pandoc-latex) template.
