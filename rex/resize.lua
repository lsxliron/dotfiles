rex.mode("resize", { exclusive = true })
rex.bind("ctrl+s>r", "client.mode.enter", { name = "resize" })

rex.bind("resize/h", "pane.resize", { direction = "left" })
rex.bind("resize/l", "pane.resize", { direction = "right" })
rex.bind("resize/k", "pane.resize", { direction = "up" })
rex.bind("resize/j", "pane.resize", { direction = "down" })

rex.bind("resize/enter", "client.mode.exit")
rex.bind("resize/escape", "client.mode.exit")
rex.bind("resize/q", "client.mode.exit")
