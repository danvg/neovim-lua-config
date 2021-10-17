set lines=38 columns=100 linespace=1

:GuiFont! JetBrainsMono NF:h11
:GuiPopupmenu 0
:GuiTabline 0
:GuiLinespace 1
:GuiScrollBar 0

nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv
