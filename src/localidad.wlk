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
	
	method poseeCertificadoDeDescuento(){
		return equipajeImprescindible.contains("Certificado de descuento")
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
		return super() && altura > 5000
	}
	
	override method esDestacada() {
		return true
	}
}

class CiudadHistorica inherits Localidad {
	var museos
	
	override method esPeligrosa() {
		return equipajeImprescindible.any{
			equipaje =>
				self.requiereLlevarSeguroAsistencia(equipaje)
		}
	}
	
	method requiereLlevarSeguroAsistencia(equipaje){
		return equipaje.toLowerCase().contains("seguro de asistencia al viajero")
	}
	
	override method esDestacada() {
		return super() && museos >= 3
	}
}