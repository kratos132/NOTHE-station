/**********************************************************************
						Cyborg Spec Items
***********************************************************************/
//Might want to move this into several files later but for now it works here
/obj/item/borg/stun
	name = "electrified arm"
	icon = 'icons/obj/items.dmi'
	icon_state = "elecarm"
	var/charge_cost = 30

/obj/item/borg/stun/attack(mob/M, mob/living/silicon/robot/user)
	var/mob/living/silicon/robot/R = user
	if(R && R.cell && R.cell.charge > 0)
		R.cell.use(charge_cost)
	else
		return

	user.do_attack_animation(M)
	M.Weaken(5)
	if (M.stuttering < 5)
		M.stuttering = 5
	M.Stun(5)

	M.visible_message("<span class='danger'>[user] has prodded [M] with [src]!</span>", \
					  "<span class='userdanger'>[user] has prodded you with [src].</span>")
	playsound(loc, 'sound/weapons/Egloves.ogg', 50, 1, -1)

	if(!iscarbon(user))
		M.LAssailant = null
	else
		M.LAssailant = user

	add_logs(M, user, "stunned", src, "(INTENT: [uppertext(user.a_intent)])")

/obj/item/borg/overdrive
	name = "Overdrive"
	icon = 'icons/obj/decals.dmi'
	icon_state = "shock"