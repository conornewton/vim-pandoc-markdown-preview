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
    execute "silent !pandoc % -o %:r.pdf && pkill -HUP mupdf"
    redraw!
endfunction

function! s:OpenPdf(pdf_viewer)
    call s:CompileMd()
    execute "silent !" .a:pdf_viewer. " %:r.pdf &"
endfunction


" every time we save compile
autocmd BufWritePost *.md call s:CompileMd()

command! StartMdPreview call s:OpenPdf(s:pdf_viewer)
