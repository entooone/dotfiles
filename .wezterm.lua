local wezterm = require 'wezterm'

local config = {
    colors = {
        foreground = "#f8f8f2",
        background = "#252620",
        cursor_fg  = "#252620",
        cursor_bg  = "#a6e22e",
        ansi = {
            "#272822", --black
            "#f92672", --red
            "#a6e22e", --green
            "#f4bf75", --yellow
            "#66d9ef", --blue
            "#ae81ff", --magenta
            "#a1efe4", --cyan
            "#f8f8f2", --white
        },
        brights = {
            "#75715e", --black
            "#f92672", --red
            "#a6e22e", --green
            "#f4bf75", --yellow
            "#66d9ef", --blue
            "#ae81ff", --magenta
            "#a1efe4", --cyan
            "#f9f8f5", --white
        },
    },
    use_fancy_tab_bar = false,
    initial_cols = 145,
    initial_rows = 55,
    use_ime = true,
    window_frame = {
        font_size = 10.0,
    },
    font_size = 14.0,
    window_background_opacity = 0.95,
    font = wezterm.font("Cica"),
    window_decorations = "NONE|RESIZE",
    adjust_window_size_when_changing_font_size = false,
    scrollback_lines = 100000,
    canonicalize_pasted_newlines = "None",
    debug_key_events = true,
    audible_bell = "Disabled",
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    local run_bash = { "cmd.exe", "/c", "%UserProfile%\\scoop\\apps\\git-with-openssh\\current\\bin\\bash.exe", "-i", "-l" }
    config.launch_menu = {
        { label="Bash",       args=run_bash, },
        { label="CMD",        args={ "cmd.exe" }, },
        { label="PowerShell", args={ "powershell.exe" }, },
    }
    config.default_prog = run_bash;
    config.mouse_bindings = {
        { event={ Up={ streak=1, button="Left" } }, mods="NONE", action=wezterm.action{ExtendSelectionToMouseCursor="Cell"} },
        { event={ Up={ streak=2, button="Left" } }, mods="NONE", action="Nop", },
        { event={ Up={ streak=1, button="Left" } }, mods="CTRL", action="OpenLinkAtMouseCursor", },
    }
    config.keys = {
        { key="\"", mods="CTRL|SHIFT|ALT", action=wezterm.action{ SplitVertical={ domain="CurrentPaneDomain" } } },
        { key="h",  mods="CTRL",           action=wezterm.action{ SendKey={ key="Backspace", } } },
        { key="w",  mods="SHIFT|ALT",      action=wezterm.action.ShowTabNavigator, },
    }
elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
    config.keys = {
        { key="!",  mods="CTRL|SHIFT", action=wezterm.action.ActivateTab(0) },
        { key="\"", mods="CTRL|SHIFT", action=wezterm.action.ActivateTab(1) },
        { key="#",  mods="CTRL|SHIFT", action=wezterm.action.ActivateTab(2) }, 
        { key="$",  mods="CTRL|SHIFT", action=wezterm.action.ActivateTab(3) }, 
        { key="%",  mods="CTRL|SHIFT", action=wezterm.action.ActivateTab(4) }, 
        { key="&",  mods="CTRL|SHIFT", action=wezterm.action.ActivateTab(5) }, 
        { key="'",  mods="CTRL|SHIFT", action=wezterm.action.ActivateTab(6) }, 
        { key="(",  mods="CTRL|SHIFT", action=wezterm.action.ActivateTab(7) }, 
        { key=")",  mods="CTRL|SHIFT", action=wezterm.action.ActivateTab(8) }, 
    }
end

return config
