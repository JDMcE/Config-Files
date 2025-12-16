return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        -- Enter should NOT accept completion
        ["<CR>"] = { "fallback" },

        -- Explicit accept (VS Code style)
        ["<C-y>"] = { "accept" },

        -- Optional: Tab navigation
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },

      completion = {
        -- No auto insert / auto select
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },
      },
    },
  },
}
