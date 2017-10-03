scriptencoding utf-8
let s:save_cpo = &cpoptions
set cpoptions&vim

function! unite#sources#ale#define() abort
  return s:source
endfunction

let s:source = {
      \ 'name' : 'ale',
      \ 'default_kind' : 'jump_list',
      \ }

function! s:source.gather_candidates(args, context) abort
  return map(deepcopy(ale#engine#GetLoclist(bufnr('%'))), "{
        \ 'word' : v:val.text,
        \ 'abbr' : '[' . v:val.lnum . ':' . v:val.col . '] ' . v:val.text,
        \ 'action__buffer_nr' : v:val.bufnr,
        \ 'action__line' : v:val.lnum,
        \ 'action__col' : v:val.col,
        \ }")
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
