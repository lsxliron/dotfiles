-- TODO:
-- layout bindings to  be able to add or merge panes

-- comman palette
rex.bind("cmd+p", "client.palette.toggle")

-- floating terminal
rex.bind("ctrl+s>.", "pane.new_floating")

-- Session switcher
rex.bind("ctrl+s>s", "session.switch")
rex.bind("ctrl+s>b", "pane.go_to")

-- Toggle sidebar
rex.bind("ctrl+s>e", "client.sidebar.toggle")

-- Zoom mode
rex.bind("ctrl+s>z", "pane.zoom")

-- Split panes
rex.bind("ctrl+s>shift+'", "pane.split", { direction = "down" })
rex.bind("ctrl+s>shift+5", "pane.split", { direction = "right" })

-- move between panes without prefix
rex.bind("ctrl+j", "pane.focus", { direction = "down" })
rex.bind("ctrl+k", "pane.focus", { direction = "up" })
rex.bind("ctrl+h", "pane.focus", { direction = "left" })
rex.bind("ctrl+l", "pane.focus", { direction = "right" })

require("layout")
require("resize")
require("tabs-and-sessions")
require("rex-navigator")
require("custom-actions")
require("copy-mode")
