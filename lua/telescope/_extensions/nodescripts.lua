local json = require("telescope._extensions.json")
local pickers = require("telescope.pickers")
local actions = require("telescope.actions")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local themes = require("telescope.themes")

local ok, telescope = pcall(require, "telescope")

if not ok then
  error("Nodescripts requires telescope")
end

function actions.run_command()
  local script = actions.get_selected_entry()[1]

  vim.cmd(":vsplit | terminal")
  vim.cmd(':call jobsend(b:terminal_job_id, ["yarn run ' .. script .. '", ""])')
end

local function get_scripts()
  local file = assert(io.open("package.json", "r"))
  local package = json.decode(file:read("*a"))
  local scripts = {}

  for key, _ in pairs(package.scripts) do
    -- Removing pre and post scripts
    if not key:match("^pre") and not key:match("^post") then
      table.insert(scripts, key)
    end
  end

  return scripts
end

function run(opts)
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

function reload()
  package.loaded["telescope-node-scripts"] = nil
end

return telescope.register_extension(
  {
    exports = {
      run = run,
      reload = reload
    }
  }
)
