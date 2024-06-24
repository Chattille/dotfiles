;; extends

; text
(text
  word: (word) @text)
; integers
((text
  word: (word) @number) @_parent
  (#lua-match? @number "^%d+$")
  (#not-has-parent? @_parent inline_formula))
; floats
((text
  word: (word) @number.float) @_parent
  (#lua-match? @number.float "^%d*.%d+$")
  (#not-has-parent? @_parent inline_formula))

;;;; conceals

; operators
(generic_command
  command: (command_name) @operator
  (#any-of? @operator "\\div" "\\times")
  (#conceal-pairs! @operator
   "\\div" "÷"
   "\\times" "×"))

; greek letters
(generic_command
  command: (command_name) @text
  (#any-of? @text
   "\\alpha"   "\\Alpha"
   "\\beta"    "\\Beta"
   "\\gamma"   "\\Gamma"
   "\\delta"   "\\Delta"
   "\\epsilon" "\\Epsilon"
   "\\zeta"    "\\Zeta"
   "\\eta"     "\\Eta"
   "\\theta"   "\\Theta"
   "\\iota"    "\\Iota"
   "\\kappa"   "\\Kappa"
   "\\lambda"  "\\Lambda"
   "\\mu"      "\\Mu"
   "\\nu"      "\\Nu"
   "\\xi"      "\\Xi"
   "\\omicron" "\\Omicron"
   "\\pi"      "\\Pi"
   "\\rho"     "\\Rho"
   "\\sigma"   "\\Sigma"
   "\\tau"     "\\Tau"
   "\\upsilon" "\\Upsilon"
   "\\phi"     "\\Phi"
   "\\chi"     "\\Chi"
   "\\psi"     "\\Psi"
   "\\omega"   "\\Omega"
   )
  (#conceal-pairs! @text
   "\\alpha"   "α"      "\\Alpha"   "Α"
   "\\beta"    "β"      "\\Beta"    "Β"
   "\\gamma"   "γ"      "\\Gamma"   "Γ"
   "\\delta"   "δ"      "\\Delta"   "Δ"
   "\\epsilon" "ε"      "\\Epsilon" "Ε"
   "\\zeta"    "ζ"      "\\Zeta"    "Ζ"
   "\\eta"     "η"      "\\Eta"     "Η"
   "\\theta"   "θ"      "\\Theta"   "Θ"
   "\\iota"    "ι"      "\\Iota"    "Ι"
   "\\kappa"   "κ"      "\\Kappa"   "Κ"
   "\\lambda"  "λ"      "\\Lambda"  "Λ"
   "\\mu"      "μ"      "\\Mu"      "Μ"
   "\\nu"      "ν"      "\\Nu"      "Ν"
   "\\xi"      "ξ"      "\\Xi"      "Ξ"
   "\\omicron" "ο"      "\\Omicron" "Ο"
   "\\pi"      "π"      "\\Pi"      "Π"
   "\\rho"     "ρ"      "\\Rho"     "Ρ"
   "\\sigma"   "σ"      "\\Sigma"   "Σ"
   "\\tau"     "τ"      "\\Tau"     "Τ"
   "\\upsilon" "υ"      "\\Upsilon" "Υ"
   "\\phi"     "φ"      "\\Phi"     "Φ"
   "\\chi"     "χ"      "\\Chi"     "Χ"
   "\\psi"     "ψ"      "\\Psi"     "Ψ"
   "\\omega"   "ω"      "\\Omega"   "Ω"
   ))

; super-/subscripts; only for one-digit scripts
(superscript
  "^" @conceal
  superscript: (letter) @text
  (#lua-match? @text "^%d$")
  (#conceal-pairs! @text
   "1" "¹"    "2" "²"    "3" "³"
   "4" "⁴"    "5" "⁵"    "6" "⁶"
   "7" "⁷"    "8" "⁸"    "9" "⁹"    "0" "⁰")
  (#set! @conceal conceal ""))
(subscript
  "_" @conceal
  subscript: (letter) @text
  (#lua-match? @text "^%d$")
  (#conceal-pairs! @text
   "1" "₁"    "2" "₂"    "3" "₃"
   "4" "₄"    "5" "₅"    "6" "₆"
   "7" "₇"    "8" "₈"    "9" "₉"    "0" "₀")
  (#set! @conceal conceal ""))
