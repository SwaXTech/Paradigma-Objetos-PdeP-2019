import usuario.*
import medioDeTransporte.*
import viaje.*
import localidad.*
import perfiles.*

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
				localidad.poseeItem("Certificado de descuento");
		}
	}
	
	method cartaDeLocalidades(){
		return localidades.map{
			localidad => 
				localidad.nombre()
		}.asSet()
	}
	
	method armarUnViaje(usuario, destino, transporte){
		return new Viaje(localidadInicial = usuario.localidadDeOrigen(), localidadFinal = destino, medioDeTransporte = transporte)
	}
	
	method armarUnViaje(usuario, destino){
		return self.armarUnViaje(usuario, destino, self.transporteSegunPerfil(usuario, destino))
	}
	
	
	
	method transporteSegunPerfil(unUsuario, unDestino){
		if(self.perfilEmpresarial(unUsuario)){
			return self.elTransporteMasRapido()
		} else if(self.perfilEstudiantil(unUsuario)){
			return self.elTransporteMasRapidoSegunPresupuesto(unUsuario, unDestino)
		} else {
			return mediosDeTransporte.anyOne()
		}
	}
	
	method perfilEstudiantil(unUsuario) {
		return unUsuario.perfil().equals(estudiantil)
	}
	
	method perfilEmpresarial(unUsuario) {
		return unUsuario.perfil().equals(empresarial)
	}
	
	method elTransporteMasRapido(){
		return mediosDeTransporte.min{
			transporte => 
				transporte.minutosKm()
		}
	}
	
	method elTransporteMasRapidoSegunPresupuesto(usuario, destino){
		return self.transportesQuePuedeCostear(usuario, destino).min{
			transporte => 
				transporte.minutosKm()
		}
	}
	
	method transportesQuePuedeCostear(usuario, destino){
		return mediosDeTransporte.filter{
			transporte => 
				usuario.puedeCostear(
					self.armarUnViaje(usuario, destino, transporte)
				)
		}
	}
	
	
	
	
	method mediosDeTransporte() = mediosDeTransporte
	method localidades() = localidades
	
}
