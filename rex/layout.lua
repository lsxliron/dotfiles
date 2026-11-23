-- move panes around
rex.bind("ctrl+cmd+j", "pane.move", { direction = "down" })
rex.bind("ctrl+cmd+k", "pane.move", { direction = "up" })
rex.bind("ctrl+cmd+h", "pane.move", { direction = "left" })
rex.bind("ctrl+cmd+l", "pane.move", { direction = "right" })

-- Floating panes
rex.bind("ctrl+s>f", "pane.float")
rex.bind("ctrl+s>m", "pane.minimize_floating")
