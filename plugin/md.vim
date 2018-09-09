if exists('g:md_pdf_viewer')
    let s:pdf_viewer = g:md_pdf_viewer
else 
    for possible_pdf in ['okular', 'mupdf', 'evince']
        if executable(possible_pdf)
            let s:pdf_viewer = possible_pdf
        endif
    endfor
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
    if exists('s:async_support')
        :AsyncRun pandoc "%" -o "%<".pdf && pkill -HUP mupdf
    else
        execute "silent !pandoc % -o %:r.pdf &>/dev/null && pkill -HUP mupdf &> /dev/null"
    endif
    redraw!
endfunction

function! s:OpenPdf(pdf_viewer)
    call s:CompileMd()
    execute "silent !" .a:pdf_viewer. " %:r.pdf &> /dev/null &"
    redraw!
endfunction


autocmd BufWritePost *.md call s:CompileMd()
command! StartMdPreview call s:OpenPdf(s:pdf_viewer)
