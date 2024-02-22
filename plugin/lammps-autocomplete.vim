
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

        " commands
        if context == 'angle_coeff'
            let completions += ['N args']

        elseif context == 'angle_style'
            let completions += ['none', 'zero', 'hybrid', 'amoeba', 'charmm', 'class2', 'class2/p6', 'cosine', 
                        \'cosine/buck6d','cosine/delta', 'cosine/periodic','cosine/shift', 'cosine/shift/exp', 
                        \'cosine/squared', 'cross', 'dipole', 'fourier', 'fourier/simple', 'gaussian', 'harmonic',
                        \'lepton', 'mm3', 'quartic', 'spica', 'table']
        
        elseif context == 'angle_write'
            let completions += ['atype N file keyword']
        
        elseif context == 'atom_modify'
            let completions += ['id', 'map', 'first', 'sort']

        elseif context == 'atom_style'
            let completions += ['amoeba', 'angle', 'atomic', 'body', 'bond', 'charge', 'dielectric', 'dipole', 
                        \'dpd', 'edpd', 'electron', 'ellipsoid', 'full', 'line', 'mpdp', 'molecular', 'oxdna', 'peri',
                        \'smd', 'sph', 'sphere', 'bpm/sphere', 'spin', 'tdpd', 'tri', 'template', 'wavepacket', 'hybrid']

        elseif context == 'balance'
            let completions += ['thresh x args', 'thresh y args', 'thresh z args', 'thresh shift args', 'thresh rcb args']
            
        elseif context == 'bond_coeff'
            let completions += ['N args']

        elseif context == 'bond_style'
            let completions += ['none', 'zero', 'hybrid', 'bpm/rotational', 'bpm/spring',  ]

        elseif context == 'pair_style'
            let completions += ['lj/cut', 'lj/long', 'lj/long/columb', 'eam/alloy', 'eam/fs']
        elseif context == 'run'
            let completions += [ 'pre', 'post', 'mpi', 'cuda']
        endif


        let combined_completions = map(copy(completions), 'context . " " . v:val')
        return combined_completions

    endif
endfunction

autocmd FileType lammps setlocal omnifunc=CompleteLammps
