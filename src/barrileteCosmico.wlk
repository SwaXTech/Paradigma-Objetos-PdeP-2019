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
		return unUsuario.transportePreferido(unDestino)
	}
	
	method elTransporteMasRapido(){
		return mediosDeTransporte.min{
			transporte => 
				transporte.minutosKm()
		}
	}
	
	method loImportanteEsLaFamilia(){
		return mediosDeTransporte.anyOne()
	}

	method mediosDeTransporte() = mediosDeTransporte
	method localidades() = localidades
	
}
