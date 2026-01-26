





-- Создаем кастомные цвета для иконок в nvim-tree
vim.api.nvim_set_hl(0, 'NvimTreeFolderIcon', {fg='#ABB2C0'})	-- Цвет для иконок папок
vim.api.nvim_set_hl(0, 'NvimTreeIcon', {fg='#ABB2C0'})			-- Цвет для иконок файлов
vim.api.nvim_set_hl(0, 'NvimTreeFolderName', {fg='#CBCBCB'})	-- Цвет для имени папок
vim.api.nvim_set_hl(0, 'NvimTreeFileName', {fg='#CBCBCB'})		-- Цвет для имени файлов






vim.opt.number = true				-- Показывает номер текущей строки
vim.opt.relativenumber = true		-- Включает относительную нумерацию для остальных

vim.opt.cursorline = true			-- Подсветка текущей строки

vim.g.mapleader = ' '				-- Устанавливаем пробел как клавишу-лидера
vim.g.maplocalleader = ' '			-- Устанавливаем пробел как клавишу-лидера

vim.opt.clipboard = 'unnamedplus'	-- Использовать по умолчанию буфер обмена ОС

vim.opt.tabstop = 4         		-- Отображать 1 таб как 4 пробела
vim.opt.shiftwidth = 4      		-- Автоматический отступ в 1 таб
vim.opt.expandtab = false   		-- Вставлять реальный таб

vim.opt.foldmethod = "indent"		-- Настройка автоматического сворачивания блоков кода
vim.opt.foldlevel = 99 				-- При открытии файла всё развернуто





vim.keymap.set({'n','v'}, '<leader>d', '"_d', { desc='Удаление без копирования в буфер' })	
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Открыть/закрыть файловый менеджер' })
vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>', { desc = 'Следующий буфер' })
vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', { desc = 'Предыдущий буфер' })
vim.keymap.set('n', '<leader>c', ':bdelete<CR>', { desc = 'Закрыть текущий буфер' })
vim.keymap.set('n', '<leader>t', ':ToggleTerm<CR>', { desc = 'Открыть/закрыть терминал' })
vim.keymap.set('n', '<C-Left>', '<C-w><', { desc = 'Уменьшить ширину окна' })
vim.keymap.set('n', '<C-Right>', '<C-w>>', { desc = 'Увеличить ширину окна' })
-- ===== Установка lazy.nvim (менеджер плагинов) =====

-- Задание пути для установки lazy (должно получится ~/.local/share/nvim/lazy/lazy.nvim)
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
-- Если файла lazy не существует - скачать lazy с гитхаба в указанный путь
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
  	})
end
-- Регистрация lazy в nvim
vim.opt.rtp:prepend(lazypath)
-- Запуск lazy
require('lazy').setup({
	 
	-- Табы открытых файлов 
	{'akinsho/bufferline.nvim', config=true},

	-- Настройки файлового менеджера
	{
    	'nvim-tree/nvim-tree.lua',
    	config = function()
      		require('nvim-tree').setup({
				
				-- Включение какиех-то настроек
				update_cwd = true,				-- Автоматически менять рабочую директорию при ее смене через :cd

				-- Настройки отображения
				renderer = {
    				root_folder_modifier = ':t', -- Оставить только имя текущей папки 
					-- Настройки иконок
					icons = {
						glyphs = {
							-- Одна иконка для всех файлов
							default = '', -- Иконки для папок (закрытая и открытая)
							folder = {default='', open='',},
						},
					},
  				},
			})
    	end
  	},
	
	-- 1. Настройка самого плагина ToggleTerm
	-- 1. Настройка самого плагина ToggleTerm
	{
  		'akinsho/toggleterm.nvim',
  		version = "*",
  		config = function()
    		require('toggleterm').setup({
      			direction = 'vertical',
      			size = function(term)
        		if term.direction == "vertical" then
          			return vim.o.columns * 0.5
        		end
        			return 10
      			end,
      			start_in_insert = true,
      			shell = vim.o.shell,
    		})

    		-- 2. Создаем функцию для установки локальных хоткеев терминала
    		function _G.set_terminal_keymaps()
      			-- Создаем локальные для буфера терминала маппинги
      			vim.keymap.set('t', '<esc><esc>', [[<C-\><C-n>]], {
        			desc = 'Выйти из режима терминала',
        			buffer = 0
      			})
      			-- ВОТ РЕШЕНИЕ ВАШЕЙ ПРОБЛЕМЫ:
      			-- Этот хоткей будет работать ТОЛЬКО в режиме терминала
      			vim.keymap.set('t', '<leader>t', [[<cmd>ToggleTerm<CR>]], {
        			desc = 'Закрыть терминал',
        			buffer = 0
      			})
    		end

    		-- 3. Запускаем нашу функцию КАЖДЫЙ РАЗ при открытии терминала
    		vim.api.nvim_create_autocmd('TermOpen', {
      			pattern = 'term://*',
      			callback = function()
        			set_terminal_keymaps()
      			end,
    		})
  		end,
	},
}) 



