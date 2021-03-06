P = function(v)
	print(vim.inspect(v))
	return v
end
I = function(v)
	return vim.inspect(v)
end

RELOAD = function(...)
	return require("plenary.reload").reload_module(...)
end

R = function(name)
	RELOAD(name)
	return require(name)
end

N = function(message, level, title)
	vim.notify(vim.inspect(message), level or "info", { title = title })
end
