return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "ravitemer/mcphub.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      adapters = {
        http = {
          openai = function()
            return require("codecompanion.adapters").extend("openai_responses", {
              env = {
                api_key = "OPENAI_API_KEY",
              },
              schema = {
                model = {
                  default = "gpt-4o",
                },
              },
            })
          end,
        },
      },
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
      },
    })
  end,

  opts = {
    -- NOTE: The log_level is in `opts.opts`
    opts = {
      log_level = "DEBUG", -- or "TRACE"
    },
  },
}
