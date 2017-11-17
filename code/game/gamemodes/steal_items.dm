// Theft objectives.
//
// Separated into datums so we can prevent roles from getting certain objectives.

#define THEFT_FLAG_SPECIAL 1
#define THEFT_FLAG_UNIQUE 2

/datum/theft_objective
	var/name=""
	var/typepath=/atom
	var/list/protected_jobs=list()
	var/flags=0

/datum/theft_objective/proc/check_completion(var/datum/mind/owner)
	if(!owner.current)
		return 0
	if(!isliving(owner.current))
		return 0
	var/list/all_items = owner.current.get_contents()
	for(var/obj/I in all_items) //Check for items
		if(istype(I, typepath) && check_special_completion(I))
			return 1
	return 0

/datum/proc/check_special_completion() //for objectives with special checks (is that slime extract unused? does that intellicard have an ai in it? etcetc)
	return 1

/datum/theft_objective/antique_laser_gun
	name = "a Arma Laser Antiga do capitão"
	typepath = /obj/item/weapon/gun/energy/laser/captain
	protected_jobs = list("Capitão")

/datum/theft_objective/hoslaser
	name = "a Reliquia de Arma Laser recriada do Chefe de Segurança"
	typepath = /obj/item/weapon/gun/energy/gun/hos
	protected_jobs = list("Chefe de Segurança")

/datum/theft_objective/hand_tele
	name = "um teletransportador portátil"
	typepath = /obj/item/weapon/hand_tele
	protected_jobs = list("Captão", "Diretor de Pesquisas")

/datum/theft_objective/jetpack
	name = "um jetpack"
	typepath = /obj/item/weapon/tank/jetpack
	protected_jobs = list("Chief Engineer")

/datum/theft_objective/ai
	name = "uma AI funcional"
	typepath = /obj/item/device/aicard

datum/theft_objective/ai/check_special_completion(var/obj/item/device/aicard/C)
	if(..())
		for(var/mob/living/silicon/ai/A in C)
			if(istype(A, /mob/living/silicon/ai) && A.stat != 2) //See if any AI's are alive inside that card.
				return 1
	return 0

/datum/theft_objective/defib
	name = "um defilibrador compacto"
	typepath = /obj/item/weapon/defibrillator/compact
	protected_jobs = list("Chefe Médico")

/datum/theft_objective/magboots
	name = "as botas magnéticas avançadas do Chefe de Engenharia"
	typepath = /obj/item/clothing/shoes/magboots/advance
	protected_jobs = list("Chefe de Engenharia")

/datum/theft_objective/blueprints
	name = "as Blueprints da estação"
	typepath = /obj/item/areaeditor/blueprints
	protected_jobs = list("Chefe de Engenharia")

/datum/theft_objective/voidsuit
	name = "uma Voidsuit da NASA"
	typepath = /obj/item/clothing/suit/space/nasavoid
	protected_jobs = list("Diretor de Pesquisas")

/datum/theft_objective/slime_extract
	name = "uma amostra não usada de extrato de slime"
	typepath = /obj/item/slime_extract
	protected_jobs = list("Diretor de Pesquisas","Cientista")

/datum/theft_objective/slime_extract/check_special_completion(var/obj/item/slime_extract/E)
	if(..())
		if(E.Uses > 0)
			return 1
	return 0

/datum/theft_objective/capmedal
	name = "a medalha de capitania"
	typepath = /obj/item/clothing/accessory/medal/gold/captain
	protected_jobs = list("Captain")

/datum/theft_objective/nukedisc
	name = "um disco de autenticação nuclear"
	typepath = /obj/item/weapon/disk/nuclear
	protected_jobs = list("Capitão")

/datum/theft_objective/reactive
	name = "um Colete de Teletransporte por Reação"
	typepath = /obj/item/clothing/suit/armor/reactive/teleport
	protected_jobs = list("Diretor de Pesquisas")

/datum/theft_objective/steal/documents
	name = "qualquer montande de documentos secretos de qualquer organização"
	typepath = /obj/item/documents //Any set of secret documents. Doesn't have to be NT's

/datum/theft_objective/hypospray
	name = "um hypospray"
	typepath = /obj/item/weapon/reagent_containers/hypospray/CMO
	protected_jobs = list("Chefe Médico")

/datum/theft_objective/ablative
	name = "uma vestimenta de armadura ablativa"
	typepath = /obj/item/clothing/suit/armor/laserproof
	protected_jobs = list("Chefe de Segurança", "Guarda")

/datum/theft_objective/krav
	name = "as luvas de Krav Maga do Guarda"
	typepath = /obj/item/clothing/gloves/color/black/krav_maga/sec
	protected_jobs = list("Chefe de Segurança", "Guarda")

/datum/theft_objective/number
	var/min=0
	var/max=0
	var/step=1

	var/required_amount=0

/datum/theft_objective/number/New()
	if(min==max)
		required_amount=min
	else
		var/lower=min/step
		var/upper=min/step
		required_amount=rand(lower,upper)*step
	name = "[required_amount] [name]"

/datum/theft_objective/number/check_completion(var/datum/mind/owner)
	if(!owner.current)
		return 0
	if(!isliving(owner.current))
		return 0
	var/list/all_items = owner.current.get_contents()
	var/found_amount=0.0
	for(var/obj/item/I in all_items)
		if(istype(I, typepath))
			found_amount += getAmountStolen(I)
	return found_amount >= required_amount

/datum/theft_objective/number/proc/getAmountStolen(var/obj/item/I)
	return I:amount

/datum/theft_objective/number/plasma_gas
	name = "moles de plasma (tanque cheio)"
	typepath = /obj/item/weapon/tank
	min=28
	max=28
	protected_jobs = list("Chefe de Engenharia", "Engenheiro da Estação", "Cientista", "Diretor de Pesquisas", "Técnico Atmosférico")

/datum/theft_objective/number/plasma_gas/getAmountStolen(var/obj/item/I)
	return I:air_contents:toxins

/datum/theft_objective/number/coins
	name = "creditos em moedas (na mochila)"
	min=1000
	max=5000
	step=500

/datum/theft_objective/number/coins/check_completion(var/datum/mind/owner)
	if(!owner.current)
		return 0
	if(!isliving(owner.current))
		return 0
	var/list/all_items = owner.current.get_contents()
	var/found_amount=0.0
	for(var/obj/item/weapon/moneybag/B in all_items)
		if(B)
			for(var/obj/item/weapon/coin/C in B)
				found_amount += C.credits
	return found_amount >= required_amount


////////////////////////////////
// SPECIAL OBJECTIVES
////////////////////////////////
/datum/theft_objective/special
	flags = THEFT_FLAG_SPECIAL

/datum/theft_objective/unique
	flags = THEFT_FLAG_UNIQUE

/datum/theft_objective/unique/docs_red
	name = "o documento secreto \"Vermelho\""
	typepath = /obj/item/documents/syndicate/red

/datum/theft_objective/unique/docs_blue
	name = "o documento secreto \"Azul\""
	typepath = /obj/item/documents/syndicate/blue

/datum/theft_objective/special/pinpointer
	name = "o pinpointer do capitão"
	typepath = /obj/item/weapon/pinpointer

/datum/theft_objective/special/nuke_gun
	name = "arma de energia avançada"
	typepath = /obj/item/weapon/gun/energy/gun/nuclear

/datum/theft_objective/special/diamond_drill
	name = "broca de diamante"
	typepath = /obj/item/weapon/pickaxe/drill/diamonddrill

/datum/theft_objective/special/boh
	name = "saco de segurar"
	typepath = /obj/item/weapon/storage/backpack/holding

/datum/theft_objective/special/hyper_cell
	name = "pilha de hyper-capacidade"
	typepath = /obj/item/weapon/stock_parts/cell/hyper

/datum/theft_objective/number/special
	flags = THEFT_FLAG_SPECIAL

/datum/theft_objective/number/special/diamonds
	name = "diamantes"
	typepath = /obj/item/stack/sheet/mineral/diamond
	min=5
	max=10
	step=5

/datum/theft_objective/number/special/gold
	name = "barras de ouro"
	typepath = /obj/item/stack/sheet/mineral/gold
	min=10
	max=50
	step=10

/datum/theft_objective/number/special/uranium
	name = "barras de uranio refinado"
	typepath = /obj/item/stack/sheet/mineral/uranium
	min=10
	max=30
	step=5
