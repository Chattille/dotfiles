;; extends

;;;; conceals

; links
((uri_autolink) @markup.link.url
  (#lua-match-clip! @markup.link.url "<")
  (#set! conceal ""))
((uri_autolink) @markup.link.url
  (#lua-match-clip! @markup.link.url ">")
  (#set! conceal ""))

; images
(image
  "!" @markup.link
  (#set! conceal ""))
(image
  "[" @markup.link
  (#set! conceal " "))

; (fake) footnote; only conceal those with a single number
(shortcut_link
  (link_text) @markup.link.label
  (#lua-match? @markup.link.label "^\^%d$")
  (#conceal-pairs! @markup.link.label
   "^1" "¹"    "^2" "²"    "^3" "³"
   "^4" "⁴"    "^5" "⁵"    "^6" "⁶"
   "^7" "⁷"    "^8" "⁸"    "^9" "⁹"    "^0" "⁰"))

; math
((latex_span_delimiter) @conceal
  (#set! conceal ""))
