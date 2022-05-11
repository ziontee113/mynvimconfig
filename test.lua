---we don't talk about Bruno
---
---`the feels` + `boy a know`
---`INVU` + `INVU`
---`the feels` + `boy a know`
---`INVU` + `super simple`
---
---it floods my brain
---@param num number
---@param str string
-- local function theFeels(num, str)
-- 	return tostring(num) .. " " .. str
-- end
--
-- theFeels(200, "we don't talk about Bruno")

-- local table = {}
-- table["/2.3/search/advanced?order=desc&sort=relevance&q=how%20to%20center%20a%20div%20in%20html&site=stackoverflow"] =
-- 	"dalla dalla"
--
-- print(
-- 	table["/2.3/search/advanced?order=desc&sort=relevance&q=how%20to%20center%20a%20div%20in%20html&site=stackoverflow"]
-- )

-----------------------------------------------------

local my_expensive_function = function(x)
	return x * x
end

local meta = setmetatable({}, {
	__call = function(self, val)
		local ret = self[val]
		if ret ~= nil then
			print("cached")
			return ret
		else
			ret = my_expensive_function(val)
			print("not cached")
			self[val] = ret
			return ret
		end
	end,
})

print(meta(3))
print(meta(3))
print(meta(3))

-----------------------------------------------------

local M = {}

M.memo = setmetatable({
	put = function(cache, params, result)
		local node = cache
		for i = 1, #params do
			local param = vim.inspect(params[i])
			node.children = node.children or {}
			node.children[param] = node.children[param] or {}
			node = node.children[param]
		end
		node.result = result
	end,
	get = function(cache, params)
		local node = cache
		for i = 1, #params do
			local param = vim.inspect(params[i])
			node = node.children and node.children[param]
			if not node then
				return nil
			end
		end
		return node.result
	end,
}, {
	__call = function(memo, func)
		local cache = {}

		return function(...)
			local params = { ... }
			local result = memo.get(cache, params)
			if not result then
				result = { func(...) }
				memo.put(cache, params, result)
			end
			return unpack(result)
		end
	end,
})
