return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            bigfile = { enabled = true },
            notifier = {
                enabled = false,
                style = "minimal",
            },
            image = {
                doc = {
                    enabled = true,
                    inline = true,
                },
            },
            picker = {
                enabled = true,
                matcher = {
                    frecency = true,
                },
            },
        },
    },
}
