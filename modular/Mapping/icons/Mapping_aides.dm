/*	..................   FLOORS   ................... */

/turf/open/water/bath/pool
	desc = "Clear water, pleasant temperature. Soothing."
	icon_state = "bathtile_pool"
/turf/open/water/bath/pool/Initialize()
	.  = ..()
	icon_state = "bathtile_pool"

/turf/open/water/bath/pool/mid
	icon_state = "bathtile_pool_mid"
/turf/open/water/bath/pool/mid/Initialize()
	.  = ..()
	icon_state = "bathtile_pool_mid"

/*	..................   SPIDER   ................... */

/obj/structure/spider/stickyweb
	name = "web"
	icon = 'modular/Mapping/icons/webbing.dmi'
	icon_state = "stickyweb1"
	resistance_flags = FLAMMABLE
	alpha = 109
	max_integrity = 30
	opacity = TRUE
	debris = list(/obj/item/natural/silk = 1)

/obj/structure/spider/stickyweb/attacked_by(obj/item/I, mob/living/user) //Snipping action for webs, scissors turning webs into silk fast!
	var/snip_time = 50
	var/sewing_skill = user.mind.get_skill_level(/datum/skill/misc/sewing)
	var/amount = rand(1, 2)
	if(user.used_intent.type == /datum/intent/snip)
		snip_time = (50 - (sewing_skill * 10))
		if(!do_after(user, snip_time, target = user))
			return TRUE
		for(var/i = 1; i <= amount; i++)
			new /obj/item/natural/silk (get_turf(src))
		user.visible_message(span_notice("[user] snips [src] up into silk."))
		user.mind.add_sleep_experience(/datum/skill/misc/sewing, (user.STAINT / 2)) //We're getting experience for harvesting silk!
		playsound(src, 'sound/items/flint.ogg', 100, TRUE)
		qdel(src)
		return TRUE
	..()

/obj/structure/spider/stickyweb/CanPass(atom/movable/mover, turf/target)
	if(isliving(mover))
		if(prob(50) && !HAS_TRAIT(mover, TRAIT_WEBWALK))
			to_chat(mover, "<span class='danger'>I get stuck in \the [src] for a moment.</span>")
			return FALSE
	else if(istype(mover, /obj/projectile))
		return prob(30)
	return TRUE

/obj/structure/spider/stickyweb/fire_act(added, maxstacks)
	visible_message(span_warning("[src] catches fire!"))
	var/turf/T = get_turf(src)
	qdel(src)
	new /obj/effect/hotspot(T)

/obj/structure/spider/stickyweb/solo
	icon_state = "stickyweb3"

/obj/structure/spider/stickyweb/Initialize()
	if(icon_state == "stickyweb1")
		if(prob(50))
			icon_state = "stickyweb2"
	dir = pick(GLOB.cardinals)
	alpha = rand(80,109)
	switch(pick(1,2))
		if (1)
			static_debris = FALSE
		if (2)
			static_debris = list(/obj/item/natural/silk = 1)
	. = ..()

/obj/structure/spider/cocoon
	name = "cocoon"
	desc = ""
	icon_state = "cocoon1"
	max_integrity = 40

/obj/structure/spider/cocoon/container_resist(mob/living/user)
	var/breakout_time = 600
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	to_chat(user, "<span class='notice'>I struggle against the tight bonds... (This will take about [DisplayTimeText(breakout_time)].)</span>")
	visible_message("<span class='notice'>I see something struggling and writhing in \the [src]!</span>")
	if(do_after(user,(breakout_time), target = src))
		if(!user || user.stat != CONSCIOUS || user.loc != src)
			return
		qdel(src)

/obj/structure/spider/cocoon/Destroy()
	var/turf/T = get_turf(src)
	src.visible_message("<span class='warning'>\The [src] splits open.</span>")
	for(var/atom/movable/A in contents)
		A.forceMove(T)
	return ..()

/obj/structure/spider/cocoon/Initialize()
	switch(pick(1,2,3,4,5))
		if (1)
			static_debris = list(/obj/item/natural/silk = 3)
			icon_state = pick("cocoon1","cocoon2")
		if (2)
			static_debris = list(/obj/item/natural/silk = 2, /obj/effect/decal/remains/bigrat = 1)
			icon_state = pick("cocoon2","cocoon3")
		if (3)
			static_debris = list(/obj/item/natural/silk = 2, /obj/effect/decal/remains/human = 1)
			icon_state = pick("cocoon_large1","cocoon_large2","cocoon_large3")
		if (4)
			static_debris = list(/obj/item/natural/silk = 2, /obj/effect/decal/cleanable/blood/gibs = 1)
			icon_state = pick("cocoon1","cocoon2","cocoon3")
		if (5)
			static_debris = list(/obj/item/natural/silk = 2, /obj/item/natural/stone = 1)
			icon_state = pick("cocoon1","cocoon2")
	. = ..()
