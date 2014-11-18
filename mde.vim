" Vim syntax file
" Language:     Markdown-Extended
" Maintainer:   Pierre Cassat <aboutmde.org> from original work by Tim Pope <vimNOSPAM@tpope.org>
" Filenames:    *.mde *.md *.mde
" Last Change:	18/11/2014

if exists("b:current_syntax")
  finish
endif

runtime! syntax/html.vim
unlet! b:current_syntax

syn sync minlines=10
syn case ignore

syn match mdeValid '[<>]\S\@!'
syn match mdeValid '&\%(#\=\w*;\)\@!'

syn match mdeLineStart "^[<@]\@!" nextgroup=@mdeBlock

syn cluster mdeBlock contains=mdeH1,mdeH2,mdeH3,mdeH4,mdeH5,mdeH6,mdeHX,mdeBlockquote,mdeListMarker,mdeOrderedListMarker,mdeCodeBlock,mdeRule
syn cluster mdeInline contains=mdeLineBreak,mdeLinkText,mdeItalic,mdeBold,mdeCode,mdeEscape,@htmlTop

syn match mdeH1 ".\+\n=\+$" contained contains=@mdeInline,mdeHeadingRule
syn match mdeH2 ".\+\n-\+$" contained contains=@mdeInline,mdeHeadingRule

syn match mdeHeadingRule "^[=-]\+$" contained

syn region mdeH1 matchgroup=mdeHeadingDelimiter start="##\@!"        end="#*\s*$" keepend oneline contains=@mdeInline contained
syn region mdeH2 matchgroup=mdeHeadingDelimiter start="###\@!"       end="#*\s*$" keepend oneline contains=@mdeInline contained
syn region mdeH3 matchgroup=mdeHeadingDelimiter start="####\@!"      end="#*\s*$" keepend oneline contains=@mdeInline contained
syn region mdeH4 matchgroup=mdeHeadingDelimiter start="#####\@!"     end="#*\s*$" keepend oneline contains=@mdeInline contained
syn region mdeH5 matchgroup=mdeHeadingDelimiter start="######\@!"    end="#*\s*$" keepend oneline contains=@mdeInline contained
syn region mdeH6 matchgroup=mdeHeadingDelimiter start="#######\@!"   end="#*\s*$" keepend oneline contains=@mdeInline contained
syn region mdeHX matchgroup=mdeHeadingDelimiter start="########+\@!" end="#*\s*$" keepend oneline contains=@mdeInline contained

syn match mdeBlockquote ">\s" contained nextgroup=@mdeBlock

syn region mdeCodeBlock start="    \|\t" end="$" contained

" TODO: real nesting
syn match mdeListMarker " \{0,4\}[-*+]\%(\s\+\S\)\@=" contained
syn match mdeOrderedListMarker " \{0,4}\<\d\+\.\%(\s*\S\)\@=" contained

syn match mdeRule "\* *\* *\*[ *]*$" contained
syn match mdeRule "- *- *-[ -]*$" contained

syn match mdeLineBreak "\s\{2,\}$"

syn region mdeIdDeclaration matchgroup=mdeLinkDelimiter start="^ \{0,3\}!\=\[" end="\]:" oneline keepend nextgroup=mdeUrl skipwhite
syn match mdeUrl "\S\+" nextgroup=mdeUrlTitle skipwhite contained
syn region mdeUrl matchgroup=mdeUrlDelimiter start="<" end=">" oneline keepend nextgroup=mdeUrlTitle skipwhite contained
syn region mdeUrlTitle matchgroup=mdeUrlTitleDelimiter start=+"+ end=+"+ keepend contained
syn region mdeUrlTitle matchgroup=mdeUrlTitleDelimiter start=+'+ end=+'+ keepend contained
syn region mdeUrlTitle matchgroup=mdeUrlTitleDelimiter start=+(+ end=+)+ keepend contained

syn region mdeLinkText matchgroup=mdeLinkTextDelimiter start="!\=\[\%(\_[^]]*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" keepend nextgroup=mdeLink,mdeId skipwhite contains=@mdeInline,mdeLineStart
syn region mdeLink matchgroup=mdeLinkDelimiter start="(" end=")" contains=mdeUrl keepend contained
syn region mdeId matchgroup=mdeIdDelimiter start="\[" end="\]" keepend contained
syn region mdeAutomaticLink matchgroup=mdeUrlDelimiter start="<\%(\w\+:\|[[:alnum:]_+-]\+@\)\@=" end=">" keepend oneline

syn region mdeItalic start="\S\@<=\*\|\*\S\@=" end="\S\@<=\*\|\*\S\@=" keepend contains=mdeLineStart
syn region mdeItalic start="\S\@<=_\|_\S\@=" end="\S\@<=_\|_\S\@=" keepend contains=mdeLineStart
syn region mdeBold start="\S\@<=\*\*\|\*\*\S\@=" end="\S\@<=\*\*\|\*\*\S\@=" keepend contains=mdeLineStart
syn region mdeBold start="\S\@<=__\|__\S\@=" end="\S\@<=__\|__\S\@=" keepend contains=mdeLineStart
syn region mdeBoldItalic start="\S\@<=\*\*\*\|\*\*\*\S\@=" end="\S\@<=\*\*\*\|\*\*\*\S\@=" keepend contains=mdeLineStart
syn region mdeBoldItalic start="\S\@<=___\|___\S\@=" end="\S\@<=___\|___\S\@=" keepend contains=mdeLineStart
syn region mdeCode matchgroup=mdeCodeDelimiter start="`" end="`" transparent keepend contains=mdeLineStart
syn region mdeCode matchgroup=mdeCodeDelimiter start="`` \=" end=" \=``" keepend contains=mdeLineStart

syn match mdeEscape "\\[][\\`*_{}()#+.!-]"

hi def link mdeH1                    htmlH1
hi def link mdeH2                    htmlH2
hi def link mdeH3                    htmlH3
hi def link mdeH4                    htmlH4
hi def link mdeH5                    htmlH5
hi def link mdeH6                    htmlH6
hi def link mdeHX                    htmlBold
hi def link mdeHeadingRule           mdeRule
hi def link mdeHeadingDelimiter      Delimiter
hi def link mdeOrderedListMarker     mdeListMarker
hi def link mdeListMarker            htmlTagName
hi def link mdeBlockquote            Comment
hi def link mdeRule                  PreProc

hi def link mdeLinkText              htmlLink
hi def link mdeIdDeclaration         Typedef
hi def link mdeId                    Type
hi def link mdeAutomaticLink         mdeUrl
hi def link mdeUrl                   Float
hi def link mdeUrlTitle              String
hi def link mdeIdDelimiter           mdeLinkDelimiter
hi def link mdeUrlDelimiter          htmlTag
hi def link mdeUrlTitleDelimiter     Delimiter

hi def link mdeItalic                htmlItalic
hi def link mdeBold                  htmlBold
hi def link mdeBoldItalic            htmlBoldItalic
hi def link mdeCodeDelimiter         Delimiter

hi def link mdeEscape                Special

let b:current_syntax = "mde-extended"

" vim:set sw=2:
