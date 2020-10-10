**Awesome/Ness** is a redesigned configuration workflow for [Awesome](https://github.com/awesomeWM/awesome/)  

&nbsp;  

## Features
  
- **Flow system**  
	Use other configurations as a base for your own one by using the fallback system or directly borrowing files  
	
- **Non-intrusive libraries**  
	Included libraries will run when you tell them to run, no behind the scenes bullshit, you're always in control  
	
- **Stock configuration**  
	Comes with default configuration which is meant to imitate the stock AwesomeWM experience
	
- **Static configuration**  
	Make quick tweaks never have been easier, just change the value and Awesome/Ness will take care of the rest

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
With the combination of static configuration, `tagger` and `agent` libraries you can easily configure screens, tags and manage clients

<sub>[config.lua](https://github.com/adamnejm/awesomeness/blob/master/ness/flow/default/config.lua):</sub>
```lua
["HDMI"] = {
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
	tagger.createTags(scr)
end)

client.connect_signal("manage", function(c)
  agent.manageSpawnTag(c)
end)
```



