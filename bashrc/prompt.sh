#!/bin/bash

# prompt.sh 

# --- Настройка кастомных ярких цветов ---
# В bash мы используем ANSI escape-коды.
# Формат для 256 цветов: \[\e[38;5;{CODE}m\]
# Важно оборачивать цветовые коды в \[ и \], чтобы bash
# правильно рассчитывал длину строки и не было проблем с редактированием.

red_bright='\[\e[38;5;9m\]'
green_bright='\[\e[38;5;10m\]'
yellow_bright='\[\e[38;5;11m\]'
blue_bright='\[\e[38;5;14m\]'
color_reset='\[\e[0m\]' # Сброс всех атрибутов цвета

# --- Настройка строки приглашения (PS1) ---
# Используем переменные с ANSI-кодами.
# \u - имя пользователя (аналог %n в zsh)
# \h - имя хоста до первой точки (аналог %m в zsh)
# \w - текущий путь, с тильдой для дома (аналог %~ в zsh)
# \$ - символ '#' для root и '$' для обычного пользователя (аналог %# в zsh)
# \n - перенос строки

PS1="\n\n"
PS1+="${red_bright}╭─["
PS1+="${green_bright}\u"
PS1+="${yellow_bright}@"
PS1+="${blue_bright}\h"
PS1+="${red_bright}]-["
PS1+="${green_bright}\w"
PS1+="${red_bright}]\n"
PS1+="${red_bright}╰─╼ " 
PS1+="${yellow_bright}\$ "
PS1+="${color_reset}"

# Очищаем переменные, чтобы они не "засоряли" сессию
unset red_bright green_bright yellow_bright blue_bright color_reset
