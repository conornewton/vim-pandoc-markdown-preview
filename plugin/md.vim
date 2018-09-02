if exists('g:md_pdf_viewer')
    let s:pdf_viewer = g:md_pdf_viewer
else 
    for possible_pdf in ['okular', 'mupdf', 'evince']
        if executable(possible_pdf)
            let s:pdf_viewer = possible_pdf
        endif
    endfor
endif


function! s:CompileMd()
    execute "silent !pandoc % -o %:r.pdf &>/dev/null && pkill -HUP mupdf &> /dev/null"
    redraw!
endfunction

function! s:OpenPdf(pdf_viewer)
    call s:CompileMd()
    execute "silent !" .a:pdf_viewer. " %:r.pdf &> /dev/null &"
    redraw!
endfunction


autocmd BufWritePost *.md call s:CompileMd()
command! StartMdPreview call s:OpenPdf(s:pdf_viewer)
