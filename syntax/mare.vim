" Vim syntax file
" Language:     Mare
" Maintainer:   teggot

if exists('b:current_syntax')
  finish
endif

let s:cpo_save = &cpo
set cpo&vim


syn case match

syn sync match mareSync grouphere NONE /\v^\s*:%(actor|class|struct|primitive|trait|new|be|fun|prop|import)>/

syn match   mareKwClass         /\v:(actor|class|struct|primitive|trait)/ nextgroup=@mareKeyword,@mareType2 skipwhite skipempty
hi def link mareKwClass         Structure

syn keyword mareKwControl       if case while try recover return
                        \       break continue error compile_intrinsic
                        \       compile_error iftype elseiftype
hi def link mareKwControl       Keyword

syn match   mareKwField         /\v:(prop|const|is)/
hi def link mareKwField         Keyword

" syn region  mareArgument        matchgroup=mareBracket start=/(/ end=/)/ contained nextgroup=mareArgument skipwhite
" syn   mareArgument        matchgroup=mareBracket start=/(/ end=/)/ contained contains=TOP nextgroup=mareArgument skipwhite

" syn region  mareParams          start=/(/ end=/)/ contains=mareParameters nextgroup=@mareType2
" syn region  mareParameters      start=/\v[_a-zA-Z]\w*/ end=/,/ contains=@mareType2
" syn match   mareParameters      /\v[_a-zA-Z]\w*/ nextgroup=@mareType2

" syn cluster mareType            contains=mareBuiltinType,mareUserType,mareNormal
" syn cluster mareType2           contains=mareBuiltinType,mareUserType2

" syn match   mareUserType2       /\v[_a-zA-Z]\w*/ contained nextgroup=mareTypeSuffix,mareTypeOperator2,mareKwOperatorT,mareGeneric,mareArgument skipwhite
" syn match   mareUserType        /\v_?[A-Z]\w*/ nextgroup=mareTypeSuffix,mareTypeOperator2,mareKwOperatorT,mareGeneric,mareArgument skipwhite

" syn match   mareUserNoNMethod   // nextgroup=mareParams,mareBracketT2
" hi def link mareUserNoNMethod   Function
syn match   mareUserMethod      /\v[_a-zA-Z]\w*/ contained contains=mareErrUserMethod nextgroup=mareUserNoNMethod skipwhite
hi def link mareUserMethod      Function

syn keyword mareKwFnCapability  ref val tag iso box trn non contained nextgroup=@mareKeyword,mareUserMethod,mareUserNoNMethod skipwhite skipempty
hi def link mareKwFnCapability  StorageClass
syn match   mareKwFunction      /:new/ nextgroup=mareUserMethod,mareUserNoNMethod skipwhite skipempty
syn match   mareKwFunction      /\v:(be|fun)/ nextgroup=mareKwFnCapability,@mareKeyword,mareUserMethod skipwhite skipempty
hi def link mareKwFunction      Keyword

syn match   mareKwUse           /:import/ nextgroup=mareString,@mareKeyword,mareUserPackage skipwhite skipempty
hi def link mareKwUse           Include

syn match   mareErrEscape       /\\\_.\?\_s*/ contained
hi def link mareErrEscape       Error
syn match   mareEscapeSQuote    /\\'/ contained
hi def link mareEscapeSQuote    SpecialChar
syn match   mareEscapeDQuote    /\\"/ contained
hi def link mareEscapeDQuote    SpecialChar
syn match   mareEscape          /\\[abefnrtv\\0]/ contained
syn match   mareEscape          /\v\\x\x{2}/ contained
syn match   mareEscape          /\v\\u\x{4}/ contained
syn match   mareEscape          /\v\\U\x{6}/ contained
hi def link mareEscape          SpecialChar

syn region  mareCharacter       matchgroup=mareCharacterX start=/\w\@<!'/ skip=/\\./ end=/'/ contains=mareEscapeSQuote,mareEscape,mareErrEscape
hi def link mareCharacter       Character

syn region  mareString          matchgroup=mareStringX start=/"/ skip=/\\./ end=/"/ contains=mareEscapeDQuote,mareEscape,mareErrEscape
hi def link mareString          String
syn match   mareDocumentString  @::.*$@ contains=mareDocumentStringX
hi def link mareDocumentString  String

syn keyword mareCommentShit     XXX contained
hi def link mareCommentShit     Underlined
syn keyword mareCommentDamn     FIXME contained
hi def link mareCommentDamn     Error
syn keyword mareCommentTodo     TODO contained
hi def link mareCommentTodo     Todo
syn cluster mareCommentNote     contains=mareCommentTodo,mareCommentDamn,mareCommentShit

syn match   mareComment         @//.*$@ contains=@mareCommentNote,mareCommentX
hi def link mareComment         Comment

" for indent check
syn match   mareCommentX        @/\ze/.*$@ contained transparent
hi def link mareNestedCommentX  Comment
hi def link mareCharacterX      Character
hi def link mareStringX         String
hi def link mareDocumentStringX String


let &cpo = s:cpo_save
unlet s:cpo_save

let b:current_syntax = 'mare'
