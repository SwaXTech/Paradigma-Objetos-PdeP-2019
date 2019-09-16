object barrileteCosmico{
	
	var destinos = #{}
	
	method destinos() {
		return destinos
	}
	
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
	
	method cartaDeDestinos() {
		
	}
	
	method agregarDestino(unDestino) {
		destinos.add(unDestino)
	}
	
}

class Destino{
	var property nombre
	var property equipajeImprescindible = []
	var property precio
	
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
}

class Usuario{
	var property nombre
	var property nombreDeUsuario
	var property lugaresVisitados = #{}
	var siguiendo = #{}
	var property saldo
	
	method volarA(unLugar){
		if(self.puedeViajar(unLugar)){
		lugaresVisitados.add(unLugar) 
		saldo = saldo - unLugar.precio() 
		return true
		}
		else{
			return false
		}
	}
	
	//method descontar(unLugar){
	//	saldo = saldo 
	//}
	
	method puedeViajar(unLugar){
		return saldo >= unLugar.precio()
	}
	
	method obtenerKM(){
		return lugaresVisitados.sum({ lugarVisitado => 
			lugarVisitado.precio()}) * 0.10
	}
	
	method seguirA(unUsuario){
		siguiendo.add(unUsuario) 
		unUsuario.seguirA(self)
	}
}