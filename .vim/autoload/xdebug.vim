" vim functions for parsing xdebug trace files.

" Trim trace file for better readability.
" Usage: :call xdebug#trim()
function! xdebug#trim()
    :%s/[{(]\zs.*\ze[})]//g " Trim functions.
    :%s:\/.*\/: :g " Trim long paths.
    :g/^\S/d " Remove lines which starting with non-whitespace character.
    :%s/^.//
    :%s/^[[:blank:][:digit:][:punct:]]\{22}// " Remove 1st 22 non-letter characters
endfunction
