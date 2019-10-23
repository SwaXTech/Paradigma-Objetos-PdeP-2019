import usuario.*
import medioDeTransporte.*
import viaje.*
import localidad.*

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
	
	method armarUnViaje(usuario, destino){
		return new Viaje(localidadInicial = usuario.localidadDeOrigen(), localidadFinal = destino, medioDeTransporte = mediosDeTransporte.anyOne())
	}
	
	method mediosDeTransporte() = mediosDeTransporte
	method localidades() = localidades
