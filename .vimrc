" Configuration de base{{{
"utilise les défauts de vim à la place de ceux de vi
set nocompatible

"numérotation des lignes
set number

"activation de la coloration syntaxique
syntax on

" Utilise le shell Bash
set shell=bash

" Centre la ligne courante
set scrolloff=1000

" Permet le copié/collé de X sans indentations
set paste

" Désactive l'autocomplétion pour les lignes de commentaires. 
au FileType * setl fo-=cro

" Ferme une parenthese, et se place entre les deux. Cf vim.wikia pour des solutions plus avancées. 
inoremap ( ()<left>

" Lors d'une recherche, en appuyant sur 'n' (correspondance suivante), les correspondances seront centrée dans la fenêtre. 
nnoremap n nzz

"choix de la coloration syntaxique
"colorscheme morning
colorscheme desert

" Remplace les tabulations par des espaces
set expandtab
filetype plugin indent on
set softtabstop=4
set shiftwidth=4

" Tabulation de 4 espaces
set tabstop=4

"indentation de type C
set cindent

"activation de l'auto indentation
set autoindent

"active les replis
set foldenable
set foldmethod=manual
au BufRead .vimrc setlocal foldmethod=marker foldmarker={{{,}}}

"montre toujours la position du curseur
set ruler

"utilisation de la souris"
set mouse=a

" Encodage des fichiers en utf-8 par défaut
set encoding=utf-8

" Active le copié/collé sans indentations
set paste

" Active la correction orthographique pour tout les fichiers
"setlocal spell spelllang=fr
"}}} }}}

" Configuration template{{{
" Édite automatiquement les nouveaux fichiers PKGBUILD
au BufNewFile PKGBUILD 0r ~/.vim/templates/PKGBUILD

" Édite automatiquement les nouveaux fichiers .sh
au BufNewfile *.sh 0r ~/.vim/templates/sh

" Édite automatiquement les nouveaux fichiers .py
au BufNewfile *.py 0r ~/.vim/templates/python

" Édite automatiquement les nouveaux fichiers .c
au BufNewFile *.c 0r ~/.vim/templates/c

" Édite automatiquement les nouveaux fichiers .md
au bufNewFile *.md 0r ~/.vim/templates/md
" Repli les fichier .h
"au BufRead *.h set foldmethod=marker foldmarker=/*,*/
"au BufRead *.h set foldmethod=marker foldmarker=#if,#endif
"}}}

" 3e conf {{{
" Fonction de 'nettoyage' d'un fichier :
" Suppression des caractères ^M en fin de ligne
function! CleanCode()
    %s/^M//g
    call s:DisplayStatus('Code nettoyé')
endfunction

" Ouverture des fichiers avec le curseur à la position de la dernière édition
function! s:Cursor0ldPosition()
    if line("'\"") > 0 && line("'\"") <= line("$")
        exe "normal g`\""
    endif
endfunction
autocmd BufReadPost * silent! call s:CursorOldPosition()

"Fichier de sauvergarde avec extention .bak"
set backup
set backupext=.bak
set backupdir=~/.backup_file

if !has("gui_running")
	if &term == "rxvt-unicode"
		let &t_SI = "\033]12;red\007"
		let &t_EI = "\033]12;green\007"

		:silent !echo -ne "\033]12; green\007"
		autocmd VimLeave * :silent :!echo -ne "\033]12;green\007"
	endif
	if &term == "screen"
		let &t_SI = "\033P\033]12;red\007\033\\"
		let &t_EI = "\033P\033]12;green\007\033\\"

		:silent !echo -ne "\033P\033]12;green\007\033\\"
		autocmd VimLeave * :silent :!echo -ne "\033P\033]12;green\007\033\\"
	endif
endif

"Charge le plugin pour les fiches man"
runtime ftplugin/man.vim

"Commandes perso"
command! EditVimrc :tabnew $HOME/.vimrc
command! EditBashrc :tabnew $HOME/.bashrc
command! EditHelp :tabnew $HOME/.vim/doc/stk_aide.txt
"}}}

"Raccourcis clavier perso{{{

"ouvre un nouvel onglet
map gn :tabnew
"recharge le fichier de configuration
map <F2> :source $HOME/.vimrc<CR>

" Edite le fichier de configuration ~/.vimrc
map <F3> :EditVimrc<CR>

" Edite le fichier de configuration ~/.bashrc
map <F4> :EditBashrc<CR>

" Régénère les fichiers d'aides contenuent dans $HOME/.vim/doc
map <F5> :helptags ~/.vim/doc

" Édite le fichier d'aide personel ~/.vim/doc/stk_aide.txt
map <F6> :EditHelp<CR>

"des/activation de la correction orthographique fr*/*/*/
map <silent> <F7> "<Esc>:silent setlocal spell! spelllang=fr<CR>"

"substitution de Ctrll-AltGr-] par )
map ) 

"onglet suivant"
map <C-l> :tabnext<CR>
imap <C-l> :tabnext<CR>
"onglet précédent"
map <C-h> :tabprevious<CR>
imap <C-h> :tabprevious<CR>

"Espace pour déscendre d'une page en mode "normal"
map <Space> <c-d>
"Shift-Espace pour remonter d'une page en mode "normal"
"ne fonctionne pas
map <S-Space> <c-u>

"Excute des commandes git
map ,ga :!git add % <RETURN>
map ,gc :!git commit % -m 
map ,gp :!git push <RETURN>
"}}}

" Powerline{{{
set rtp+=/usr/lib/python3.5/site-packages/powerline/bindings/vim
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
" Permet, dans certains cas, de résoudre certains problèmes de coloration avec
" certains colorscheme. 
set t_Co=256
let g:powerline_pycmd="py3"
"}}}

" 4e conf{{{
" Utilise "," en place de "\" comme <leader>
let mapleader=","
"}}}

" Différents plugin{{{
" https://github.com/junegunn/vim-plug

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" Initialize plugin system
call plug#end()

" https://github.com/tpope/vim-pathogen
execute pathogen#infect()
"}}}

