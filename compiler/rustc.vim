" Vim compiler file
" Compiler:         Rust Compiler
" Maintainer:       Chris Morgan <me@chrismorgan.info>
" Latest Revision:  2013 Jul 12
" For bugs, patches and license go to https://github.com/rust-lang/rust.vim

if exists("current_compiler")
    finish
endif
let current_compiler = "rustc"

" vint: -ProhibitAbbreviationOption
let s:save_cpo = &cpo
set cpo&vim
" vint: +ProhibitAbbreviationOption

if exists(":CompilerSet") != 2
    command -nargs=* CompilerSet setlocal <args>
endif

if get(g:, 'rustc_makeprg_no_percent', 0)
    CompilerSet makeprg=rustc
else
    if has('patch-7.4.191')
      CompilerSet makeprg=rustc\ \%:S
    else
      CompilerSet makeprg=rustc\ \"%\"
    endif
endif

" New errorformat (after nightly 2016/08/10)
CompilerSet errorformat=
            \%-G,
            \%-Gerror:\ aborting\ %.%#,
            \%-Gerror:\ Could\ not\ compile\ %.%#,
            \%-Gnote:\ %[rR]un\ with\ \`RUST_BACKTRACE=%.%#,
            \%+E%.%#panicked\ at\ %f:%l:%c:,
            \%+Cassertion%.%#,
            \%Eerror:\ %m,
            \%Eerror[E%n]:\ %m,
            \%Wwarning:\ %m,
            \%C%\\s%#-->\ %f:%l:%c,

" Old errorformat (before nightly 2016/08/10)
CompilerSet errorformat+=
            \%f:%l:%c:\ %t%*[^:]:\ %m,
            \%f:%l:%c:\ %*\\d:%*\\d\ %t%*[^:]:\ %m,
            \%-G%f:%l\ %s,
            \%-G%*[\ ]^,
            \%-G%*[\ ]^%*[~],
            \%-G%*[\ ]...

" vint: -ProhibitAbbreviationOption
let &cpo = s:save_cpo
unlet s:save_cpo
" vint: +ProhibitAbbreviationOption

" vim: set et sw=4 sts=4 ts=8:
