class Usuario{
	var nombre
	var nombreDeUsuario
	var viajesRealizados = #{}
	var siguiendo = #{}
	var saldo
	var localidadDeOrigen
	var items = []
	var perfil
	
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
		if (self.estaEnlaMismaLocalidad(viaje)) {
			throw new VuelosUsuarioException(message = "Se encuentra en la misma localidad a la que quiere viajar")
		}
	}
	
	method puedeViajar(viaje){
		return saldo >= viaje.precioViaje()
	}
	
	method estaEnlaMismaLocalidad(unViaje) {
		return localidadDeOrigen.equals(unViaje.localidadFinal())
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
	method perfil()
	
}

class VuelosUsuarioException inherits Exception{}