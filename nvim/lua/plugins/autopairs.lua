return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = { map_cr = true },
	config = function(_, global_opts)
		local npairs = require("nvim-autopairs")
		local Rule = require("nvim-autopairs.rule")

		npairs.setup(global_opts)

		npairs.add_rules({
			Rule("/*", "  */", { "javascript", "typescript", "javascriptreact", "typescriptreact" }):set_end_pair_length(
				3
			),
			Rule("<!", "--  -->", { "html" }):set_end_pair_length(5),
		})
	end,
}
