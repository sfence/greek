-- Lit nodes.

minetest.register_node("hades_greek:fire_bowl", {
    description = "Fire Bowl",
    drawtype = "mesh",
    mesh = "greek_fire_bowl.obj",
    tiles = {"greek_fire_bowl.png", "blank.png"},
    inventory_image = "greek_fire_bowl_inv.png",
    paramtype = "light",
    sunlight_propagates = true,
    paramtype2 = "facedir",
    place_param2 = 0,
    selection_box = {type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}},
    collision_box = {type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}},
    groups = {cracky = 3, oddly_breakable_by_hand = 2},
    sounds = greek.default_sounds("node_sound_glass_defaults"),
    on_place = function(stack, placer, pointed)
        -- If placed against ceiling, set to hanging fire bowl
        local s, p = minetest.item_place((pointed.under.y > pointed.above.y and stack:replace("hades_greek:fire_bowl_hanging") and stack) or stack, placer, pointed)
        return s:replace("hades_greek:fire_bowl") and s, p
    end,
    on_punch = function(pos, _, puncher)
        for _, group in pairs({"fire", "igniter", "torch"}) do
            if minetest.get_item_group(puncher:get_wielded_item():get_name(), group) > 0 then
                return minetest.swap_node(pos, {name = "hades_greek:fire_bowl_lit"})
            end
        end
    end,
})

minetest.register_node("hades_greek:fire_bowl_lit", {
    description = "Fire Bowl (Lit)",
    drawtype = "mesh",
    mesh = "greek_fire_bowl.obj",
    tiles = {"greek_fire_bowl.png", {name = "greek_fire.png", animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1}}},
    inventory_image = "greek_fire_bowl_lit_inv.png",
    paramtype = "light",
    sunlight_propagates = true,
    paramtype2 = "facedir",
    place_param2 = 0,
    selection_box = {type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}},
    collision_box = {type = "fixed", fixed = {-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}},
    light_source = 12,
    drop = greek.settings_get("fire_bowl_dig_snuff") and "hades_greek:fire_bowl" or nil,
    groups = {cracky = 3, oddly_breakable_by_hand = 2, torch = 1},
    sounds = greek.default_sounds("node_sound_glass_defaults"),
    on_place = function(stack, placer, pointed)
        local s, p = minetest.item_place((pointed.under.y > pointed.above.y and stack:replace("hades_greek:fire_bowl_hanging_lit") and stack) or stack, placer, pointed)
        return s:replace("hades_greek:fire_bowl_lit") and s, p
    end,
    on_punch = function(pos, _, puncher)
        for _, group in pairs({"water", "liquid", "water_bucket"}) do
            if minetest.get_item_group(puncher:get_wielded_item():get_name(), group) > 0 then
                return minetest.swap_node(pos, {name = "hades_greek:fire_bowl"})
            end
        end
    end,
})

minetest.register_node("hades_greek:fire_bowl_hanging", {
    description = "Hanging Fire Bowl (You hacker, you)",
    drawtype = "mesh",
    mesh = "greek_fire_bowl_hanging.obj",
    tiles = {"greek_fire_bowl.png", "blank.png", "greek_chain.png"},
    paramtype = "light",
    sunlight_propagates = true,
    paramtype2 = "facedir",
    selection_box = {type = "fixed", fixed = {-0.5, -1.5, -0.5, 0.5, 0.5, 0.5}},
    collision_box = {type = "fixed", fixed = {-0.5, -1.5, -0.5, 0.5, 0.5, 0.5}},
    groups = {cracky = 3, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
    sounds = greek.default_sounds("node_sound_glass_defaults"),
    drop = "hades_greek:fire_bowl",
    on_punch = function(pos, _, puncher)
        for _, group in pairs({"fire", "igniter", "torch"}) do
            if minetest.get_item_group(puncher:get_wielded_item():get_name(), group) > 0 then
                return minetest.swap_node(pos, {name = "hades_greek:fire_bowl_hanging_lit"})
            end
        end
    end,
})

minetest.register_node("hades_greek:fire_bowl_hanging_lit", {
    description = "Hanging Fire Bowl (Lit) (You hacker, you)",
    drawtype = "mesh",
    mesh = "greek_fire_bowl_hanging.obj",
    tiles = {"greek_fire_bowl.png", {name = "greek_fire.png", animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1}}, "greek_chain.png"},
    paramtype = "light",
    sunlight_propagates = true,
    paramtype2 = "facedir",
    selection_box = {type = "fixed", fixed = {-0.5, -1.5, -0.5, 0.5, 0.5, 0.5}},
    collision_box = {type = "fixed", fixed = {-0.5, -1.5, -0.5, 0.5, 0.5, 0.5}},
    light_source = 12,
    groups = {cracky = 3, oddly_breakable_by_hand = 2, not_in_creative_inventory = 1},
    sounds = greek.default_sounds("node_sound_glass_defaults"),
    drop = greek.settings_get("fire_bowl_dig_snuff") and "hades_greek:fire_bowl" or "hades_greek:fire_bowl_lit",
    on_punch = function(pos, _, puncher)
        for _, group in pairs({"water", "liquid", "water_bucket"}) do
            if minetest.get_item_group(puncher:get_wielded_item():get_name(), group) > 0 then
                return minetest.swap_node(pos, {name = "hades_greek:fire_bowl_hanging"})
            end
        end
    end,
})

minetest.register_craft({
    output = "hades_greek:fire_bowl 2",
    recipe = {
        {"hades_greek:marble_polished", "", "hades_greek:marble_polished"},
        {"", "hades_greek:gilded_gold", ""},
    },
})

minetest.register_node("hades_greek:lamp", {
    description = "Lamp",
    drawtype = "mesh",
    mesh = "greek_lamp.obj",
    tiles = {
        {name = "greek_lamp.png"},
        {name = "greek_lamp.png", animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 4, length = 1}}
    },
    inventory_image = "greek_lamp_inv.png",
    wield_image = "greek_lamp_inv.png",
    paramtype = "light",
    sunlight_propagates = true,
    paramtype2 = "facedir",
    selection_box = {type = "fixed", fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16}},
    collision_box = {type = "fixed", fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, -0.25, 6 / 16}},
    light_source = 8,
    groups = {cracky = 3, oddly_breakable_by_hand = 2, torch = 1},
    sounds = greek.default_sounds("node_sound_glass_defaults"),
})

minetest.register_craft({
    output = "hades_greek:lamp 2",
    recipe = {
        {"group:hades_greek:red_clay", "", "group:hades_greek:red_clay"},
        {"", "group:hades_greek:red_clay", ""},
    },
})
