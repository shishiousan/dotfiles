local wpath = vim.fn.stdpath("config").."/spell/en.utf8.add"
local words = {}
local capabilities = vim.lsp.protocol.make_client_capabilities()

for word in io.open(wpath, "r"):lines() do
  table.insert(words, word)
end

require('lspconfig').ltex.setup{
  -- on_attach = on_attach,
  capabilities = capabilities,
  setting = {
    ltex ={
      disableRules = {
          ['en-US'] = {'PROFANITY'}
      },
      dictionary = {
        ['en-US'] = {'Shion', 'Eulerian'}
      },
    },
  },
}
