# telescope-nodescripts.nvim
An extension for [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) to run the scripts from your `package.json`.

![demo](https://s6.gifyu.com/images/demo17b478e64ba6e9a2.gif)

## Requirements
- Neovim >= 0.5
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

## Install
Install with your preferred package manager, the following example uses [packer](https://github.com/wbthomason/packer.nvim):
```lua
use "luissimas/telescope-nodescripts.nvim",
```

## Setup
You can explicitly load the extension (but you don't need to).

```lua
require("telescope").load_extension("nodescripts")
```

The picker can be called using the `run` function:
```lua
require('telescope').extensions.nodescripts.run({})
```

No default keybindings are provided, you can set a keybinding for the extension like this:
```lua
vim.api.nvim_set_keymap("n", "<leader>fs", ":lua require('telescope').extensions.nodescripts.run({})<Enter>", {noremap = true, silent = true})
```

## Configuring
The extension can be configured using the `extensions` key in telescope's setup function. Here's a example configuration using the default values:

```lua
require("telescope").setup {
  extensions = {
      nodescripts = {
          command = "npm run",        -- command to run your node scripts
          display_method = "vsplit",  -- window method to open the terminal
          ignore_pre_post = true      -- ignore pre and post scripts
        }
    }
}
```

## Inspirations
[https://github.com/David-Kunz/jester](https://github.com/David-Kunz/jester)

[https://github.com/nvim-telescope/telescope-project.nvim](https://github.com/nvim-telescope/telescope-project.nvim)
