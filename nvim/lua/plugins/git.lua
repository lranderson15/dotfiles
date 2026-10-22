return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- Show added, changed, and deleted lines in the sign column.
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },

      -- Show deleted lines in a preview at the end of the buffer.
      signs_staged_enable = true,
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,

      -- Don't show signs for files over this size.
      max_file_length = 40000,

      -- Keymaps
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, {
            buffer = bufnr,
            desc = desc,
          })
        end

        -- Navigate between changed lines/hunks.
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.next_hunk()
          end
        end, "Next Git change")

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.prev_hunk()
          end
        end, "Previous Git change")

        -- Stage and reset changes.
        map({ "n", "v" }, "<leader>hs", gs.stage_hunk, "Stage hunk")
        map({ "n", "v" }, "<leader>hr", gs.reset_hunk, "Reset hunk")
        map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")

        -- Inspect changes.
        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>hb", function()
          gs.blame_line({ full = true })
        end, "Blame line")
        map("n", "<leader>hd", gs.diffthis, "Diff this file")
        map("n", "<leader>hD", function()
          gs.diffthis("~")
        end, "Diff against previous commit")

        -- Toggle inline blame.
        map("n", "<leader>tb", gs.toggle_current_line_blame,
          "Toggle line blame")
      end,
    },
  },
}

