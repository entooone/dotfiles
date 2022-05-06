local wezterm = require 'wezterm';

local default_prog;

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    default_prog = {"cmd.exe", "/c", "%UserProfile%\\scoop\\apps\\git-with-openssh\\current\\bin\\bash.exe", "-i", "-l"}
end

local colors = {
    foreground = "#f8f8f2",
    background = "#252620",
    cursor_fg  = "#252620",
    cursor_bg  = "#a6e22e",
    ansi = {
        "#272822", --black:  
        "#f92672", --red:    
        "#a6e22e", --green:  
        "#f4bf75", --yellow: 
        "#66d9ef", --blue:   
        "#ae81ff", --magenta:
        "#a1efe4", --cyan:   
        "#f8f8f2", --white:  
    },
    brights = {
        "#75715e", --black:  
        "#f92672", --red:    
        "#a6e22e", --green:  
        "#f4bf75", --yellow: 
        "#66d9ef", --blue:   
        "#ae81ff", --magenta:
        "#a1efe4", --cyan:   
        "#f9f8f5", --white:  
    },
}

return {
    use_ime = true,
    font_size = 10.0,
    window_background_opacity = 0.95,
    font = wezterm.font("Cica"),
    colors = colors,
    default_prog = default_prog,
    adjust_window_size_when_changing_font_size = false,
    mouse_bindings = {
        {
            event={Up={streak=1, button="Left"}},
            mods="NONE",
            action=wezterm.action{ExtendSelectionToMouseCursor="Cell"}
        },
        {
            event={Up={streak=2, button="Left"}},
            mods="NONE",
            action="Nop",
        },
        {
            event={Up={streak=1, button="Left"}},
            mods="CTRL",
            action="OpenLinkAtMouseCursor",
        },
    },
    scrollback_lines = 10000,
    -- tab_bar_at_bottom = true,
    canonicalize_pasted_newlines = false,
}
