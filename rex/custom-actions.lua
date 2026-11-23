-- checks if the current foreground process of the terminal block is a vim or neovim
-- This is useful to prevent clearing the buffer when the user is actively using vim,
-- as it would disrupt their workflow.
local function is_vim(ctx)
	local proc = rex.block.call("com.superlogical.terminal", "process", { block_id = ctx.block_id })
	local fg = proc and proc.foreground
	if not fg then
		return false
	end

	for _, name in ipairs({ fg.name or "", (fg.argv0 or ""):match("[^/]*$") }) do
		if name:match("^n?vim") then
			return true
		end
	end
	return false
end

-- this action clears the terminal buffer by sending a reset command and a form feed character to the terminal block.
-- it repaints the last line (currently active) of the session (`\x0c` is the form feed character)
-- to ensure that the terminal is visually cleared.
rex.action({
	name = "clear_buffer",
	title = "Clear Terminal Buffer",
	run = function(ctx, _args)
		if not is_vim(ctx) then
			rex.block.call("com.superlogical.terminal", "reset", {})
			rex.block.call("com.superlogical.terminal", "write", { data = string.char(12) })
		end
	end,
})

rex.bind("ctrl+s>ctrl+k", "clear_buffer")
