require ("prototypes.values")
require("prototypes.grue-sounds")
local sounds = require("__base__/prototypes/entity/demo-sounds.lua")

local lp_enemy_autoplace
local autoplace_vanilla = enemy_autoplace
local autoplace_grue = require ("prototypes.enemy-autoplace")
if settings.startup["lp-disable-grue"].value then
  lp_enemy_autoplace = autoplace_vanilla
  else
  lp_enemy_autoplace = autoplace_grue
  end

local grue_scale = 2
local grue_1 = "__lygophobia__/graphics/icons/grue.png"
local grue_2 = "__lygophobia__/graphics/icons/grue-corpse.png"

local HEALTH_S = settings.startup["lp-HealthScaler"].value
local DAMAGE_S = settings.startup["lp-DamageScaler"].value

data:extend(
{

 {
    type = "unit",
    name = "grue",
    icon = "__lygophobia__/graphics/icons/grue.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air"},
    max_health = 600*HEALTH_S,
    order = "b-b-a",
    subgroup="enemies",
    healing_per_tick = 0.01,
    collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
    selection_box = {{-0.4, -0.7}, {0.7, 0.4}},
    attack_parameters =
    {
      type = "projectile",
      range = 9,
      cooldown = 4,
      ammo_category = "melee",
      ammo_type = make_unit_melee_attack_type(30*DAMAGE_S),
      sound = make_grue_attack_sound(),
      animation = biterattackanimation(grue_scale, grue_1, grue_2)
    },
    vision_distance = 30,
    movement_speed = 0.2,
    distance_per_frame = 0.1,
    pollution_to_join_attack = 700/2,
    distraction_cooldown = 300,
    min_pursue_time = 10 * 60,
    max_pursue_distance = 50,
    corpse = "grue-corpse",
    dying_explosion = "blood-explosion-small",
    working_sound = make_grue_working_sound(),
    dying_sound = make_grue_dying_sound(),
    walking_sound = make_grue_walking_sound(),
    running_sound = make_grue_running_sound(),
    running_sound_animation_positions = {2,},
	  water_reflection = biter_water_reflection(small_biter_scale),	
    damaged_trigger_effect = table.deepcopy(data.raw['unit']['small-biter'].damaged_trigger_effect),

    run_animation = biterrunanimation(grue_scale, grue_1, grue_2),
	ai_settings = biter_ai_settings
  },

  add_biter_die_animation(grue_scale, grue_1, grue_2,
  {
    type = "corpse",
    name = "grue-corpse",
    icon = "__lygophobia__/graphics/icons/grue-corpse.png",
    icon_size = 64, icon_mipmaps = 4,
    selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
    selectable_in_game = true,
    subgroup="corpses",
    order = "c[corpse]-a[grue]",
    flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-repairable", "not-on-map"},
	dying_speed = 0.04,
    time_before_removed = 15 * 60 * 60,
  }),

  --SPAWNER--
  {
    type = "unit-spawner",
    name = "grue-spawner",
    icon = "__lygophobia__/graphics/icons/grue.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-player", "placeable-enemy", "not-repairable"},
    max_health = 1200*HEALTH_S,
    order="b-b-g",
    subgroup="enemies",
    working_sound = {
      sound =
      {
        {
          filename = "__lygophobia__/sound/grue/spawner/grue-spawner.ogg",
          volume = 1.0
        }
      },
      apparent_volume = 2
    },
    dying_sound =
    {
      {
        filename = "__lygophobia__/sound/grue/spawner/grue-spawner-corpse.ogg",
        volume = 1.0
      }
    },
    healing_per_tick = 0.02,
    collision_box = {{-3.2, -2.2}, {2.2, 2.2}},
    map_generator_bounding_box = {{-4.2, -3.2}, {3.2, 3.2}},
    selection_box = {{-3.5, -2.5}, {2.5, 2.5}},
    -- in ticks per 1 pu
    pollution_absorption_absolute = 10,
    pollution_absorption_proportional = 0.01,	
    corpse = "grue-spawner-corpse",
    dying_explosion = "blood-explosion-huge",
    max_count_of_owned_units = 3,
    max_friends_around_to_spawn = 2,
    animations =
    {
      spawner_idle_animation(0, biter_tint1),
      spawner_idle_animation(1, biter_tint1),
      spawner_idle_animation(2, biter_tint1),
      spawner_idle_animation(3, biter_tint1)
    },
    result_units = (function()
                     local res = {}
                     res[1] = {"grue", {{0.0, 0.3}, {0.6, 0.0}}}
                    return res
                   end)(),
    -- With zero evolution the spawn rate is 6 seconds, with max evolution it is 2.5 seconds
    spawning_cooldown = {360, 150},
    spawning_radius = 10,
    spawning_spacing = 3,
    max_spawn_shift = 0,
    max_richness_for_spawn_shift = 100,
    --autoplace = lp_enemy_autoplace.enemy_spawner_autoplace(0),
    call_for_help_radius = 20,
    loot = {},	
  },

  {
    type = "corpse",
    name = "grue-spawner-corpse",
    flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
    icon = "__lygophobia__/graphics/icons/grue-corpse.png",
    icon_size = 64, icon_mipmaps = 4,
    collision_box = {{-2, -2}, {2, 2}},
    selection_box = {{-2, -2}, {2, 2}},
    selectable_in_game = false,
    dying_speed = 0.04,
    time_before_removed = 15 * 60 * 60,
    subgroup="corpses",
    order = "c[corpse]-b[grue-spawner]",
    final_render_layer = "remnants",
    animation =
    {
      spawner_die_animation(0, biter_tint1),
      spawner_die_animation(1, biter_tint1),
      spawner_die_animation(2, biter_tint1),
      spawner_die_animation(3, biter_tint1)
    },
    ground_patch =
    {
      sheet = spawner_integration()
    }	
  },
})