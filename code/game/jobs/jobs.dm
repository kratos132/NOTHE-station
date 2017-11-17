var/const/ENGSEC			=(1<<0)

var/const/CAPTAIN			=(1<<0)

var/const/HOS				=(1<<1)
var/const/WARDEN			=(1<<2)
var/const/DETECTIVE			=(1<<3)
var/const/OFFICER			=(1<<4)
var/const/LAWYER			=(1<<7)
var/const/IAA				=(1<<8)

var/const/CE				=(1<<5)
var/const/ENGINEER			=(1<<6)
//var/const/ATMOSTECH		=(1<<7)

var/const/AI				=(1<<9)
var/const/CYBORG			=(1<<10)

var/const/CENTCOM			=(1<<11)

var/const/MEDSCI			=(1<<1)

var/const/RD				=(1<<0)
var/const/SCIENTIST			=(1<<1)
var/const/CMO				=(1<<2)
var/const/DOCTOR			=(1<<3)
//var/const/CHEMIST			=(1<<4)
//var/const/GENETICIST		=(1<<5)
//var/const/VIROLOGIST		=(1<<6)
//var/const/PSYCHIATRIST	=(1<<7)
//var/const/ROBOTICIST		=(1<<8)
//var/const/PARAMEDIC		=(1<<9)


var/const/SUPPORT			=(1<<2)

var/const/HOP				=(1<<0)
var/const/BARTENDER			=(1<<1)
var/const/BOTANIST			=(1<<2)
var/const/CHEF				=(1<<3)
var/const/JANITOR			=(1<<4)
var/const/LIBRARIAN			=(1<<5)

//var/const/QUARTERMASTER	=(1<<6)
var/const/CARGOTECH			=(1<<6)
var/const/MINER				=(1<<7)

var/const/CHAPLAIN			=(1<<10)
var/const/CLOWN				=(1<<11)
//var/const/MIME			=(1<<12)
var/const/CIVILIAN			=(1<<12)


var/const/KARMA				=(1<<3)

var/const/NANO				=(1<<0)
var/const/BLUESHIELD		=(1<<1)
//var/const/BARBER			=(1<<3)
//var/const/MECHANIC		=(1<<4)
//var/const/BRIGDOC			=(1<<5)
//var/const/JUDGE			=(1<<6)
//var/const/PILOT			=(1<<7)

var/list/assistant_occupations = list(
)

var/list/heads_positions = list(
	"Capitão",
	"Chefe de Staff",
	"Chefe de Segurança",
	"Chefe de Engenharia",
	"Diretor de Pesquisas",
	"Chefe Médico",
)


var/list/command_positions = list(
	"Capitão",
	"Chefe de Staff",
	"Chefe de Segurança",
	"Chefe de Engenharia",
	"Diretor de Pesquisas",
	"Chefe Médico",
	"Blueshield",
	"Representante da federação",
)


var/list/engineering_positions = list(
	"Chefe de Engenharia",
	"Engenheiro da Estação",
	//"Técnico Atmosférico",
	//"Mecanico"
)


var/list/medical_positions = list(
	"Chefe Médico",
	"Médico",
	"Psiquiatra",
	"Químico",
	"Virologista",
	"Paramedico"
)

var/list/scimed_positions = list(
	//"Geneticist",	//Part of both medical and science
)

var/list/science_positions = list(
	"Diretor de Pesquisas",
	"Cientista",
	"Roboticista",
)

//BS12 EDIT
var/list/support_positions = list(
	"Chefe de Staff",
	"Bartender",
	"Botanico",
	"Chefe",
	"Faxineiro",
	"Bibliotecário",
	"Intendente",
	"Técnico de Carga",
	"Mineiro",
	"Capelão",
	"Palhaço",
	"Mimico",
	//"Barbeiro",
	"Magistrado",
	"Representante da Federação",
	"Blueshield"
)

var/list/supply_positions = list(
	"Chefe de Staff",
	"Técnico de Carga",
	"Mineiro",
	"Intendente",
)

var/list/service_positions = support_positions - supply_positions + list("Chefe de Staff")


var/list/security_positions = list(
	"Chefe de Segurança",
	"Guarda",
	"Detetive",
	"Oficial de Segurança",
	"Agente de afazeres internos",
	"Advogado"
	"Psiquiatra Criminal",
	//"Piloto de Segurança",
)


var/list/civilian_positions = list(
	"Civil"
)

var/list/nonhuman_positions = list(
	"AI",
	"Cyborg",
	"Drone",
	"pAI"
)

var/list/whitelisted_positions = list(
	"Blueshield",
	"Representante da federação",
	//"Barbeiro",
	//"Mecanico",
	//"Psiquiatra Criminal",
	//"Magistrado",
	//"Piloto de Segurança",
)


/proc/guest_jobbans(var/job)
	return (job in whitelisted_positions)

/proc/get_job_datums()
	var/list/occupations = list()
	var/list/all_jobs = typesof(/datum/job)

	for(var/A in all_jobs)
		var/datum/job/job = new A()
		if(!job)	continue
		occupations += job

	return occupations

/proc/get_alternate_titles(var/job)
	var/list/jobs = get_job_datums()
	var/list/titles = list()

	for(var/datum/job/J in jobs)
		if(!J)	continue
		if(J.title == job)
			titles = J.alt_titles

	return titles
