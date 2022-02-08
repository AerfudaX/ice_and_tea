-- Thx to sangeet79 and 0siribix for helping at rechecking codes

local modname = "ice_and_tea"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")
local S = minetest.get_translator(minetest.get_current_modname())

-- Tea Bushes

local function grow_new_tea(pos)
if not default.can_grow(pos) then

		minetest.get_node_timer(pos):start(math.random(240,600))
		return
	end
	minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x-1, y = pos.y, z = pos.z-1}, modpath.."/schematics/tea.mts", "0", nil, false)
end

minetest.register_decoration({
	name = "ice_and_tea:green_tea_bush",
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.001,
		scale = 0.002,
		spread = {x = 250, y = 250, z = 250},
		seed = 3462,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"deciduous_forest"},
	y_min = 1,
	y_max = 20,
	schematic = modpath.."/schematics/tea.mts",
	flags = "place_center_x, place_center_z, force_placement",
	rotation = "random",
})

minetest.register_node("ice_and_tea:tea_sapling", {
    description = S("Tea Sapling"),
    drawtype = "plantlike",
    tiles = {"TeaGreenSapling.png"},
    inventory_image = "TeaGreenSapling.png",
    wield_image = "TeaGreenSapling.png",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    on_timer = grow_new_tea,
	selection_box = {
	   type = "fixed",
	   fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
       	attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(2400,4800))
	end,
	
	on_place = function(itemstack, placer, pointed_thing)
		itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
			"ice_and_tea:tea_sapling",
			{x = -1, y = 1, z = -1},
			{x = 1, y = 0, z = 1},
			4)

		return itemstack
	end,
})

minetest.register_node("ice_and_tea:greentea_bush", {
    description = S("Green Tea Bush"),
	tiles = {"TeaGreenBushBlock.png"},
	paramtype2 = "facedir",
	place_param2 = 0,
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 3},
	drawtype = "glasslike",
	is_ground_content = false,
    sunlight_propagates = true,
	drop = {
		max_items = 1,
		items = {
			{items = {"ice_and_tea:tea_sapling"}, rarity = 20},
			{items = {"ice_and_tea:matchaleaves 2"}},
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})

minetest.register_craftitem("ice_and_tea:crushedmatcha", {
    description = S("crushed Matcha"),
	inventory_image = "CrushedgreenTea.png",
})

minetest.register_craftitem("ice_and_tea:matchaleaves", {
    description = S("Green Tea Leaves"),
	inventory_image = "GreenTealeaves.png",
})

minetest.register_craft({
    type = "shapeless",
	output = "ice_and_tea:crushedmatcha",
	recipe = {
	    "farming:mortar_pestle",
		"ice_and_tea:matchaleaves",
		"ice_and_tea:matchaleaves",
		"ice_and_tea:matchaleaves",
		"ice_and_tea:matchaleaves",
	},
	replacements = {{"farming:mortar_pestle", "farming:mortar_pestle"}},
})

minetest.register_craftitem("ice_and_tea:green_tea", {
    description = S("Matcha Tea"),
	inventory_image = "GreenTeaCup.png",
	on_use = minetest.item_eat(4, "vessels:drinking_glass"),
})

minetest.register_craft({
    type = "shapeless",
	output = "ice_and_tea:green_tea",
	recipe = {
	    "vessels:drinking_glass",
		"ice_and_tea:crushedmatcha",
		"bucket:bucket_river_water"
	},
	replacements = {{"bucket:bucket_river_water", "bucket:bucket_empty"}},
})

-- Ice Creams

minetest.register_craftitem("ice_and_tea:cone", {
    description = S("Ice cream cone"),
	inventory_image = "coneminetest.png",
	on_use = minetest.item_eat(4, ""),
})

minetest.register_craftitem("ice_and_tea:icecreambanana", {
    description = S("Banana Icecream"),
	inventory_image = "Icecreambanana.png",
	on_use = minetest.item_eat(6, ""),
})

minetest.register_craftitem("ice_and_tea:icecreamchocolate", {
    description = S("Choco Icecream"),
	inventory_image = "Icecreamchocolate.png",
	on_use = minetest.item_eat(6, ""),
})

minetest.register_craftitem("ice_and_tea:icecreammatcha", {
    description = S("Matcha Icecream"),
	inventory_image = "Icecreammatcha.png",
	on_use = minetest.item_eat(6, ""),
})

minetest.register_craftitem("ice_and_tea:icecreamstrawberry", {
    description = S("Strawberry Icecream"),
	inventory_image = "Icecreamstrawberry.png",
	on_use = minetest.item_eat(6, ""),
})

minetest.register_craftitem("ice_and_tea:icecreamvanilla", {
    description = S("Vanilla Icecream"),
	inventory_image = "Icecreamvanilla.png",
	on_use = minetest.item_eat(6, ""),
})

minetest.register_craft({
    output = "ice_and_tea:cone 4",
	recipe = {
	    {"","group:food_flour","mobs:egg"},
	    {"group:food_sugar","mobs:bucket_milk",""},
	    {"","",""},
	},
	replacements = {
		{"mobs:bucket_milk","bucket:bucket_empty"},
	},
})

minetest.register_craft({
    output = "ice_and_tea:icecreambanana 2",
	recipe = {
	    {"ethereal:banana","",""},
		{"mobs:egg","group:food_sugar",""},
		{"ice_and_tea:cone","default:ice",""},
	},
	replacements = {
	    {"default:ice", "default:ice"},
	},
})

minetest.register_craft({
    output = "ice_and_tea:icecreamchocolate 2",
	recipe = {
	    {"group:food_cocoa","",""},
		{"mobs:egg","group:food_sugar",""},
		{"ice_and_tea:cone","default:ice",""},
	},
	replacements = {
	    {"default:ice", "default:ice"},
	},
})

minetest.register_craft({
    output = "ice_and_tea:icecreammatcha 2",
	recipe = {
	    {"ice_and_tea:crushedmatcha","",""},
		{"mobs:egg","group:food_sugar",""},
		{"ice_and_tea:cone","default:ice",""},
	},
	replacements = {
	    {"default:ice", "default:ice"},
	},
})

minetest.register_craft({
    output = "ice_and_tea:icecreamstrawberry 2",
	recipe = {
	    {"ethereal:strawberry","",""},
		{"mobs:egg","group:food_sugar",""},
		{"ice_and_tea:cone","default:ice",""},
	},
	replacements = {
	    {"default:ice", "default:ice"},
	},
})

minetest.register_craft({
    output = "ice_and_tea:icecreamvanilla 2",
	recipe = {
	    {"farming:vanilla_extract","",""},
		{"mobs:egg","group:food_sugar",""},
		{"ice_and_tea:cone","default:ice",""},
	},
	replacements = {
	    {"farming:vanilla_extract","vessels:glass_bottle"},
		{"default:ice", "default:ice"},
	},
})

minetest.register_node("ice_and_tea:icecreambanana", {
    description = S("Banana Icecream"),
    drawtype = "plantlike",
    tiles = {"Icecreambanana.png"},
    inventory_image = "Icecreambanana.png",
    wield_image = "Icecreambanana.png",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
	selection_box = {
	   type = "fixed",
	   fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
       	attached_node = 1},
	on_use = minetest.item_eat(6, ""),
})

minetest.register_node("ice_and_tea:icecreamchocolate", {
    description = S("Choco Icecream"),
    drawtype = "plantlike",
    tiles = {"Icecreamchocolate.png"},
    inventory_image = "Icecreamchocolate.png",
    wield_image = "Icecreamchocolate.png",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
	selection_box = {
	   type = "fixed",
	   fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
       	attached_node = 1},
	on_use = minetest.item_eat(6, ""),
})
minetest.register_node("ice_and_tea:icecreammatcha", {
    description = S("Matcha Icecream"),
    drawtype = "plantlike",
    tiles = {"Icecreammatcha.png"},
    inventory_image = "Icecreammatcha.png",
    wield_image = "Icecreammatcha.png",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
	selection_box = {
	   type = "fixed",
	   fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
       	attached_node = 1},
	on_use = minetest.item_eat(6, ""),
})

minetest.register_node("ice_and_tea:icecreamstrawberry", {
    description = S("Strawberry Icecream"),
    drawtype = "plantlike",
    tiles = {"Icecreamstrawberry.png"},
    inventory_image = "Icecreamstrawberry.png",
    wield_image = "Icecreamstrawberry.png",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
	selection_box = {
	   type = "fixed",
	   fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
       	attached_node = 1},
	on_use = minetest.item_eat(6, ""),
})

minetest.register_node("ice_and_tea:icecreamvanilla", {
    description = S("Vanilla Icecream"),
    drawtype = "plantlike",
    tiles = {"Icecreamvanilla.png"},
    inventory_image = "Icecreamvanilla.png",
    wield_image = "Icecreamvanilla.png",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
	selection_box = {
	   type = "fixed",
	   fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16},
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
       	attached_node = 1},
	on_use = minetest.item_eat(6, ""),
})

if minetest.get_modpath("bonemeal") ~= nil then
    bonemeal:add_sapling({
	     {"ice_and_tea:tea_sapling", grow_new_tea, "default:dirt_with_grass"},
	})
end
