---@type LazySpec
return {
  "3rd/image.nvim",
  event = { "BufReadPre", "BufNewFile" },
  enabled = vim.fn.executable "magick" == 1,
  opts = {
    backend = "kitty",
    processor = "magick_cli",
    integrations = {
      neorg = {
        enabled = true,
        clear_in_insert_mode = false,
        download_remote_images = true,
        only_render_image_at_cursor = false,
      },
    },
  },
}
