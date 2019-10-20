object barrileteCosmico{
	
	var localidades = #{}
	var mediosDeTransporte = #{}
	
	method localidadesMasImportantes() {
		return localidades.filter{
			localidad =>
				localidad.esDestacada()
		}
	}
	
	method aplicarDescuento(unDescuento) {
		localidades.forEach{
			localidad => 
				localidad.aplicarDescuento(unDescuento)
		}
	}
	
	method esEmpresaExtrema() {
		return self.localidadesMasImportantes().any{
			localidad =>
				localidad.esPeligrosa()
		}
	}
	
	method localidadesPeligrosas() {
		return localidades.filter{
			localidad => 
				localidad.esPeligrosa()
		}
	}
	
	method agregarLocalidad(unaLocalidad) {
		localidades.add(unaLocalidad)
	}
	
	method agregarMedioDeTransporte(unTransporte) {
		mediosDeTransporte.add(unTransporte)
	}
	
	method todasLasLocalidadesPoseenCertificadoDeDescuento(){
		return localidades.all{
			localidad => 
				localidad.poseeCertificadoDeDescuento();
		}
	}
	
	method cartaDeLocalidades(){
		return localidades.map{
			localidad => 
				localidad.nombre()
		}.asSet()
	}
	
	method armarUnViaje(usuario, destino){
		return new Viaje(localidadInicial = usuario.localidadDeOrigen(), localidadFinal = destino, medioDeTransporte = mediosDeTransporte.anyOne())
	}
	
	method mediosDeTransporte() = mediosDeTransporte
	method localidades() = localidades
	
}

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


class MedioDeTransporte {
	var costoKm
	var minutosKm  // Cuantos minutos tarda en hacer un km
	
	method costoKm() = costoKm
	method minutosKm() = minutosKm
	
	method costoViaje(unaDistancia) {
		return costoKm * unaDistancia
	}
}

class Viaje {
	var localidadInicial
	var localidadFinal
	var medioDeTransporte
	
	
	method precioViaje(){
		return localidadFinal.precio() + self.costoTransporte()
	}
	
	method costoTransporte() {
		return medioDeTransporte.costoViaje(self.distanciaViaje())
	}
	
	
	method distanciaViaje(){
		return localidadInicial.distanciaA(localidadFinal)
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
	
	method viajarA(unViaje){
		
		self.validarQuePuedaViajar(unViaje)	
		self.actualizarViajesRealizados(unViaje) 
		self.actualizarLocalidad(unViaje)
		self.actualizarSaldo(unViaje)
		
	}
	
	method actualizarViajesRealizados(unViaje) {
		viajesRealizados.add(unViaje)
	}
	
	method actualizarSaldo(unViaje) {
		saldo = saldo - unViaje.precioViaje()
	}
	
	method actualizarLocalidad(unViaje) {
		localidadDeOrigen = unViaje.localidadFinal()
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
				self.elDestinoDelViajeEs(viaje, unLugar) 
		})
	}
	
	method elDestinoDelViajeEs(viaje, unLugar) {
		return viaje.localidadFinal() == unLugar
	}
	
	method saldo() = saldo
	method localidadDeOrigen() = localidadDeOrigen
	/*method viajes(){
		return viajesRealizados.map{
			viaje =>
				viaje.localidadFinal().nombre()
		}
	}*/
}

class VuelosUsuarioException inherits Exception{}