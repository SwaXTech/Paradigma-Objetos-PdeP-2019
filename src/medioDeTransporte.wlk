class MedioDeTransporte {
	var costoKm
	var minutosKm  // Cuantos minutos tarda en hacer un km
	
	method costoKm() = costoKm
	method minutosKm() = minutosKm
	
	method costoViaje(unaDistancia) {
		return costoKm * unaDistancia
	}
}