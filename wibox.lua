local 

mystatusbar = awful.wibox({ position = "bottom", screen = 1, ontop = false, width = 
1, height = 10 })





-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                       awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)


--Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
 
        s == 1 and mysystray or nil,
  kbdcfg,
        mytextclock,
  batinfo,  
  

  
  
        mytasklist[s],
  
        layout = awful.widget.layout.horizontal.rightleft
    }




       
end
-- }}}


--wibox bottom 
mytextbox1=widget({type="textbox"})
mytextbox1.text = "CPU"
mytextbox2=widget({type="textbox"})
mytextbox2.text="Memory"
mytextbox3=widget({type="textbox"})
mytextbox3.text = "   "
mytextbox4=widget({type="textbox"})
mytextbox4.text = " "


                -- Network widget
netwidget = awful.widget.graph()
netwidget:set_width(50)
netwidget:set_height(30)
netwidget:set_background_color("#494B4F")
netwidget:set_color("#FF5656")
netwidget:set_gradient_colors({ "#FF5656", "#88A175", "#AECF96" })

netwidget_t = awful.tooltip({ objects = { netwidget.widget },})

-- Register network widget
vicious.register(netwidget, vicious.widgets.net,
                    function (widget, args)
                        netwidget_t:set_text("Network download: " .. args["{eth0 down_mb}"] .. "mb/s")
                        return args["{eth0 down_mb}"]
                    end)


-- Pacman Widget
pacwidget = widget({type = "textbox"})

pacwidget_t = awful.tooltip({ objects = { pacwidget},})

vicious.register(pacwidget, vicious.widgets.pkg,
                function(widget,args)
                    local io = { popen = io.popen }
                    local s = io.popen("pacman -Qu")
                    local str = ''

                    for line in s:lines() do
                        str = str .. line .. "\n"
                    end
                    pacwidget_t:set_text(str)
                    s:close()
                    return "UPDATES: " .. args[1]
                end, 1800, "Arch")

                --'1800' means check every 30 minutes

-- Initialize widget
memgettext = widget({ type = "textbox" })
-- Register widget
vicious.register(memgettext, vicious.widgets.mem, "$1% ($2MB/$3MB)",13)

-- Initialize widget
datewidget = widget({ type = "textbox" })
-- Register widget
vicious.register(datewidget, vicious.widgets.date, "%b %d, %R", 60)

-- Initialize widget
memwidget = widget({ type = "textbox" })
-- Register widget
vicious.register(memwidget, vicious.widgets.mem, "$1% ($2MB/$3MB)", 13)

-- Initialize widget
memwidget = awful.widget.progressbar()
-- Progressbar properties
memwidget:set_width(100)
--memwidget:set_height(10)
memwidget:set_vertical(true)
memwidget:set_background_color("#494B4F")
memwidget:set_border_color(nil)
memwidget:set_color("#AECF96")
memwidget:set_gradient_colors({ "#AECF96", "#88A175", "#FF5656" })
-- Register widget
vicious.register(memwidget, vicious.widgets.mem, "$1", 13)

-- Initialize widget
cpuwidgettext = widget({ type = "textbox" })
-- Register widget
vicious.register(cpuwidgettext, vicious.widgets.cpu, "$1%")


-- Initialize widget
cpuwidget = awful.widget.graph()
-- Graph properties
cpuwidget:set_width(100)
cpuwidget:set_background_color("#494B4F")
cpuwidget:set_color("#FF5656")
cpuwidget:set_gradient_colors({ "#FF5656", "#88A175", "#AECF96" })
-- Register widget
vicious.register(cpuwidget, vicious.widgets.cpu, "$1")



local 


-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                       awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)


--Create the wibox
    mywibox[s] = awful.wibox({ position = "bottom", height="25", screen = s })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
          mytextbox3,
          mytextbox1,
          mytextbox3,
          mytextbox4,
          cpuwidget,
          mytextbox3,
          cpuwidgettext,
          mytextbox3,
          mytextbox2,
          mytextbox4,
          mytextbox3,
          memwidget,
          mytextbox3,
           memgettext,
           mytextbox3,
           pacwidget,
           mytextbox3,
           pacwidget_t,
           
           
           
          

          
            layout = awful.widget.layout.horizontal.leftright
        },
    --    mylayoutbox[s],

      --  s == 1 and mysystray or nil,
  --        mytextclock,
  --        mytasklist[s],
  
        layout = awful.widget.layout.horizontal.rightleft
    }




       
end
-- }}}
