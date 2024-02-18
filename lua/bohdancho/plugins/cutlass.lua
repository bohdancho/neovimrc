-- Cutlass overrides the delete operations to actually just delete and not affect the current yank.
return {
    "gbprod/cutlass.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        exclude = { "xx" }, -- exclude x in visual mode for cutting
    },
}
