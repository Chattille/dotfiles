;; extends

((predicate
  name: (identifier) @_name
  parameters: (parameters
    (string) @injection.content))
  (#any-of? @_name "lua-match" "not-lua-match" "any-lua-match" "lua-match-clip")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "luap"))
