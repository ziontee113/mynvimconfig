local Fighter = {
	name = "",
	health = 0,
	speed = 0,
}

function Fighter:light_punch()
	print("Fighter " .. self.name .. " performs a light punch")
end

function Fighter:heavy_punch()
	print("Fighter " .. self.name .. " performs a heavy punch")
end

function Fighter:light_kick()
	print("Fighter " .. self.name .. " performs a light kick")
end

function Fighter:heavy_kick()
	print("Fighter " .. self.name .. " performs a heavy kick")
end
function Fighter:special_attack()
	print("Fighter " .. self.name .. " performs a Special Attack!!!")
end

function Fighter:new(t)
	t = t or {}
	setmetatable(t, self)
	self.__index = self
	return t
end

local blanka = Fighter:new({ name = "Blanka", health = 100, speed = 60 })
local chun_li = Fighter:new({ name = "Chun Li", health = 100, speed = 60 })
