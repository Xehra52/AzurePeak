/obj/projectile
	var/is_silver = FALSE
	var/last_used = 0

/obj/projectile/proc/funny_attack_effects(mob/living/target, mob/living/user, nodmg)
	if(is_silver)
		if(world.time < src.last_used + 120)
			to_chat(user, span_notice("The silver effect is on cooldown."))
			return

		if(ishuman(target) && target.mind)
			var/mob/living/carbon/human/s_user = user
			var/mob/living/carbon/human/H = target
			var/datum/antagonist/werewolf/W = H.mind.has_antag_datum(/datum/antagonist/werewolf/)
			var/datum/antagonist/vampirelord/lesser/V = H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser)
			var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
			if(V)
				if(V.disguised)
					H.visible_message("<font color='white'>The silver projectile weakens the curse temporarily!</font>")
					to_chat(H, span_userdanger("I'm hit by my BANE!"))
					H.apply_status_effect(/datum/status_effect/debuff/silver_curse)
					src.last_used = world.time
				else
					H.visible_message("<font color='white'>The silver projectile weakens the curse temporarily!</font>")
					to_chat(H, span_userdanger("I'm hit by my BANE!"))
					H.apply_status_effect(/datum/status_effect/debuff/silver_curse)
					src.last_used = world.time
			if(V_lord)
				if(V_lord.vamplevel < 4 && !V)
					H.visible_message("<font color='white'>The silver projectile weakens the curse temporarily!</font>")
					to_chat(H, span_userdanger("I'm hit by my BANE!"))
					H.apply_status_effect(/datum/status_effect/debuff/silver_curse)
					src.last_used = world.time
				if(V_lord.vamplevel == 4 && !V)
					to_chat(s_user, "<font color='red'> The silver projectile fails!</font>")
					H.visible_message(H, span_userdanger("This feeble metal can't hurt me, I AM ANCIENT!"))
			if(W && W.transformed == TRUE)
				H.visible_message("<font color='white'>The silver projectile weakens the curse temporarily!</font>")
				to_chat(H, span_userdanger("I'm hit by my BANE!"))
				H.apply_status_effect(/datum/status_effect/debuff/silver_curse)
				src.last_used = world.time
	return

/obj/item/ammo_casing/caseless/rogue/bolt
	name = "bolt"
	desc = "A durable iron bolt that will pierce a skull easily."
	projectile_type = /obj/projectile/bullet/reusable/bolt
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/thrust)
	caliber = "regbolt"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "bolt"
	dropshrink = 0.6
	max_integrity = 10
	force = 10
/*
/obj/item/ammo_casing/caseless/rogue/bolt/poison
	name = "poisoned bolt"
	desc = "A durable iron bolt that will pierce a skull easily. This one is coated in a clear liquid."
	projectile_type = /obj/projectile/bullet/reusable/bolt/poison
	icon_state = "arrow_poison"
*/
/obj/projectile/bullet/reusable/bolt
	name = "bolt"
	damage = 70
	damage_type = BRUTE
	armor_penetration = 50
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "bolt_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/bolt
	range = 15
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag = "bullet"
	speed = 0.5

/obj/item/ammo_casing/caseless/rogue/bolt/silver
	name = "silver bolt"
	desc = "A durable silver bolt that will pierce a skull easily. Unholy creatures beware.."
	projectile_type = /obj/projectile/bullet/reusable/bolt/silver
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/thrust)
	caliber = "silverbolt"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "silverbolt"
	dropshrink = 0.6
	max_integrity = 10
	force = 10
	is_silver = TRUE

/obj/projectile/bullet/reusable/bolt/silver
	name = "silver bolt"
	damage = 50
	damage_type = BRUTE
	armor_penetration = 30
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "silverbolt_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/bolt
	range = 15
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag = "bullet"
	speed = 0.5
	is_silver = TRUE

/obj/projectile/bullet/reusable/bolt/on_hit(atom/target)
	. = ..()

	var/mob/living/L = firer
	if(!L || !L.mind) return

	var/skill_multiplier = 0

	if(isliving(target)) // If the target theyre shooting at is a mob/living
		var/mob/living/T = target
		if(T.stat != DEAD) // If theyre alive
			skill_multiplier = 4

	if(skill_multiplier && can_train_combat_skill(L, /datum/skill/combat/crossbows, SKILL_LEVEL_EXPERT))
		L.mind.add_sleep_experience(/datum/skill/combat/crossbows, L.STAINT * skill_multiplier)

/*
/obj/projectile/bullet/reusable/bolt/poison
	name = "poisoned bolt"
	damage = 50
	ammo_type = /obj/item/ammo_casing/caseless/rogue/bolt/poison


/obj/projectile/bullet/reusable/bolt/poison/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.reagents.add_reagent(/datum/reagent/toxin/mutetoxin, 7) //not gonna kill anyone, but they will be quite quiet
*/
/obj/item/ammo_casing/caseless/rogue/arrow
	name = "arrow"
	desc = "A wooden shaft with a pointy iron end."
	projectile_type = /obj/projectile/bullet/reusable/arrow
	caliber = "arrow"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow"
	force = 30
	dropshrink = 0.6
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/thrust)
	max_integrity = 20

/obj/item/ammo_casing/caseless/rogue/arrow/iron
	name = "iron arrow"
	desc = "A wooden shaft with a pointy iron end."
	projectile_type = /obj/projectile/bullet/reusable/arrow/iron
	caliber = "arrow"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow"
	force = 30
	dropshrink = 0.6
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/thrust)
	max_integrity = 20

/obj/item/ammo_casing/caseless/rogue/arrow/silver
	name = "silver arrow"
	desc = "A wooden shaft with a pointy silver end. Unholy creatures beware.."
	projectile_type = /obj/projectile/bullet/reusable/arrow/silver
	caliber = "arrow"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "silverarrow"
	force = 26
	dropshrink = 0.6
	possible_item_intents = list(/datum/intent/dagger/cut, /datum/intent/dagger/thrust)
	max_integrity = 20
	is_silver = TRUE

/obj/projectile/bullet/reusable/arrow
	name = "arrow"
	damage = 50
	damage_type = BRUTE
	armor_penetration = 40
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow
	range = 15
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag = "bullet"
	speed = 0.4

/obj/projectile/bullet/reusable/arrow/on_hit(atom/target)
	. = ..()

	var/mob/living/L = firer
	if(!L || !L.mind) return

	var/skill_multiplier = 0

	if(isliving(target)) // If the target theyre shooting at is a mob/living
		var/mob/living/T = target
		if(T.stat != DEAD) // If theyre alive
			skill_multiplier = 4

	if(skill_multiplier && can_train_combat_skill(L, /datum/skill/combat/bows, SKILL_LEVEL_EXPERT))
		L.mind.add_sleep_experience(/datum/skill/combat/bows, L.STAINT * skill_multiplier)

/obj/projectile/bullet/reusable/arrow/iron
	name = "iron arrow"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow/iron

/obj/projectile/bullet/reusable/arrow/silver
	name = "silver arrow"
	icon_state = "silverarrow_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow/silver
	armor_penetration = 20
	damage = 30
	is_silver = TRUE

/obj/projectile/bullet/reusable/arrow/stone
	name = "stone arrow"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow/stone

/obj/item/ammo_casing/caseless/rogue/arrow/stone
	name = "stone arrow"
	desc = "A wooden shaft with a jagged rock on the end."
	icon_state = "stonearrow"
	max_integrity = 5
	projectile_type = /obj/projectile/bullet/reusable/arrow/stone

/obj/item/ammo_casing/caseless/rogue/arrow/poison
	name = "poisoned arrow"
	desc = "A wooden shaft with a pointy iron end. This one is stained green with floral toxins."
	projectile_type = /obj/projectile/bullet/reusable/arrow/poison
	icon_state = "arrow_poison"
	max_integrity = 20 // same as normal arrow; usually breaks on impact with a mob anyway

/obj/item/ammo_casing/caseless/rogue/arrow/stone/poison
	name = "poisoned stone arrow"
	desc = "A wooden shaft with a jagged rock on the end. This one is stained green with floral toxins."
	projectile_type = /obj/projectile/bullet/reusable/arrow/poison/stone
	icon_state = "stonearrow_poison"

/obj/projectile/bullet/reusable/arrow/poison
	name = "poison arrow"
	damage = 50
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow/iron
	range = 15
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	poisontype = /datum/reagent/berrypoison //Support for future variations of poison for arrow-crafting
	poisonfeel = "burning" //Ditto
	poisonamount = 5 //Support and balance for bodkins, which will hold less poison due to how

/obj/projectile/bullet/reusable/arrow/poison/stone
	name = "stone arrow"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow/stone

/obj/projectile/bullet/reusable/arrow/poison/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(istype(target, /mob/living/simple_animal)) //On-hit for carbon mobs has been moved to projectile act in living_defense.dm, to ensure poison is not applied if armor prevents damage.
		var/mob/living/simple_animal/M = target
		M.show_message(span_danger("You feel an intense burning sensation spreading swiftly from the puncture!")) //In case a player is in control of the mob.
		addtimer(CALLBACK(M, TYPE_PROC_REF(/mob/living, adjustToxLoss), 100), 10 SECONDS)
		addtimer(CALLBACK(M, TYPE_PROC_REF(/atom, visible_message), span_danger("[M] appears greatly weakened by the poison!")), 10 SECONDS)

/obj/projectile/bullet/reusable/bullet/iron
	name = "iron bullet"
	damage = 50
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/bullet/iron
	range = 30
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag = "bullet"
	armor_penetration = 200
	speed = 0.4

/obj/item/ammo_casing/caseless/rogue/bullet/iron
	name = "iron bullet"
	desc = "A small iron sphere. Useful in a boomstick."
	projectile_type = /obj/projectile/bullet/reusable/bullet/iron
	caliber = "musketball"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "musketball"
	dropshrink = 0.5
	possible_item_intents = list(/datum/intent/use)
	max_integrity = 20

/obj/projectile/bullet/reusable/bullet/silver
	name = "silver bullet"
	damage = 50
	damage_type = BRUTE
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "silverball_proj"
	ammo_type = /obj/item/ammo_casing/caseless/rogue/bullet
	range = 30
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag = "bullet"
	armor_penetration = 100
	speed = 0.4
	is_silver = TRUE

/obj/item/ammo_casing/caseless/rogue/bullet/silver
	name = "silver bullet"
	desc = "A small silver sphere. Unholy creatures beware.."
	projectile_type = /obj/projectile/bullet/reusable/bullet
	caliber = "musketball"
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "silverball"
	dropshrink = 0.5
	possible_item_intents = list(/datum/intent/use)
	max_integrity = 20
	is_silver = TRUE
