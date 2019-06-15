# Vim Pandoc Markdown Previewer

![alt text](./preview.gif "Preview")

## Dependencies

* vim
* pandoc
* a pdf viewer:
    * Evince (Works on Mac)
    * Mupdf
    * Okular
many other pdf readers should work, above is a list of them I have tested

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

### Choosing a pdf engine

Pandoc supports several pdf engines for document compilation. You can choose your preferred engine
like so:

```
let g:md_pdf_engine="<engine>"
```

The default engine is _pdflatex_.

You can read more about pdf engines in the [Pandoc
manpage](https://manpages.debian.org/testing/pandoc/pandoc.1.en.html)

This compiles markdown using the [eisvogel](https://github.com/Wandmalfarbe/pandoc-latex-template) templates.

### Choosing a latex class

Pandoc uses latex to compile pdfs. The default class _latex_ will produce a A4/Letter pdf. You may
use any of the keywords supported by Pandoc. However, the preview will only work with those
compiling to pdf, like _beamer_.

Choose your preferred latex class like so:

```
let g:md_default_latex_class="<class>"
```

The default class is _latex_.

You can list all available formats by running 
```
pandoc --list-output-formats
```

### Passing arguments to pandoc

You can make use of the _g:md_args_ variable in your vimrc to pass arguments to pandoc. You can also use this to set the document class and pdf engine instead of the method shown above. For example, taken from my vimrc.

```
let g:md_args = "--template eisvogel --listings"
```

