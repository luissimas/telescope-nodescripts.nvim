local json = require("telescope._extensions.nodescripts.json")
local pickers = require("telescope.pickers")
local actions = require("telescope.actions")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local themes = require("telescope.themes")

-- Config defaults
local defaults = {
  command = "npm run",
  display_method = "vsplit",
  ignore_pre_post = true
}

local config

local M = {}

function actions.run_command()
  local script = actions.get_selected_entry()[1]

  vim.cmd(":" .. config.display_method .. " | terminal")
  vim.cmd(":call jobsend(b:terminal_job_id, ['" .. config.command .. " " .. script .. "', ''])")
end

local function get_scripts()
  local file = assert(io.open("package.json", "r"))
  local package = json.decode(file:read("*a"))
  local scripts = {}

  for key, _ in pairs(package.scripts) do
    -- Removing pre and post scripts
    if config.ignore_pre_post then
      if not key:match("^pre") and not key:match("^post") then
        table.insert(scripts, key)
      end
    else
      table.insert(scripts, key)
    end
  end

  return scripts
end

function M.run(opts)
  opts = opts or {}
  local scripts = get_scripts()

  pickers.new(
    themes.get_dropdown({}),
    {
      prompt_title = "Scrips",
      finder = finders.new_table(scripts),
      sorter = sorters.get_fzy_sorter(),
      attach_mappings = function(_, map)
        map("i", "<cr>", actions.run_command)
        map("n", "<cr>", actions.run_command)
        return true
      end
    }
  ):find()
end

function M.setup(options)
  config = vim.tbl_deep_extend("force", defaults, options or {})
end

return M
