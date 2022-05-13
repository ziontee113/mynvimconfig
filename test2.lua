local str = [[
Some Text Up here

  begin
    super simple
    string
  end

Some Text Down here

  begin
    super simple
    string
  end
____
]]

print(str)

local pattern = "^%s.*%s"

for line in str:gmatch("[^\n]+") do
	if line:match(pattern) then
		print("matched" .. line)
	else
		-- print("not matched")
	end
end
