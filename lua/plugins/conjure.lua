return {
  "Olical/conjure",
  ft = { "clojure", "fennel" },
  config = function()
    vim.g["conjure#log#hud#enabled"] = true
    vim.g["conjure#log#hud#width"] = 0.5
    vim.g["conjure#log#hud#anchor"] = "SE"
    vim.g["conjure#log#wrap"] = true

    vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false
    vim.g["conjure#client#clojure#nrepl#eval#auto_require"] = false

    vim.g["conjure#highlight#enabled"] = true
    vim.g["conjure#highlight#timeout"] = 500

    vim.g["conjure#mapping#doc_word"] = false
    vim.g["conjure#mapping#def_word"] = false
  end,
}
