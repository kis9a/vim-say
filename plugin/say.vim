if exists('g:loaded_say_plugin') && g:loaded_say_plugin
  finish
endif

if !exists('g:say_voice')
  let g:say_voice = ''
endif

if !exists('g:say_background_flag')
  let g:say_background_flag = '&'
endif

function! say#cword()
  return expand('<cword>')
endfunction

if !exists('g:Say_word_function')
  let g:Say_word_function = function('say#cword')
endif

function! s:visualSelected()
  let s = @a
  silent! normal! gv"ay
  let r = @a
  let @a = s
  return r
endfunction

function! s:say(sentence)
  if executable('say')
    let cmd = ['say']
    if g:say_voice !=# '' | let cmd += ['-v', g:say_voice] | endif
    let cmd += ['"' . substitute(substitute(a:sentence, '"', "'", 'g'), '\n', ' ', 'g') . '"', g:say_background_flag]
    execute system(join(cmd, ' '))
  else
    return v:null
  endif
endfunction

command! SayCursorWord call s:say(g:Say_word_function())
command! -range SayVisualSelected call s:say(s:visualSelected())
command! -nargs=1 Say call s:say(<q-args>)

let g:loaded_aay_plugin = 1
