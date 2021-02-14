syn match goOperator /[-+%<>!&|^*=]=\?/
syn match goOperator /\/\%(=\|\ze[^/*]\)/
syn match goOperator /\%(<<\|>>\|&^\)=\?/
syn match goOperator /:=\|||\|<-\|++\|--/
hi def link goOperator Operator
syn keyword goNil nil
hi def link goNil Number
syn match goDeclaration       /\<func\>/ nextgroup=goReceiver,goFunction,goSimpleParams skipwhite skipnl
syn match goReceiverVar       /\w\+\ze\s\+\%(\w\|\*\)/ nextgroup=goPointerOperator,goReceiverType skipwhite skipnl contained
syn match goPointerOperator   /\*/ nextgroup=goReceiverType contained skipwhite skipnl
syn match goFunction          /\w\+/ nextgroup=goSimpleParams contained skipwhite skipnl
syn match goReceiverType      /\w\+/ contained
syn match goReceiver          /(\s*\w\+\%(\s\+\*\?\s*\w\+\)\?\s*)\ze\s*\w/ contained nextgroup=goFunction contains=goReceiverVar skipwhite skipnl
hi def link goPointerOperator goOperator
hi def link goFunction  Function

syn match   goHexadecimalInt "\<0x[0-9a-fA-F_]*\x\>"
syn match   goBinaryInt      "\<0b[01_]*[01]\>"
hi def link goBinaryInt      Number
