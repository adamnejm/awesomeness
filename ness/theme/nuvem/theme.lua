
local gears			= require("gears")
local flower		= require("ness/lib/flower")
local xresources	= require("beautiful.xresources")
local theme_assets	= require("beautiful.theme_assets")

local dpi = xresources.apply_dpi


local default_theme_dir  = flower.getThemeDir("default")
local theme_dir = flower.getExecThemeDir()

-------------------------------------------

local theme = {}



-------------------------------------------
-- GENERAL
-------------------------------------------

theme.font			= "Hack 8"

theme.fg_normal		= "#AAAAAA"
theme.bg_normal		= "#1d003d"

theme.fg_focus		= "#FFFFFF"
theme.bg_focus		= "#7d24ad"

theme.fg_urgent		= "#FFFFFF"
theme.bg_urgent		= "#c90c74"

theme.fg_minimize	= "#AAAAAA"
theme.bg_minimize	= "#1d003d"



-------------------------------------------
-- BORDER
-------------------------------------------

theme.useless_gap	= dpi(3)
theme.border_width	= dpi(1)
theme.border_normal	= "#000000"
theme.border_focus	= "#7d24ad"
theme.border_marked	= "#91231C"



-------------------------------------------
-- MENU
-------------------------------------------

theme.menu_width	= dpi(500)
theme.menu_height	= dpi(18)

theme.menu_submenu_icon = default_theme_dir.."submenu.png"



-------------------------------------------
-- SYSTRAY
-------------------------------------------

-- theme.bg_systray	= theme.bg_normal



-------------------------------------------
-- TITLEBAR
-------------------------------------------

theme.titlebar_close_button_normal				= default_theme_dir.."titlebar/close_normal.png"
theme.titlebar_close_button_focus				= default_theme_dir.."titlebar/close_focus.png"

theme.titlebar_minimize_button_normal			= default_theme_dir.."titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus			= default_theme_dir.."titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive		= default_theme_dir.."titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive		= default_theme_dir.."titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active		= default_theme_dir.."titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active		= default_theme_dir.."titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive	= default_theme_dir.."titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive		= default_theme_dir.."titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active		= default_theme_dir.."titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active		= default_theme_dir.."titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive	= default_theme_dir.."titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive	= default_theme_dir.."titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active	= default_theme_dir.."titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active		= default_theme_dir.."titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive	= default_theme_dir.."titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive	= default_theme_dir.."titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active	= default_theme_dir.."titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active	= default_theme_dir.."titlebar/maximized_focus_active.png"



-------------------------------------------
-- LAYOUT
-------------------------------------------

theme.layout_fairh		= default_theme_dir.."layouts/fairhw.png"
theme.layout_fairv		= default_theme_dir.."layouts/fairvw.png"
theme.layout_floating	= default_theme_dir.."layouts/floatingw.png"
theme.layout_magnifier	= default_theme_dir.."layouts/magnifierw.png"
theme.layout_max		= default_theme_dir.."layouts/maxw.png"
theme.layout_fullscreen	= default_theme_dir.."layouts/fullscreenw.png"
theme.layout_tilebottom	= default_theme_dir.."layouts/tilebottomw.png"
theme.layout_tileleft	= default_theme_dir.."layouts/tileleftw.png"
theme.layout_tile		= default_theme_dir.."layouts/tilew.png"
theme.layout_tiletop	= default_theme_dir.."layouts/tiletopw.png"
theme.layout_spiral		= default_theme_dir.."layouts/spiralw.png"
theme.layout_dwindle	= default_theme_dir.."layouts/dwindlew.png"
theme.layout_cornernw	= default_theme_dir.."layouts/cornernww.png"
theme.layout_cornerne	= default_theme_dir.."layouts/cornernew.png"
theme.layout_cornersw	= default_theme_dir.."layouts/cornersww.png"
theme.layout_cornerse	= default_theme_dir.."layouts/cornersew.png"



-------------------------------------------
-- ICON
-------------------------------------------

theme.icon_theme = nil



-------------------------------------------

return theme
