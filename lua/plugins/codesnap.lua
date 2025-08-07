return {
  "mistricky/codesnap.nvim",
  event = { "BufReadPre", "BufNewFile" },
  build = "make",
  keys = {
    { "<Leader>cs", ":'<,'>CodeSnap<cr>",              mode = { "v" }, desc = "CodeSnap (clipboard)" },
    { "<Leader>cS", ":'<,'>CodeSnapSave<cr>",          mode = { "v" }, desc = "CodeSnap (save)" },
    { "<Leader>ch", ":'<,'>CodeSnapHighlight<cr>",     mode = { "v" }, desc = "CodeSnap with highlight (clipboard)" },
    { "<Leader>cH", ":'<,'>CodeSnapSaveHighlight<cr>", mode = { "v" }, desc = "CodeSnap with highlight (save)" },
  },
  opts = {
    mac_window_bar = false,
    watermark = "",
    bg_padding = 0,
    save_path = os.getenv "XDG_PICTURES_DIR" or (os.getenv "HOME" .. "/Imágenes/Capturas"),
  },
}
