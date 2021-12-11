" Vim syntax file
" Language:     savi
" Maintainer:   teggot

if exists('b:current_syntax')
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

syn case match

syn sync match saviSync grouphere NONE /\v^\s*:%(actor|class|struct|primitive|trait|new|be|fun|prop|import)>/

syn match   saviKwClass         /\v:(actor|class|struct|primitive|trait)/ nextgroup=@saviKeyword,@saviType2 skipwhite skipempty
hi def link saviKwClass         Structure

syn keyword saviKwControl       if case while try recover return
                        \       break continue error compile_intrinsic
                        \       compile_error iftype elseiftype
hi def link saviKwControl       Keyword

syn match   saviKwField         /\v:(prop|const|is)/
hi def link saviKwField         Keyword

" syn region  saviArgument        matchgroup=saviBracket start=/(/ end=/)/ contained nextgroup=saviArgument skipwhite
" syn   saviArgument        matchgroup=saviBracket start=/(/ end=/)/ contained contains=TOP nextgroup=saviArgument skipwhite

" syn region  saviParams          start=/(/ end=/)/ contains=saviParameters nextgroup=@saviType2
" syn region  saviParameters      start=/\v[_a-zA-Z]\w*/ end=/,/ contains=@saviType2
" syn match   saviParameters      /\v[_a-zA-Z]\w*/ nextgroup=@saviType2

" syn cluster saviType            contains=saviBuiltinType,saviUserType,saviNormal
" syn cluster saviType2           contains=saviBuiltinType,saviUserType2

" syn match   saviUserType2       /\v[_a-zA-Z]\w*/ contained nextgroup=saviTypeSuffix,saviTypeOperator2,saviKwOperatorT,saviGeneric,saviArgument skipwhite
" syn match   saviUserType        /\v_?[A-Z]\w*/ nextgroup=saviTypeSuffix,saviTypeOperator2,saviKwOperatorT,saviGeneric,saviArgument skipwhite

" syn match   saviUserNoNMethod   // nextgroup=saviParams,saviBracketT2
" hi def link saviUserNoNMethod   Function
syn match   saviUserMethod      /\v[_a-zA-Z]\w*/ contained contains=saviErrUserMethod nextgroup=saviUserNoNMethod skipwhite
hi def link saviUserMethod      Function

syn keyword saviKwFnCapability  ref val tag iso box trn non contained nextgroup=@saviKeyword,saviUserMethod,saviUserNoNMethod skipwhite skipempty
hi def link saviKwFnCapability  StorageClass
syn match   saviKwFunction      /:new/ nextgroup=saviUserMethod,saviUserNoNMethod skipwhite skipempty
syn match   saviKwFunction      /\v:(be|fun)/ nextgroup=saviKwFnCapability,@saviKeyword,saviUserMethod skipwhite skipempty
hi def link saviKwFunction      Keyword

syn match   saviKwUse           /:import/ nextgroup=saviString,@saviKeyword,saviUserPackage skipwhite skipempty
hi def link saviKwUse           Include

syn match   saviErrEscape       /\\\_.\?\_s*/ contained
hi def link saviErrEscape       Error
syn match   saviEscapeSQuote    /\\'/ contained
hi def link saviEscapeSQuote    SpecialChar
syn match   saviEscapeDQuote    /\\"/ contained
hi def link saviEscapeDQuote    SpecialChar
syn match   saviEscape          /\\[abefnrtv\\0]/ contained
syn match   saviEscape          /\v\\x\x{2}/ contained
syn match   saviEscape          /\v\\u\x{4}/ contained
syn match   saviEscape          /\v\\U\x{6}/ contained
hi def link saviEscape          SpecialChar

syn region  saviCharacter       matchgroup=saviCharacterX start=/\w\@<!'/ skip=/\\./ end=/'/ contains=saviEscapeSQuote,saviEscape,saviErrEscape
hi def link saviCharacter       Character

syn region  saviString          matchgroup=saviStringX start=/"/ skip=/\\./ end=/"/ contains=saviEscapeDQuote,saviEscape,saviErrEscape
hi def link saviString          String
syn match   saviDocumentString  @::.*$@ contains=saviDocumentStringX
hi def link saviDocumentString  String

syn keyword saviCommentShit     XXX contained
hi def link saviCommentShit     Underlined
syn keyword saviCommentDamn     FIXME contained
hi def link saviCommentDamn     Error
syn keyword saviCommentTodo     TODO contained
hi def link saviCommentTodo     Todo
syn cluster saviCommentNote     contains=saviCommentTodo,saviCommentDamn,saviCommentShit

syn match   saviComment         @//.*$@ contains=@saviCommentNote,saviCommentX
hi def link saviComment         Comment

" for indent check
syn match   saviCommentX        @/\ze/.*$@ contained transparent
hi def link saviNestedCommentX  Comment
hi def link saviCharacterX      Character
hi def link saviStringX         String
hi def link saviDocumentStringX String


let &cpo = s:cpo_save
unlet s:cpo_save

let b:current_syntax = 'savi'
