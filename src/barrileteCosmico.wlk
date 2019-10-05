object barrileteCosmico{
	
	var destinos = #{}
	
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
	
	method destinos() = destinos
	
}

class Destino{
	var nombre
	var equipajeImprescindible = []
	var precio
	
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
	
	method precio() = precio
	method nombre() = nombre
	method equipajeImprescindible() = equipajeImprescindible
	
	
}

class Usuario{
	var nombre
	var nombreDeUsuario
	var lugaresVisitados = #{}
	var siguiendo = #{}
	var saldo
	
	method volarA(unLugar){
		self.validarQuePuedaViajar(unLugar)	
	
		lugaresVisitados.add(unLugar) 
		saldo = saldo - unLugar.precio()
	}
	
	method validarQuePuedaViajar(unLugar) {
		if (self.puedeViajar(unLugar).negate()) {
			throw new VuelosUsuarioException(message = "No se cuenta con saldo suficiente para realizar el vuelo")	
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
		if (self.estaSiguiendoA(unUsuario).negate()) {
			siguiendo.add(unUsuario)
			unUsuario.seguirA(self)			
		}
	}
	
	method estaSiguiendoA(unUsuario) {
		return siguiendo.contains(unUsuario)
	}
	
	method realizoViajeA(unLugar){
		return lugaresVisitados.contains(unLugar)
	}
	
	method saldo() = saldo
	method lugaresVisitados() = lugaresVisitados
}

class VuelosUsuarioException inherits Exception{}