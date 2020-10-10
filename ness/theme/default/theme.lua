
-- Default Awesome theme

local flower		= require("ness/lib/flower")
local xresources	= require("beautiful.xresources")
local theme_assets	= require("beautiful.theme_assets")

local dpi = xresources.apply_dpi

-- Flower library is capable of automatically determining this theme's directory
local theme_dir = flower.getExecThemeDir()

-------------------------------------------

local theme = {}



-------------------------------------------
-- GENERAL
-------------------------------------------

theme.font			= "sans 8"

theme.fg_normal		= "#AAAAAA"
theme.bg_normal		= "#222222"

theme.fg_focus		= "#FFFFFF"
theme.bg_focus		= "#535D6C"

theme.fg_urgent		= "#FFFFFF"
theme.bg_urgent		= "#FF0000"

theme.fg_minimize	= "#FFFFFF"
theme.bg_minimize	= "#444444"



-------------------------------------------
-- BORDER
-------------------------------------------

theme.useless_gap	= dpi(0)
theme.border_width	= dpi(1)
theme.border_normal	= "#000000"
theme.border_focus	= "#535D6C"
theme.border_marked	= "#91231C"



-------------------------------------------
-- MENU
-------------------------------------------

theme.menu_width	= dpi(100)
theme.menu_height	= dpi(15)

theme.menu_submenu_icon = theme_dir.."submenu.png"



-------------------------------------------
-- SYSTRAY
-------------------------------------------

-- theme.bg_systray	= theme.bg_normal



-------------------------------------------
-- TITLEBAR
-------------------------------------------

theme.titlebar_close_button_normal				= theme_dir.."titlebar/close_normal.png"
theme.titlebar_close_button_focus				= theme_dir.."titlebar/close_focus.png"

theme.titlebar_minimize_button_normal			= theme_dir.."titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus			= theme_dir.."titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive		= theme_dir.."titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive		= theme_dir.."titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active		= theme_dir.."titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active		= theme_dir.."titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive	= theme_dir.."titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive		= theme_dir.."titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active		= theme_dir.."titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active		= theme_dir.."titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive	= theme_dir.."titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive	= theme_dir.."titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active	= theme_dir.."titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active		= theme_dir.."titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive	= theme_dir.."titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive	= theme_dir.."titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active	= theme_dir.."titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active	= theme_dir.."titlebar/maximized_focus_active.png"



-------------------------------------------
-- LAYOUT
-------------------------------------------

theme.layout_fairh		= theme_dir.."layouts/fairhw.png"
theme.layout_fairv		= theme_dir.."layouts/fairvw.png"
theme.layout_floating	= theme_dir.."layouts/floatingw.png"
theme.layout_magnifier	= theme_dir.."layouts/magnifierw.png"
theme.layout_max		= theme_dir.."layouts/maxw.png"
theme.layout_fullscreen	= theme_dir.."layouts/fullscreenw.png"
theme.layout_tilebottom	= theme_dir.."layouts/tilebottomw.png"
theme.layout_tileleft	= theme_dir.."layouts/tileleftw.png"
theme.layout_tile		= theme_dir.."layouts/tilew.png"
theme.layout_tiletop	= theme_dir.."layouts/tiletopw.png"
theme.layout_spiral		= theme_dir.."layouts/spiralw.png"
theme.layout_dwindle	= theme_dir.."layouts/dwindlew.png"
theme.layout_cornernw	= theme_dir.."layouts/cornernww.png"
theme.layout_cornerne	= theme_dir.."layouts/cornernew.png"
theme.layout_cornersw	= theme_dir.."layouts/cornersww.png"
theme.layout_cornerse	= theme_dir.."layouts/cornersew.png"



-------------------------------------------
-- TAGLIST
-------------------------------------------

local taglist_square_size	= dpi(4)
theme.taglist_squares_sel	= theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel	= theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)



-------------------------------------------
-- AWESOME
-------------------------------------------

theme.awesome_icon = theme_assets.awesome_icon(theme.menu_height, theme.bg_focus, theme.fg_focus)



-------------------------------------------
-- ICON
-------------------------------------------

-- Application icons, if not set then following will be used:
-- `/usr/share/icons` and `/usr/share/icons/hicolor`
theme.icon_theme = nil



-------------------------------------------
-- DEPRECATED
-------------------------------------------

-- Wallpapers are handled by Flow's configuration which allows more flexibility
-- theme.wallpaper = theme_dir.."background.png"



-------------------------------------------

return theme
