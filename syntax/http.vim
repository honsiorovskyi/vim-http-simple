if exists('b:current_syntax')
  finish
endif

let b:current_syntax = "http"

syn match Comment '#.*$'
syn match Comment '//.*$'

" request
syn region httpRequest start='\c^\%(HEAD\|GET\|POST\|PUT\|PATCH\|DELETE\|OPTIONS\)' end='\c\ze\n\+\%(HEAD\|GET\|POST\|PUT\|PATCH\|DELETE\|OPTIONS\)' contains=httpRequestSignature,httpHeaderName,httpJSON,httpResponse fold
syn match httpRequestSignature '\c^\%(HEAD\|GET\|POST\|PUT\|PATCH\|DELETE\|OPTIONS\)' contained nextgroup=httpRequestURL skipwhite
syn match httpRequestURL '\c.*HTTP'me=e-4 contained nextgroup=httpRequestVersion
syn match httpRequestVersion '.*' contained

" response
syn region httpResponse start='\c^HTTP/[0-9\.]*' end='\c\ze\n\+\%(HEAD\|GET\|POST\|PUT\|PATCH\|DELETE\|OPTIONS\|HTTP/[0-9\.]*\)' contains=httpResponseSignature,httpHeaderName,httpJSON fold
syn match httpResponseSignature '\c^HTTP/[0-9\.]*' contained nextgroup=httpStatus2xx,httpStatus3xx,httpStatus4xx,httpStatus5xx skipwhite
syn match httpStatus2xx '2\d\d.*$' contained
syn match httpStatus3xx '3\d\d.*$' contained
syn match httpStatus4xx '4\d\d.*$' contained
syn match httpStatus5xx '5\d\d.*$' contained

" headers
syn match httpHeaderName '^\h[[:alpha:]-]*:'me=e-1 nextgroup=httpHeaderValue skipwhite
syn match httpHeaderValue '.*$' contained contains=httpHeaderValueSeparators
syn match httpHeaderValueSeparators '[;,]' contained

hi def link httpHeaderName Keyword
hi httpHeaderValueSeparators ctermfg=27 cterm=bold

" payload
syn region httpJSON start='^{' end='}' contains=httpJSONString,httpJSONNumber
syn region httpJSON start='^\[' end='\]' contains=httpJSONString,httpJSONNumber

syn region httpJSONString start='"' end='"' contained
syn match httpJSONNumber '[0-9]\+' contained

" predefined colors
hi def link httpRequestSignature PreProc
hi def link httpRequestVersion PreProc
hi def link httpResponseSignature PreProc
hi def link httpJSONString String
hi def link httpJSONNumber Number

hi httpRequestURL ctermfg=16 cterm=bold
hi httpStatus2xx ctermfg=28 cterm=bold
hi httpStatus3xx ctermfg=31 cterm=bold
hi httpStatus4xx ctermfg=214 cterm=bold
hi httpStatus5xx ctermfg=196 cterm=bold
hi httpHeaderValueSeparators ctermfg=27 cterm=bold
