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
	
	
	method medioDeTransporte(unTransporte){
		medioDeTransporte = unTransporte
	}
	
	method equipajeObligatorio(){
		return localidadFinal.equipajeImprescindible()
	}
	
	method localidadInicial() = localidadInicial
	method localidadFinal() = localidadFinal
}