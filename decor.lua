-- Misc decor nodes (marble detailing, render, etc)

-- Triglyphs
greek.register_node_and_stairs("hades_greek:triglyph", {
    description = "Marble Triglyph",
    tiles = {"greek_marble_polished.png", "greek_marble_polished.png", "greek_triglyph.png"},
    paramtype2 = "facedir",
    groups = greek.marble_groups,
    sounds = greek.marble_sounds,
})

minetest.register_craft({
    output = "hades_greek:triglyph 4",
    recipe = {
        {"hades_greek:marble_polished", "", "hades_greek:marble_polished"},
        {"hades_greek:marble_polished", "", "hades_greek:marble_polished"},
    }
})

minetest.register_craft({
    output = "hades_greek:triglyph",
    recipe = {"hades_greek:triglyph_blue", "dye:white"},
    type = "shapeless",
})

greek.register_node_and_stairs("hades_greek:triglyph_blue", {
    description = "Blue Marble Triglyph",
    tiles = {"greek_marble_polished.png^[multiply:#4a797d", "greek_marble_polished.png^[multiply:#4a797d", "greek_triglyph.png^[multiply:#4a797d"},
    paramtype2 = "facedir",
    groups = greek.marble_groups,
    sounds = greek.marble_sounds,
})

minetest.register_craft({
    output = "hades_greek:triglyph_blue",
    recipe = {"hades_greek:triglyph", "dye:blue"},
    type = "shapeless",
})

-- Metopes
local metopes = {
    "man_standing",
    "two_men",
    "three_men",
    "crowd",
    "gaurd",
    "chariot",
    "horse",
    "horses",
    "centaur_and_man",
    "rider",
    "man_laying",
    "man_kneeling",
}

for _, name in pairs(metopes) do
    minetest.register_node("hades_greek:metope_" .. name, {
        description = "Metope (" .. (" " .. name):gsub("%W%l", string.upper):sub(2) .. ")",
        tiles = {
            "greek_metope_base.png", "greek_metope_base.png",
            "greek_metope_base.png^greek_metope_" .. name .. ".png^[transformFX", "greek_metope_base.png^greek_metope_" .. name .. ".png^[transformFX",
            "greek_metope_base.png^greek_metope_" .. name .. ".png", "greek_metope_base.png^greek_metope_" .. name .. ".png"},
        paramtype2 = "facedir",
        groups = greek.marble_groups,
        sounds = greek.marble_sounds,
    })
end

greek.register_craftring("hades_greek:metope_%s", metopes)

minetest.register_craft({
    output = "hades_greek:metope_" .. metopes[1] .. " 2",
    recipe = {"hades_greek:marble_polished", "group:hades_greek:red_clay"},
    type = "shapeless",
})

-- Acroterions
minetest.register_node("hades_greek:acroterion", {
    description	= "Marble Acroterion",
    drawtype = "mesh",
    mesh = "greek_acroterion.obj",
    tiles = {"greek_acroterion.png", "blank.png"},
    paramtype = "light",
    sunlight_propagates = true,
    paramtype2 = "facedir",
    groups = greek.marble_groups,
    sounds = greek.marble_sounds,
})

minetest.register_craft({
    output = "hades_greek:acroterion 2",
    recipe = {
        {"", "hades_greek:marble_polished", ""},
        {"", "hades_greek:marble_polished", ""},
        {"hades_greek:marble_polished", "hades_greek:marble_polished", "hades_greek:marble_polished"},
    },
})

minetest.register_craft({
    output = "hades_greek:acroterion",
    recipe = {"hades_greek:acroterion_corner"},
    type = "shapeless",
})

minetest.register_node("hades_greek:acroterion_corner", {
    description	= "Marble Acroterion Corner",
    drawtype = "mesh",
    mesh = "greek_acroterion.obj",
    tiles = {"greek_acroterion_corner.png", "greek_acroterion_corner.png^[transformFX"},
    paramtype = "light",
    sunlight_propagates = true,
    paramtype2 = "facedir",
    groups = greek.marble_groups,
    sounds = greek.marble_sounds,
})

minetest.register_craft({
    output = "hades_greek:acroterion_corner 2",
    recipe = {
        {"hades_greek:marble_polished", "", ""},
        {"hades_greek:marble_polished", "", ""},
        {"hades_greek:marble_polished", "hades_greek:marble_polished", "hades_greek:marble_polished"},
    },
})

minetest.register_craft({
    output = "hades_greek:acroterion_corner 2",
    recipe = {
        {"", "", "hades_greek:marble_polished"},
        {"", "", "hades_greek:marble_polished"},
        {"hades_greek:marble_polished", "hades_greek:marble_polished", "hades_greek:marble_polished"},
    },
})

minetest.register_craft({
    output = "hades_greek:acroterion_corner",
    recipe = {"hades_greek:acroterion"},
    type = "shapeless",
})

-- Render
for _, item in pairs(greek.settings_list("cement")) do
    -- Only bother registering our own cement if it is used
    if item == "greek:cement" then
        minetest.register_craftitem("hades_greek:cement", {
            description = "Cement",
            inventory_image = "greek_cement.png",
            groups = {["hades_greek:cement"] = 1},
        })

        -- Limestone is only used for crafting this specific cement (realistic)
        for _, craftitem in pairs(greek.settings_list("limestone")) do
            greek.add_group(craftitem, "limestone")
        end

        minetest.register_craft({
            output = "hades_greek:cement",
            recipe = "group:hades_greek:limestone",
            type = "cooking",
            cooktime = 7,
        })
    end

    greek.add_group(item, "cement")
end

-- Palette colors and corresponding dyes
local dyes = {["hades_dye:white"] = 0, ["hades_dye:red"] = 1, ["hades_dye:orange"] = 2, ["hades_dye:yellow"] = 3, ["hades_dye:green"] = 4, ["hades_dye:blue"] = 5, ["hades_dye:violet"] = 6, ["hades_dye:black"] = 7}

local registered_render = greek.register_node_and_stairs("hades_greek:render", {
    description = "Render",
    tiles = {"greek_render.png"},
    paramtype2 = "color",
    palette = "greek_render_palette.png",
    groups = {cracky = 3},
    sounds = greek.marble_sounds,
    on_punch = greek.dye_punch(dyes),
})

minetest.register_craft({
    output = "hades_greek:render 2",
    recipe = {"group:hades_greek:cement", "group:sand", "group:water_bucket"},
    replacements = {{"group:water_bucket", "hades_bucket:bucket_empty"}},
    type = "shapeless",
})

-- Recipes for coloring render
for _, item in pairs(registered_render) do
    for dye, color in pairs(dyes) do
        minetest.register_craft({
            output = minetest.itemstring_with_palette(item, color * 32),
            recipe = {item, dye},
            replacements = not greek.settings_get("consume_dye") and {{dye, dye}} or nil,
            type = "shapeless",
        })
    end
end

-- Misc
greek.register_node_and_stairs("hades_greek:gilded_gold", {
    description = "Gilded Gold",
    tiles = {"greek_gilded_gold.png"},
    groups = {cracky = 3, oddly_breakable_by_hand = 1},
    sounds = greek.default_sounds("node_sound_metal_defaults"),
})

for _, item in pairs(greek.settings_list("gold_block")) do
    greek.add_group(item, "gold_block")
end

minetest.register_craft({
    output = "hades_greek:gilded_gold",
    recipe = "group:hades_greek:gold_block",
    type = "cooking",
    cooktime = 25,
})

greek.register_node_and_stairs("hades_greek:red_clay_fired", {
    description = "Fired Red Clay",
    tiles = {"greek_red_clay_fired.png"},
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    sounds = greek.default_sounds("node_sound_stone_defaults"),
})

for _, item in pairs(greek.settings_list("red_clay")) do
    -- Only bother registering our own if it is used
    if item == "hades_greek:red_clay" then
        minetest.register_craftitem("hades_greek:red_clay", {
            description = "Red Clay Lump",
            inventory_image = "greek_red_clay.png",
        })

        for _, craftitem in pairs(greek.settings_list("clay_lump")) do
            greek.add_group(craftitem, "clay_lump")
        end

        minetest.register_craft({
            output = "hades_greek:red_clay 8",
            recipe = {
                {"group:hades_greek:clay_lump", "group:hades_greek:clay_lump", "group:hades_greek:clay_lump"},
                {"group:hades_greek:clay_lump", "dye:red", "group:hades_greek:clay_lump"},
                {"group:hades_greek:clay_lump", "group:hades_greek:clay_lump", "group:hades_greek:clay_lump"},
            },
        })
    end

    greek.add_group(item, "red_clay")
end

minetest.register_craft({
    output = "hades_greek:red_clay_fired",
    recipe = "group:hades_greek:red_clay",
    type = "cooking",
    cooktime = 10,
})

minetest.register_node("hades_greek:chain", {
    description = "Chain",
    drawtype = "mesh",
    mesh = "greek_chain.obj",
    tiles = {{name = "greek_chain.png", backface_culling = false}},
    inventory_image = "greek_chain_inv.png",
    paramtype2 = "facedir",
    place_param2 = 0,
    paramtype = "light",
    sunlight_propagates = true,
    climbable = true,
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = {{-3 / 16, -0.5, -3 / 16, 3 / 16, 0.5, 3 / 16}},
    },
    groups = {choppy = 3, oddly_breakable_by_hand = 2},
    sounds = greek.default_sounds("node_sound_metal_defaults")
})

minetest.register_craft({
    output = "hades_greek:chain 12",
    recipe = {
        {"hades_greek:gilded_gold"},
        {"hades_greek:gilded_gold"},
        {"hades_greek:gilded_gold"},
    }
})
