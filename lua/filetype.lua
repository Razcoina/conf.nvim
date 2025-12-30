-- Manually add file type that should be auto-detected but are not
vim.filetype.add {
  filename = {
    Doxyfile = "ini",
  },
}
