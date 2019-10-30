import barrileteCosmico.*
object empresarial{
	method transportePreferido(_, __){
		return barrileteCosmico.elTransporteMasRapido()
	}
}
object estudiantil{
	method transportePreferido(usuario, destino){
		return usuario.transportesQuePuedeCostear(destino).min{
			transporte => 
				transporte.minutosKm()
		}
	}
	
}
object grupoFamiliar{
	method transportePreferido(_, __){
		return barrileteCosmico.loImportanteEsLaFamilia()
	}
}
