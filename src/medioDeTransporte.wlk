class MedioDeTransporte {
	var minutosKm  // Cuantos minutos tarda en hacer un km
	
	method costoKm()
	method minutosKm() = minutosKm
	
	method costoViaje(unaDistancia) {
		return self.costoKm() * unaDistancia
	}
}

class Avion inherits MedioDeTransporte {
	var turbinas = []
	
	override method costoKm() {
		return turbinas.sum{ unaTurbina => unaTurbina.impulso() }
	}
}

class Turbina {
	var impulso
	
	method impulso() = impulso
}

class Micro inherits MedioDeTransporte {
	override method costoKm() = 5000
}

class Tren inherits MedioDeTransporte {
	
	override method costoKm() {
		return self.costoMilla() * 1.61
	}
	
	method costoMilla() {
		return 2300
	}
}

class Barco inherits MedioDeTransporte {
	var probabilidadChoque
	
	override method costoKm() {
		return probabilidadChoque * 1000
	}
}