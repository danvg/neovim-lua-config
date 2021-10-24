" Disable annoying mapping that prohibits space to be mapped as leader key
silent! iunmap <buffer> <Space>aj
silent! iunmap <buffer> <Space>al

" Try to use standard ada indentation
setl tabstop=3 shiftwidth=3 softtabstop=2 expandtab

" Pretty printing
command! -nargs=0 GnatPP :call system(
      \'gnatpp --replace --max-line-length=79 --indentation=3
      \--indent-continuation=2 --eol=lf --wide-character-encoding=8
      \--comments-unchanged --no-separate-is --no-separate-loop-then
      \--number-case-as-declared --enum-case-as-declared
      \--name-case-as-declared --vertical-enum-types
      \--vertical-named-aggregates --indent-named-statements
      \--par-threshold=3 --call-threshold=3 '
      \. expand("%:p"))

" GPR tools (arg is project name)
command! -nargs=1 GprBuild :call system('gprbuild -p ' . <q-args>)
command! -nargs=1 GprClean :call system('gprclean -p ' . <q-args>)
command! -nargs=1 GprPP :call system('gnatpp -p ' . <q-args>)
