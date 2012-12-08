-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ "1⇋ Main", "2⇋ Admin.", "3⇋ www/Web", "4⇋ Terminal", "5⇋ Video","6⇋ Audio","7⇋ Development","8⇋ Office"}, s, 
layouts[1])
end
-- }}}