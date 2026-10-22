
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",

    config = function()
      local treesitter = require("nvim-treesitter")

      -- Parsers to install and keep available.
      local parsers = {
        "lua",
        "python",
        "c",
        "cpp",
        "bash",
        "json",
        "markdown",
        "markdown_inline",
        "java",
        "rust",
        "go",
        "systemverilog",
      }

      -- Install missing parsers asynchronously.
      -- Already-installed parsers are skipped.
      treesitter.install(parsers)

      -- Map Neovim filetypes to Tree-sitter parser names.
      local filetype_parsers = {
        lua = "lua",
        python = "python",
        c = "c",
        cpp = "cpp",
        bash = "bash",
        sh = "bash",
        json = "json",
        markdown = "markdown",
        java = "java",
        rust = "rust",
        go = "go",
        verilog = "systemverilog",
      }

      local group = vim.api.nvim_create_augroup(
        "UserTreeSitter",
        { clear = true }
      )

      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        callback = function(event)
          local filetype = vim.bo[event.buf].filetype
          local parser = filetype_parsers[filetype]

          if not parser then
            return
          end

          -- Enable Tree-sitter highlighting.
          -- pcall avoids errors if installation is not
          -- finished yet or the parser is unavailable.
          local ok = pcall(
            vim.treesitter.start,
            event.buf,
            parser
          )

          if not ok then
            return
          end

          -- Enable Tree-sitter-based folding.
          -- Keep folds open by default.
          local win = vim.fn.bufwinid(event.buf)

          if win ~= -1 then
            vim.wo[win].foldmethod = "expr"
            vim.wo[win].foldexpr =
              "v:lua.vim.treesitter.foldexpr()"
            vim.wo[win].foldlevel = 99
          end
        end,
      })
    end,
  },
}

