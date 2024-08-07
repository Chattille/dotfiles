;; extends

;;;; conceals

; unordered list markers
((list_marker_plus) @punctuation.special
  (#lua-match-clip! @punctuation.special "\+")
  (#set! conceal "•"))
((list_marker_star) @punctuation.special
  (#lua-match-clip! @punctuation.special "\*")
  (#set! conceal "•"))
((list_marker_minus) @punctuation.special
  (#lua-match-clip! @punctuation.special "-")
  (#set! conceal "•"))

; task list markers
(list_item
  (list_marker_plus) @_task_item
  .
  [(task_list_marker_checked) (task_list_marker_unchecked)]
  (#lua-match-clip! @_task_item "\+%s+")
  (#set! @_task_item conceal ""))
(list_item
  (list_marker_star) @_task_item
  .
  [(task_list_marker_checked) (task_list_marker_unchecked)]
  (#lua-match-clip! @_task_item "\*%s+")
  (#set! @_task_item conceal ""))
(list_item
  (list_marker_minus) @_task_item
  .
  [(task_list_marker_checked) (task_list_marker_unchecked)]
  (#lua-match-clip! @_task_item "-%s+")
  (#set! @_task_item conceal ""))
(list_item
  (task_list_marker_checked) @markup.list.checked
  (#lua-match-clip! @markup.list.checked "x")
  (#set! @markup.list.checked conceal "✓"))
(list_item
  (task_list_marker_checked)
  (_) @markup.list.checked) ; dim checked items

; blockquotes markers
((block_quote_marker) @punctuation.delimiter
  (#lua-match-clip! @punctuation.delimiter ">")
  (#set! conceal "󰝗"))
((block_continuation) @punctuation.delimiter
  (#has-ancestor? @punctuation.delimiter block_quote)
  (#lua-match? @punctuation.delimiter ">%s*")
  (#lua-match-clip! @punctuation.delimiter ">")
  (#set! @punctuation.delimiter conceal "▌"))

; fenced code blocks
(fenced_code_block
  (info_string
    (language) @label
    (#devicon! @label)))

; tables
(pipe_table_header
  "|" @punctuation.special
  (#set! @punctuation.special conceal "│"))
(pipe_table_delimiter_row
  "|" @punctuation.special
  (#set! @punctuation.special conceal "│"))
(pipe_table_delimiter_cell
  "-" @punctuation.special
  (#set! @punctuation.special conceal "═"))
(pipe_table_row
  "|" @punctuation.special
  (#set! @punctuation.special conceal "│"))
