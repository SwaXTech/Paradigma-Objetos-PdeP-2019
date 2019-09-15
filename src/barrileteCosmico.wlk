object barrileteCosmico{
	
	var destinos = #{}
	
	method destinos() {
		return destinos
	}
	
	method destinosMasImportantes(){
		return destinos.filter{
			destino =>
				destino.esImportante()
		}
	}
	
	method aplicarDescuento(unDescuento){
		destinos.forEach{
			destino => 
				destino.aplicarDescuento(unDescuento)
		}
	}
	
	method esEmpresaExtrema(){
		
	}
	
	method cartaDeDestinos(){
		
	}
	
	method agregarDestino(unDestino){
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
}

class Usuario{
	var nombre
	var nombreDeUsuario
	var conoce = #{}
	var siguiendo = #{}
	var saldo
	
	method volarA(unLugar){
		
	}
	
	method obtenerKM(){
		
	}
	
	method seguirA(unUsuario){
		
	}
}