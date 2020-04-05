To embed neovim inside alacritty:

"cmd": "env WINIT_UNIX_BACKEND=x11 WINIT_HIDPI_FACTOR=1.0 alacritty --embed %3 -e nvim -c 'set ft=mail' %1",
