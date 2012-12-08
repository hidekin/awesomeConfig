-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
   -- { rule = { class = "MPlayer" },
    --  properties = { floating = true } },
   



    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    { rule = { class = "Firefox" },
       properties = { tag = tags[1][3] } },
    { rule = { class = "Terminator" },
       properties = { tag = tags[1][4] } },	
	{ rule = { class = "Smplayer" },
       properties = { tag = tags[2][1] } },
	{ rule = { class = "MPlayer" },
       properties = { tag = tags[2][1] },floating = true },
   { rule = { class = "Vlc" },
       properties = { tag = tags[2][1] } },

   { rule = { class = "Audacious" },
       properties = { tag = tags[2][2] } },
   { rule = { class = "Netbeans" },
       properties = { tag = tags[2][3] } },
	{ rule = { class = "Eclipse" },
       properties = { tag = tags[2][3] } },
{ rule = { class = "Pidgin" },
       properties = { tag = tags[1][3] } },
{ rule = { class = "Gvim" },
       properties = { tag = tags[1][2] } },
{ rule = { class = "Xchat" },
       properties = { tag = tags[1][3] } },
{ rule = { class = "Chromium" },
       properties = { tag = tags[1][3] } },
{ rule = { class = "Leafpad" },
       properties = { tag = tags[1][7] } },
{ rule = { class = "Pcmanfm" },
       properties = { tag = tags[1][1] } },
{ rule = { class = "libreoffice --writer" },
       properties = { tag = tags[2][4] } },
{ rule = { class = "libreoffice --base" },
       properties = { tag = tags[2][4] } },
{ rule = { class = "libreoffice --impress" },
       properties = { tag = tags[2][4] } },
{ rule = { class = "libreoffice --writer" },
       properties = { tag = tags[2][4] } },
{ rule = { class = "libreoffice --calc" },
       properties = { tag = tags[2][4] } },
{ rule = { class = "XMind" },
       properties = { tag = tags[2][4] } },
{ rule = { class = "Dia" },
       properties = { tag = tags[2][4] } },



}
-- }}}