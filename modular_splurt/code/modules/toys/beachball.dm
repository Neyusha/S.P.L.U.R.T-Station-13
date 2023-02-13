/obj/item/toy/beach_ball
	var/obj/item/electropack/vibrator/onball = null
	var/icon/vibrator

/obj/item/toy/beach_ball/attackby(obj/item/C, mob/user, params)
	if(istype(C, /obj/item/electropack/vibrator) && !onball)
		if(!user.transferItemToLoc(C,src))
			return
		to_chat(user, "<span class='notice'>You add [C] to the [src].</span>")
		onball = C
		playsound(src.loc, 'sound/machines/click.ogg', 50, TRUE)
		vibrator = icon('modular_splurt/icons/toys/beachball.dmi', "ball_vibrator")
		add_overlay(vibrator)

/obj/item/toy/beach_ball/AltClick(mob/living/user)
	..()
	if(onball)
		user.visible_message("[user] removes [onball] from [src].", "<span class='notice'>You remove [onball] from [src].</span>")
		user.put_in_hands(onball)
		onball = null
		cut_overlays()

/obj/item/electropack/vibrator/receive_signal(datum/signal/signal)
	var/obj/item/toy/beach_ball/B = loc
	if(isobj(B))
		if(last > world.time)
			return

		last = world.time + 1 SECONDS //lets stop spam.

		if(B.onball)
			B.shake_animation(10)
			var/intencity = 8*mode
			playsound(loc, 'modular_splurt/sound/lewd/vibrate.ogg', (intencity+10), 1, -1) //vibe intencity scaled up abit for sound
			B.jump()
	..()

/obj/item/toy/beach_ball/proc/jump(atom/movable/AM)
	throw_at(get_edge_target_turf(loc,pick(GLOB.alldirs)),rand(1, 3),1, spin=FALSE)
	shake_animation(10)
