let s:preview_running = 0

if exists('g:md_pdf_viewer')
    let s:pdf_viewer = g:md_pdf_viewer
else 
    for possible_pdf in ['okular', 'mupdf', 'evince']
        if executable(possible_pdf)
            let s:pdf_viewer = possible_pdf
        endif
    endfor
endif

if exists('g:md_pdf_engine')
    let s:pdf_engine = g:md_pdf_engine
else
    let s:pdf_engine = "pdflatex"
endif

if exists('g:md_default_latex_class')
    let s:latex_class = g:md_default_latex_class
else
    let s:latex_class = 'latex'
endif

if (!exists('s:pdf_viewer'))
    echoh1 ErrorMsg
    echo "could not find valid pdf viewer"
    echoh1 None
    finish
endif

if exists(':AsyncRun') && v:version >= 800
    let s:async_support = 1
endif


function! s:CompileMd()
    " Only compile when the preview is enabled
    if (s:preview_running == 1)
        if exists('s:async_support')
            execute "AsyncRun pandoc -t " .s:latex_class. " --pdf-engine=" .s:pdf_engine. " % -o %<.pdf && pkill -HUP mupdf"
        else
            execute "silent !pandoc -t " .s:latex_class. " --pdf-engine=" .s:pdf_engine. " % -o %:r.pdf &>/dev/null && pkill -HUP mupdf &> /dev/null"
        endif
    endif
    redraw!
endfunction

function! s:OpenPdf(pdf_viewer)
    " A synchronous (locking up) call is necessary here. Otherwise the pdf viewer will open before 
    " the file has been compiled, hence finding nothing to display.
    execute "silent !pandoc -t " .s:latex_class. " --pdf-engine=" .s:pdf_engine. " % -o %:r.pdf &>/dev/null && pkill -HUP mupdf &> /dev/null"
    execute "silent !" .a:pdf_viewer. " %:r.pdf &> /dev/null &"
    redraw!
endfunction

function! s:StartPreview(pdf_viewer, latex_class)
    " Latex is always default unless specified in the call or in .vimrc
    if (a:latex_class != "")
        let s:latex_class = a:latex_class
    endif

    let s:preview_running = 1
    call s:OpenPdf(a:pdf_viewer)
endfunction


autocmd BufWritePost *.md call s:CompileMd()
command! -nargs=? StartMdPreview call s:StartPreview(s:pdf_viewer, "<args>")
command! StopMdPreview let s:preview_running = 0

