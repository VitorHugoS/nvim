return {
	"ibhagwan/fzf-lua",
	opts = {
		files = {
			fd_opts = [[--color=never --type f --hidden --follow --exclude .git --exclude node_modules --exclude target --exclude build --exclude dist]],
		},
		grep = {
			rg_opts = [[--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e --glob '!node_modules/*' --glob '!target/*' --glob '!build/*' --glob '!dist/*']],
		},
		winopts = {
			preview = {
				default = "bat",
			},
		},
	},
}
