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
