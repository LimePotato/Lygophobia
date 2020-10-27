data:extend({

	{
	    type = "bool-setting",
	    name = "lp-disable-grue",
	    setting_type = "startup",
	    default_value = false,
	    order = "c[modifier]-a[trigger]",
	    per_user = false
	},

	{
	    type = "double-setting",
	    name = "lp-HealthScaler",
	    setting_type = "startup",
	    default_value = 1.0,
	    minimum_value = 0.1,
	    maximum_value = 100.0,
	    order = "p[modifier]-a[unit]",
	    per_user = false
	},

	{
	    type = "double-setting",
	    name = "lp-DamageScaler",
	    setting_type = "startup",
	    default_value = 1.0,
	    minimum_value = 0.1,
	    maximum_value = 100.0,
	    order = "p[modifier]-a[unit]",
	    per_user = false
	},

	
	
})
