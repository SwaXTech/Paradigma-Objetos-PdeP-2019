object barrileteCosmico{
	
	var destinos = #{}
	var mediosDeTransporte = #{}
	
	method destinosMasImportantes() {
		return destinos.filter{
			destino =>
				destino.esDestacado()
		}
	}
	
	method aplicarDescuento(unDescuento) {
		destinos.forEach{
			destino => 
				destino.aplicarDescuento(unDescuento)
		}
	}
	
	method esEmpresaExtrema() {
		return self.destinosMasImportantes().any{
			destino =>
				destino.esPeligroso()
		}
	}
	
	method destinosPeligrosos() {
		return destinos.filter{
			destino => 
				destino.esPeligroso()
		}
	}
	
	method agregarDestino(unDestino) {
		destinos.add(unDestino)
	}
	
	method agregarMedioDeTransporte(unTransporte) {
		mediosDeTransporte.add(unTransporte)
	}
	
	method todosLosDestinosPoseenCertificadoDeDescuento(){
		return destinos.all{
			destino => 
				destino.poseeCertificadoDeDescuento();
		}
	}
	
	method cartaDeDestinos(){
		return destinos.map{
			destino => 
				destino.nombre()
		}.asSet()
	}
	
	method mediosDeTransporte() = mediosDeTransporte
	method destinos() = destinos
	
}

class Localidad{
	var nombre
	var equipajeImprescindible = []
	var precio
	var kmUbicacion
	
	
	method esDestacado() {
		return precio > 2000
	}
	
	method aplicarDescuento(unDescuento) {
		precio *= (100 - unDescuento) / 100
		equipajeImprescindible.add("Certificado de descuento")	
	}
	
	method esPeligroso() {
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


class MedioDeTransporte {
	var costoKm
	var minutosKm  // Cuantos minutos tarda en hacer un km
	
	method costoKm() = costoKm
	method minutosKm() = minutosKm
}

class Viaje {
	var localidadInicial
	var localidadFinal
	var medioDeTransporte
	method precioViaje(){
		return localidadFinal.precio() + localidadInicial.distanciaA(localidadFinal)* medioDeTransporte.costoKm()
	}
	method distanciaViaje(){
		return self.localidadInicial().distanciaA(self.localidadFinal())
	}
	method localidadInicial() = localidadInicial
	method localidadFinal() = localidadFinal
}

class Usuario{
	var nombre
	var nombreDeUsuario
	var viajesRealizados = #{}	
	var siguiendo = #{}
	var saldo
	var localidadDeOrigen
	
	method viajarA(unLugar){
		self.validarQuePuedaViajar(unLugar)	
	
		viajesRealizados.add(unLugar) 
		saldo = saldo - unLugar.precio()
	}
	
	method validarQuePuedaViajar(viaje) {
		if (self.puedeViajar(viaje).negate()) {
			throw new VuelosUsuarioException(message = "No se cuenta con saldo suficiente para realizar el viaje")	
		}
	}
	
	method puedeViajar(viaje){
		return saldo >= viaje.precioViaje()
	}
	
	method obtenerKM(){
		return viajesRealizados.sum({
			viaje =>
			viaje.distanciaViaje()
		})
	}
	
	
	method seguirA(unUsuario){
		if (self.estaSiguiendoA(unUsuario).negate()) 	{
			siguiendo.add(unUsuario)
			unUsuario.seguirA(self)			
		}
	}
	
	method estaSiguiendoA(unUsuario) {
		return siguiendo.contains(unUsuario)
	}
	
	method realizoViajeA(unLugar){
		return viajesRealizados.any({
			viaje =>
			viaje.LocalidadFinal() == unLugar 
		})
	}
	
	method saldo() = saldo
	method viajesRealizados() = viajesRealizados
}

class VuelosUsuarioException inherits Exception{}