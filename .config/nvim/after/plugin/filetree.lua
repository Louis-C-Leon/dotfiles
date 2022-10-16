pcall(function()
    local util = require('louis.util')
    vim.cmd('let g:neo_tree_remove_legacy_commands = 1')

    require('neo-tree').setup({
        sources = { "filesystem" },
        use_default_mappings = false,
        enable_diagnostics = false,
        enable_git_status = false,
        use_popups_for_input = false,
        default_component_configs = {
            container = { enable_character_fade = false },
            indent = { padding = 0, with_markers = false, with_expanders = false },
            name = {
                trailing_slash = true,
                -- use_git_status_colors = true,
            },
        },
        renderers = {
            directory = {
                { "indent" },
                {
                    "container",
                    content = {
                        { "name", zindex = 10 },
                        { "clipboard", zindex = 10 },
                    },
                },
            },
            file = {
                { "indent" },
                {
                    "container",
                    content = {
                        {
                            "name",
                            zindex = 10
                        },
                        { "clipboard", zindex = 10 },
                        { "bufnr", zindex = 10 },
                        { "modified", zindex = 20, align = "right" },
                    },
                },
            },
            message = {
                { "indent", with_markers = false },
                { "name", highlight = "NeoTreeMessage" },
            },
            terminal = {
                { "indent" },
                { "name" },
                { "bufnr" }
            }
        },
        window = {
            position = "left",
            width = "50",
            mapping_options = {
                noremap = true,
                nowait = true,
            },
            mappings = {
                ["<cr>"] = "open",
                ["<c-s>"] = "open_split",
                ["<c-v>"] = "open_vsplit",
                ["a"] = {
                    "add",
                    config = {
                        show_path = "none"
                    }
                },
                ["d"] = "delete",
                ["r"] = "rename",
                ["m"] = "move", -- takes text input for destination, also accepts the config.show_path option
                ["q"] = "close_window",
                ["<c-[>"] = "close_window",
                ["<esc>"] = "close_window",
                ["<bs>"] = "close_node",
            },
        },
        filesystem = {
            filtered_items = { visible = true },
          },
    })

    util.ncmd('<leader>t', 'Neotree reveal')
end)
