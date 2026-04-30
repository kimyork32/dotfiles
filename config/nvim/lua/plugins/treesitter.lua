return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" }, -- load when a buffer is opened or created
		build = ":TSUpdate",
        -- Se elimina el módulo 'config' obsoleto. Las opciones de auto_install,
        -- highlight y demás ahora son manejadas nativamente o ya no se usan así.
	},
}
