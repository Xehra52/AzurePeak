/datum/job/roguetown/gmagician
	title = "Grenzelhoft Magos"
	flag = GMAGICIAN
	department_flag = SIEGER
	faction = "Station"
	total_positions = 0
	spawn_positions = 0

	allowed_races = RACES_ALL_KINDS
	allowed_sexes = list(MALE, FEMALE)
	spells = list(/obj/effect/proc_holder/spell/targeted/touch/prestidigitation, /obj/effect/proc_holder/spell/invoked/projectile/fireball/greater)
	display_order = JDO_GMAGICIAN
	tutorial = "Your creed is one dedicated to the conquering of the arcane arts and the constant thrill of knowledge. \
		You serve the Grenzelhoft Empire as a magister, see to it that the Captain's will is done."
	outfit = /datum/outfit/job/roguetown/gmagician
	whitelist_req = TRUE
	min_pq = 4 
	max_pq = null
	round_contrib_points = 5
	cmode_music = 'sound/music/combat_grenzelhoft.ogg'

/datum/outfit/job/roguetown/gmagician/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/roguetown/talkstone
	cloak = /obj/item/clothing/cloak/cape
	pants = /obj/item/clothing/under/roguetown/tights/random
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	head = /obj/item/clothing/head/roguetown/wizhat/black
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/wizard/black
	beltl = /obj/item/book/granter/spellbook/magician
	id = /obj/item/clothing/ring/gold
	r_hand = /obj/item/rogueweapon/woodstaff
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/slimepotion/lovepotion,/obj/item/reagent_containers/glass/bottle/rogue/poison,/obj/item/reagent_containers/glass/bottle/rogue/healthpot)
	ADD_TRAIT(H, TRAIT_SEEPRICES, "[type]")
	ADD_TRAIT(H, TRAIT_SIEGER, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/alchemy, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.change_stat("strength", -1)
		H.change_stat("constitution", -1)
		H.change_stat("intelligence", 4)
		H.mind.adjust_spellpoints(3)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
			H.change_stat("speed", -1)
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 1)
			H.mind.adjust_spellpoints(1)
