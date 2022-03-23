-- Imports
local ls = require("luasnip")
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local function lp(package_name) -- lp -> stands for Load Package
	package.loaded[package_name] = nil
	return require(package_name)
end --> TODO: turn this function into a snippet (for easier autocomplete)

local same = function(index)
	return f(function(arg)
		return arg[1]
	end, { index })
end

local snippets = {
	s("req", fmt("require {} = require('{}')", { i(1, "default"), rep(1) })),
	s("black", { t("black "), i(1, "mamba") }),
	s("test", { t(lp("snippets.all.savage")) }),
	s("t", { t("-- " .. lp("snippets.all.super").name) }),
	s("c", fmt("hey this is cool: {}", { c(1, { t("option →"), t("◙") }) })),
	s(
		"curtime",
		f(function()
			return "-- Current Time is: " .. os.date("%D - %H:%M")
		end)
	),
	s("st", fmt([[-- example: {}, function: {}]], { i(1), same(1) })),
	s( --> look at this shit man!
		{ trig = "b(%d)", regTrig = true, hidden = true },
		f(function(_, snip)
			return "Captured Text: " .. snip.captures[1] .. "."
		end, {})
	),
	s(
		"fmt1",
		fmt("To {title} {} {}.", {
			i(2, "Name"),
			i(3, "Surname"),
			title = c(1, { t("Mr."), t("Ms.") }),
		})
	),
	s(
		"fmt2",
		fmt("To {title} {}.", {
			title = c(1, { t("Mr."), t("Ms."), t("Mrs.") }),
			rep(1),
		})
	),
	s("muit", { i(1, { "smile", "away" }) }), --> multi line insert placeholder

	-- function_node demonstration
	s("trig1", {
		i(1),
		f(function(args, snip, user_arg_1, user_arg_2)
			return args[1][1] .. user_arg_2
		end, { 1 }, { user_args = { "Will be appended to text from i(0)", " user_arg2" } }),
		i(0),
	}),

	s(
		"trig2",
		sn(1, { --> snippet node example
			t("basically just text "),
			i(1, "And an insertNode."),
		})
	),

	-- dynamic node example
	s("trig3", {
		t("text: "),
		i(1),
		t({ "", "copy: " }),
		d(2, function(args)
			-- the returned snippetNode doesn't need a position; it's inserted
			-- "inside" the dynamicNode.
			return sn(nil, {
				-- jump-indices are local to each snippetNode, so restart at 1.
				i(1, args[1]),
			})
		end, { 1 }),
	}),
}

local for_loop_snippet = s( --> javascript simple for loop
	{ trig = "fori", regTrig = true, hidden = true },

	fmt(
		[[
		  for ({i} = 0; {} < {loop_to}; {}++) {{
      {}
		  }}
    ]],
		{
			i = i(1, "i"),
			rep(1),
			loop_to = i(2, "10"),
			rep(1),
			i(3, "// TODO something"),
		}
	)
)
table.insert(snippets, for_loop_snippet)

--
--
--
--
-- Notes goes here

-- We want the snippet to get the information from our trigger
-- process that info, then do something like splitting the trigger capture group

-- Helper functions goes here

local wait_a_minute = function(index, contents, old_node)
	if old_node == nil then
		return i(index, contents)
	else
		return old_node
	end
end

local function lunatic(table, index, old_node)
	local base_number = 1
	if index > 1 then
		base_number = 2
	end
	return sn(index, {
		t("for ("),
		i(base_number, table[index]),
		t(" = 1; "),
		rep(base_number),
		t(" < "),
		i(base_number + 1, "10"),
		t("; "),
		rep(base_number),
		t({ "++ ) {", "\t" }),
		wait_a_minute(base_number + 2, "", old_node),
		t({ "", "}" }),
	})
end

local function fighting_dreamers(table, index, old_node)
	return d(1, function()
		if old_node == nil then
			return lunatic(table, index)
		else
			return lunatic(table, index, old_node)
		end
	end, {--[[argnodes]]
	})
end

local function recursiveFunc(table, index, old_node)
	if old_node == nil then
		old_node = fighting_dreamers(table, index)
	else
		if index <= #table then
			old_node = fighting_dreamers(table, index, old_node)
		end
	end

	if index > #table then
		return old_node
	else
		index = index + 1
		return recursiveFunc(table, index, old_node)
	end --
end

local dynamic_for_loop_V2 = s( -- dynamic for loop V2
	{ trig = "f(%w+)xx", regTrig = true, hidden = true },
	{
		d(1, function(_, snip)
			local split_result = vim.split(snip.captures[1], "", true)
			return sn(1, recursiveFunc(split_result, 1))
		end),
	}
)
table.insert(snippets, dynamic_for_loop_V2)
--
--
--
--

-- NOTE: our dynamic for loop V3 goes here

local forLoopRecursive = function(table, index, lastNode)
	return sn(
		1,
		fmt(
			[[
for ({} = 0; {} < {}, {}++ {{
  {}
}}
        ]],
			{
				i(1, table[1]),
				rep(1),
				i(2, "10"),
				rep(1),
				i(3, "// "),
			}
		)
	)
end

local dynamic_for_loop_V3 = s( --  TODO: dynamic for loop V3
	{ trig = "f(%w+)", regTrig = true, hidden = true },
	{
		d(1, function(_, snip)
			local args_table = vim.split(snip.captures[1], "", true)
			return sn(1, forLoopRecursive(args_table, 1))
		end),
	}
)
table.insert(snippets, dynamic_for_loop_V3)

--
--
--
--
local dynamic_for_loop_V1 = s(
	{ trig = "f(%w+)x", regTrig = true, hidden = true },
	fmt(
		[[
		  for ({i} = 0; {} < {loop_to}; {}++) {{
      {}
		  }}
    ]],
		{
			i = d(1, function(_, snip)
				return sn(nil, i(1, { snip.captures[1] }))
			end),
			rep(1),
			loop_to = i(2, "10"),
			rep(1),
			i(3, "// TODO something"),
		}
	)
)
table.insert(snippets, dynamic_for_loop_V1)

return snippets
