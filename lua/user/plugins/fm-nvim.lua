-- TODO: highlight current file
return {
	{
		"is0n/fm-nvim",
		event = "VeryLazy",
		opts = {
			ui = {
				default = "float",

				float = {
					-- Num from 0 - 1 for measurements
					height = 1,
					width  = 0.75,

					-- X and Y Axis of Window
					x      = 1,
					y      = 0.5
				},
			},
			edit_cmd = "edit",
			mappings = {
				vert_split = "<C-v>",
				horz_split = "<C-h>",
				tabedit    = "<C-t>",
				edit       = "<C-e>",
				ESC        = "<ESC>"
			},
		},

		config = function(_, opts)
			require('fm-nvim').setup(opts)
		end
	}
}
