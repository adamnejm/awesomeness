# Awesome/Ness
Completely redesigned configuration workflow for [AwesomeWM](https://github.com/awesomeWM/awesome/)  

&nbsp;  

## Project discontinued!
Most of it's features are still included in my personal configuration  
You can check it out here: [adamnejm/dotfiles/awesome/](https://github.com/adamnejm/dotfiles/tree/master/.config/awesome)

&nbsp;  
&nbsp;  

## Features
  
- **Flow system**  
	Use other configurations as a base for your own one by using the fallback system or directly borrowing files  
	
- **Non-intrusive libraries**  
	Included libraries will run when you tell them to run, no behind the scenes bullshit, you're always in control  
	
- **Stock configuration**  
	Comes with default configuration which is meant to imitate the stock AwesomeWM experience  
	
- **Simplified runtime configuration**  
	Forget clutter of default Awesome's `rc.lua` and stay in control of your system  
	
- **Static configuration**  
	Just tweak a value in your `config.lua` and you're done!  

&nbsp;  

## Examples

### Key and button binds
Awesome's default keys and buttons are hard to read and manage, but guess what...

<sub>[client_keys.lua](https://github.com/adamnejm/awesomeness/blob/master/ness/flow/default/bind/client_keys.lua):</sub>
```lua
bind.clientKeys {
  {
    combo	= "Mod + F",
    desc	= "Fullscreen",
    press	= function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end
  },{
    combo	= "Mod + Shift + C",
    desc	= "Kill",
    press	= function(c)
      c:kill()
    end
  }
}
```

### Screens, tags and clients
With the combination of static configuration, `tagger` and `agent` libraries you can easily configure screens, create tags, set wallpapers and manage where clients spawn

<sub>[config.lua](https://github.com/adamnejm/awesomeness/blob/master/ness/flow/default/config.lua):</sub>
```lua
["HDMI"] = {
  wallpaper = "background.png",
  tag_filter = awful.widget.taglist.filter.all,
  tag_count = 9,
  tags = {
    [3] = {
      name = "Browsers",
      spawn = { "Firefox", "Thunar" }
    }
  }
}
```

<sub>[rc.lua](https://github.com/adamnejm/awesomeness/blob/master/ness/flow/default/rc.lua):</sub>
```lua
awful.screen.connect_for_each_screen(function(scr)
  tagger.setupScreenConfig(scr)
  tagger.setWallpaper(scr)
  tagger.createTags(scr)
end)

client.connect_signal("manage", function(c)
  agent.manageSpawnTag(c)
end)
```



