local main = require("telescope._extensions.nodescripts.main")

local ok, telescope = pcall(require, "telescope")

if not ok then
	error("Nodescripts requires telescope")
end

return telescope.register_extension({
	setup = main.setup,
	exports = {
		run = main.run,
	},
})
