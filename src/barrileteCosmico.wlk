object barrileteCosmico{
	
	var destinos = #{}
	
	method destinosMasImportantes() {
		return destinos.filter{
			destino =>
				destino.esImportante()
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
	
	// Para el test
	method destinosPeligrosos() {
		return destinos.filter{
			destino => 
				destino.esPeligroso()
		}
	}
	
	method agregarDestino(unDestino) {
		destinos.add(unDestino)
	}
	
	method destinos() = destinos
	
}

class Destino{
	var nombre
	var equipajeImprescindible = []
	var precio
	
	method esImportante() {
		return precio > 2000
	}
	
	method aplicarDescuento(unDescuento) {
		precio *= (100 - unDescuento) / 100
		equipajeImprescindible.add("Certificado de descuento")	
	}
	
	method esPeligroso() {
		return equipajeImprescindible.any{
			equipaje =>
				equipaje.toLowerCase().contains("vacuna")
		}
	}

	method nombre(unNombre){
		nombre = unNombre
	}
	
	method precio() = precio
	method equipajeImprescindible() = equipajeImprescindible
	
}

class Usuario{
	var nombre
	var nombreDeUsuario
	var lugaresVisitados = #{}
	var siguiendo = #{}
	var saldo
	
	method volarA(unLugar){
		if(self.puedeViajar(unLugar)){
			lugaresVisitados.add(unLugar) 
			saldo = saldo - unLugar.precio() 
			return true
		} else {
			return false
		}
	}
	
	method puedeViajar(unLugar){
		return saldo >= unLugar.precio()
	}
	
	method obtenerKM(){
		return self.sumaDePreciosDeLosDestinos() * 0.10
	}
	
	method sumaDePreciosDeLosDestinos() {
		return lugaresVisitados.sum({ 
			lugarVisitado => 
				lugarVisitado.precio()})
	}
	
	method seguirA(unUsuario){
		siguiendo.add(unUsuario) 
		unUsuario.seguirA(self)
	}
	
	method saldo() = saldo
	method lugaresVisitados() = lugaresVisitados
}