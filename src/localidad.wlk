class Localidad{
	var nombre
	var equipajeImprescindible = []
	var precio
	var kmUbicacion
	
	
	method esDestacada() {
		return precio > 2000
	}
	
	method aplicarDescuento(unDescuento) {
		precio *= (100 - unDescuento) / 100
		equipajeImprescindible.add("Certificado de descuento")	
	}
	
	method esPeligrosa() {
		return equipajeImprescindible.any{
			equipaje =>
				self.requiereLlevarVacuna(equipaje)
		}
	}
	
	method requiereLlevarVacuna(equipaje){
		return equipaje.toLowerCase().contains("vacuna")
	}
	
	method poseeItem(unItem){
		return equipajeImprescindible.contains(unItem)
	}
		
	
	method distanciaA(unaLocalidad) {
		return (kmUbicacion - unaLocalidad.kmUbicacion()).abs()
	}
	
	method precio() = precio
	method nombre() = nombre
	method equipajeImprescindible() = equipajeImprescindible
	method kmUbicacion() = kmUbicacion
	
}

class Playa inherits Localidad {
	override method esPeligrosa() {
		return false
	}
}

class Montania inherits Localidad {
	var altura
	
	override method esPeligrosa() {
		return super() && self.esMuyAlta()
	}
	
	method esMuyAlta() {
		return altura > 5000
	}
	
	override method esDestacada() {
		return true
	}
}

class CiudadHistorica inherits Localidad {
	var museos
	
	override method esPeligrosa() {
		return self.poseeItem("Seguro de asistencia al viajero")
	
	}
	
	override method esDestacada() {
		return super() && self.poseeMasDeTresMuseos()
	}
	
	method poseeMasDeTresMuseos() {
		return museos >= 3
	}
}