eb_cooldown = 20



cold_resists =
    {
      {
        type = "explosion",
        percent = -40,
      },
      {
        type = "fire",
        percent = -100,
      },
      {
        type = "electric",
        percent = -20,
      },	  
      {
        type = "acid",
        percent = 100,
      },
      {
        type = "cold",
        percent = 100,
      },

    }
	


cold_leviathan_resists = 
    {
      {
        type = "physical",
        decrease = 12,
        percent = 75,
      },
      {
        type = "explosion",
        decrease = 50,
        percent = -40,
      },
      {
        type = "laser",
        percent = 70,
      },
      {
        type = "impact",
        percent = 50,
      },

      {
        type = "fire",
        percent = -100,
      },
      {
        type = "electric",
        percent = -20,
      },
      {
        type = "poison",
        percent = 50,
      },
      {
        type = "acid",
        percent = 50,
      },
    }

if data.raw["damage-type"]["bob-pierce"] then	
table.insert(cold_leviathan_resists,	
      {
        type = "bob-pierce",
        decrease = 25,
        percent = 80,
      })
end




function make_unit_melee_attack_type(damagevalue)
  return
  {
    category = "melee",
    target_type = "entity",
    action =
    {
      type = "direct",
      action_delivery =
      {
        type = "instant",
        target_effects =
        {
          type = "damage",
          damage = { amount = damagevalue/2 , type = "physical"}
        },
        {
          type = "damage",
          damage = { amount = damagevalue/2 , type = "cold"}
        }		
      }
    }
  }
end
