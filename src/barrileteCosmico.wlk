object barrileteCosmico{
	
	var destinos = #{}
	
	method destinosMasImportantes(){
		return destinos.filter{
			destino =>
				destino.precio() > 2000
		}
	}
	
	method aplicarDescuento(unDescuento){
		
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