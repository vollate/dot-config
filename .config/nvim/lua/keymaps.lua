local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Basic keymaps
map('n', 'S', ':w<CR>', opts)
map('n', 'Q', ':q<CR>', opts)
map('n', '<C-h>', '0', opts)
map('n', '<C-l>', '$', opts)
map('v', '<C-h>', '0', opts)
map('v', '<C-l>', '$', opts)
map('o', '<C-h>', '0', opts)
map('o', '<C-l>', '$', opts)
map('n', '<C-q>', ':Bdelete<CR>', opts)
map('n', '<C-k><C-q>', ':bufdo Bdelete<CR>', opts)
map('x', '<', '<gv', opts)
map('x', '>', '>gv', opts)
map('x', '<C-C>', '"+y1', opts)
map('n', 'Y', 'yy', opts) -- why NeoVim make this behavior different from Vim?

-- Plugin keymaps
map('n', '<F1>', ':nohlsearch<CR>', opts)
map('n', '<F2>', ':UndotreeToggle<CR>', opts)

-- Copilot
vim.keymap.set("i", "<C-J>", function()
    return vim.fn["copilot#Accept"]("\r")
end, {
    silent = true,
    expr = true,
    script = true,
})
vim.g.copilot_no_tab_map = true

-- Bufferline (replacing airline)
for i = 1, 9 do
    map('n', '<leader>' .. i, function()
        require('bufferline').go_to_buffer(i, true)
    end, opts)
end
map('n', '<leader>-', '<Cmd>BufferLineCyclePrev<CR>', opts)
map('n', '<leader>=', '<Cmd>BufferLineCycleNext<CR>', opts)

-- NvimTree (replacing NERDTree)
map('n', '<leader>t', '<Cmd>NvimTreeFocus<CR>', opts)
map('n', '<C-t>', '<Cmd>NvimTreeToggle<CR>', opts)
map('n', '<C-n>', '<Cmd>NvimTreeFindFile!<CR>', opts)

-- vimwiki already has its own mappings

-- FZF
map('n', '<leader>p', ':Files<CR>', opts)
map('n', '<leader>F', ':RG<CR>', opts)

-- Async Tasks
map('n', '<F3>', ':AsyncTask project-init<CR>', { silent = true })
map('n', '<F4>', ':AsyncTask project-build<CR>', { silent = true })
map('n', '<F5>', ':AsyncTask project-run<CR>', { silent = true })
map('n', '<F6>', ':AsyncStop<CR>', { silent = true })
map('n', '<F7>', ':call asyncrun#quickfix_toggle(max([8,winheight(0)/5]))<CR>', opts)

-- Tagbar
map('n', '<F8>', ':TagbarToggle<CR>', opts)

---- coc.nvim below
-- coc keybindings
local function coc_pum_visible()
    return vim.fn.exists('*coc#pum#visible') == 1 and vim.fn['coc#pum#visible']() == 1
end

local function check_backspace()
    local col = vim.fn.col('.') - 1
    if col <= 0 then
        return true
    end
    return vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

map('i', '<TAB>', function()
    if coc_pum_visible() then
        return vim.fn['coc#pum#next'](1)
    end

    if check_backspace() then
        return '<Tab>'
    end

    if vim.fn.exists('*coc#refresh') == 1 then
        return vim.fn['coc#refresh']()
    end

    return '<Tab>'
end, { silent = true, expr = true })
map('i', '<S-TAB>', function()
    if coc_pum_visible() then
        return vim.fn['coc#pum#prev'](1)
    end

    return '<C-h>'
end, { expr = true })
map('i', '<CR>', function()
    if coc_pum_visible() and vim.fn.exists('*coc#pum#confirm') == 1 then
        return vim.fn['coc#pum#confirm']()
    end

    return vim.api.nvim_replace_termcodes('<C-g>u\r<c-r>=coc#on_enter()<CR>', true, false, true)
end, { silent = true, expr = true })



-- coc trigger completion
if vim.fn.has('nvim') == 1 then
    map('i', '<c-space>', function()
        if vim.fn.exists('*coc#refresh') == 1 then
            return vim.fn['coc#refresh']()
        end
        return ''
    end, { silent = true, expr = true })
else
    map('i', '<c-2>', function()
        if vim.fn.exists('*coc#refresh') == 1 then
            return vim.fn['coc#refresh']()
        end
        return ''
    end, { silent = true, expr = true })
end

-- coc diagnostic navigation
map('n', '[g', '<Plug>(coc-diagnostic-prev)', { silent = true })
map('n', ']g', '<Plug>(coc-diagnostic-next)', { silent = true })

-- coc code navigation
map('n', 'gd', '<Plug>(coc-definition)', { silent = true })
map('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
map('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
map('n', 'gr', '<Plug>(coc-references)', { silent = true })

-- Show documentation
local function show_documentation()
    if vim.fn.exists('*CocAction') == 1 and vim.fn.CocAction('hasProvider', 'hover') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('K', true, false, true), 'n', false)
    end
end

map('n', 'K', show_documentation, { silent = true })

-- coc Highlight symbol
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        if vim.fn.exists('*CocActionAsync') == 1 then
            pcall(vim.fn.CocActionAsync, 'highlight')
        end
    end,
})

-- coc rename symbol
map('n', '<leader>rn', '<Plug>(coc-rename)', {})

-- coc formatting
map('x', '<leader>f', '<Plug>(coc-format-selected)', {})
map('n', '<leader>f', '<Plug>(coc-format-selected)', {})

-- coc code actions
map('x', '<leader>a', '<Plug>(coc-codeaction-selected)', {})
map('n', '<leader>a', '<Plug>(coc-codeaction-selected)', {})
map('n', '<leader>ac', '<Plug>(coc-codeaction)', {})
map('n', '<leader>qf', '<Plug>(coc-fix-current)', {})
map('n', '<leader>cl', '<Plug>(coc-codelens-action)', {})

-- coc text objects
map('x', 'if', '<Plug>(coc-funcobj-i)', {})
map('o', 'if', '<Plug>(coc-funcobj-i)', {})
map('x', 'af', '<Plug>(coc-funcobj-a)', {})
map('o', 'af', '<Plug>(coc-funcobj-a)', {})
map('x', 'ic', '<Plug>(coc-classobj-i)', {})
map('o', 'ic', '<Plug>(coc-classobj-i)', {})
map('x', 'ac', '<Plug>(coc-classobj-a)', {})
map('o', 'ac', '<Plug>(coc-classobj-a)', {})

-- coc scrolling
if vim.fn.has('nvim-0.4.0') == 1 or vim.fn.has('patch-8.2.0750') == 1 then
    map('n', '<C-f>', [[coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"]],
        { silent = true, nowait = true, expr = true })
    map('n', '<C-b>', [[coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"]],
        { silent = true, nowait = true, expr = true })
    map('i', '<C-f>', [[coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"]],
        { silent = true, nowait = true, expr = true })
    map('i', '<C-b>', [[coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"]],
        { silent = true, nowait = true, expr = true })
    map('v', '<C-f>', [[coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"]],
        { silent = true, nowait = true, expr = true })
    map('v', '<C-b>', [[coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"]],
        { silent = true, nowait = true, expr = true })
end

-- coc selection ranges
map('n', '<C-s>', '<Plug>(coc-range-select)', { silent = true })
map('x', '<C-s>', '<Plug>(coc-range-select)', { silent = true })

-- coc list mappings
map('n', '<space>a', ':<C-u>CocList diagnostics<CR>', { silent = true, nowait = true })
map('n', '<space>e', ':<C-u>CocList extensions<CR>', { silent = true, nowait = true })
map('n', '<space>c', ':<C-u>CocList commands<CR>', { silent = true, nowait = true })
map('n', '<space>o', ':<C-u>CocList outline<CR>', { silent = true, nowait = true })
map('n', '<space>s', ':<C-u>CocList -I symbols<CR>', { silent = true, nowait = true })
map('n', '<space>j', ':<C-u>CocNext<CR>', { silent = true, nowait = true })
map('n', '<space>k', ':<C-u>CocPrev<CR>', { silent = true, nowait = true })
map('n', '<space>p', ':<C-u>CocListResume<CR>', { silent = true, nowait = true })

-- coc multiple cursors
map('n', '<C-c>', '<Plug>(coc-cursors-position)', { silent = true })
map('n', '<C-s>', '<Plug>(coc-cursors-word)', { silent = true })
map('x', '<C-s>', '<Plug>(coc-cursors-range)', { silent = true })
map('n', '<leader>x', '<Plug>(coc-cursors-operator)', {})
