rex.mode("copy", { exclusive = true })
rex.bind("ctrl+v", "client.mode.enter", { name = "copy" })
rex.bind("ctrl+s>v", "pane.copy_mode.enter")

rex.action({
	name = "copy_and_exit",
	title = "Copy and Exit",
	run = function(_ctx, _args)
		rex.client.queue("pane.copy")
		rex.client.queue("pane.copy_mode.exit")
	end,
})

rex.bind("copy/y", "copy_and_exit")
rex.bind("copy/enter", "copy_and_exit")
rex.bind("copy/escape", "pane.copy_mode.exit")
