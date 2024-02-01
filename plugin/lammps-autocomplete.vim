
function! CompleteLammps(findstart, base)
    if a:findstart
        " Locate the start position of the word
        let line = getline('.')
        let startcol = col('.') - 1
        while startcol > 0 && line[startcol - 1] =~ '\k'
            let startcol -= 1
        endwhile
        return startcol
    else
        " Provide completions based on the context
        let context = a:base
        let completions = []
        if context == 'pair_style'
            let completions += ['lj/cut', 'lj/long', 'lj/long/columb', 'eam/alloy', 'eam/fs']
        elseif context == 'run'
            let completions += [ 'pre', 'post', 'mpi', 'cuda']
        endif


        let combined_completions = map(copy(completions), 'context . " " . v:val')
        return combined_completions

    endif
endfunction

autocmd FileType lammps setlocal omnifunc=CompleteLammps
