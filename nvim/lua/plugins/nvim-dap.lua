return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "jbyuki/one-small-step-for-vimkind",
      -- stylua: ignore
      config = function()
        local dap = require("dap")
        dap.adapters.nlua = function(callback, conf)
          local adapter = {
            type = "server",
            host = conf.host or "127.0.0.1",
            port = conf.port or 8086,
          }
          if conf.start_neovim then
            local dap_run = dap.run
            dap.run = function(c)
              adapter.port = c.port
              adapter.host = c.host
            end
            require("osv").run_this()
            dap.run = dap_run
          end
          callback(adapter)
        end
        dap.configurations.lua = {
          {
            type = "nlua",
            request = "attach",
            name = "Run this file",
            start_neovim = {},
          },
          {
            type = "nlua",
            request = "attach",
            name = "Attach to running Neovim instance (port = 8086)",
            port = 8086,
          },
        }
        dap.adapters.mix_task = {
          type = 'executable',
          command = vim.fn.stdpath("data") .. '/mason/bin/elixir-ls-debugger';
          args = {}
        }
--         dap.configurations.elixir = {
--           {
--             type = "mix_task",
--             name = "mix test",
--             task = 'test',
--             taskArgs = {"--trace"},
--             request = "launch",
--             startApps = true, -- for Phoenix projects
--             projectDir = "${workspaceFolder}",
--             requireFiles = {
--               "test/**/test_helper.exs",
--               "test/**/*_test.exs"
--             }
--           },
--           {
--             type = "mix_task",
--             name = "mix phx.server",
--             task = "phx.server",
--             request= "launch",
--             startApps = true,
--             projectDir= "${workspaceFolder}",
--             exitAfterTaskReturns= false,
--             debugAutoInterpretAllModules= false
--           }
--         }
      end,
    },
  },
}
