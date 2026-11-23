-- Tabs management
rex.bind("ctrl+s>c", "client.tab.new")
rex.bind("ctrl+s>x", "client.tab.close")

-- move between tabs
rex.bind("ctrl+s>n", "client.tab.next")
rex.bind("ctrl+s>p", "client.tab.previous")

-- Assign indexes to tabs 1-9
for i = 1, 9 do
	rex.bind("ctrl+s>" .. i, "client.tab.goto", { index = i })
end

rex.bind("ctrl+s>t", "client.tab.rename")

-- Session management
rex.bind("ctrl+s>o", "session.rename")
rex.bind("ctrl+s>shift+x", "session.close")
