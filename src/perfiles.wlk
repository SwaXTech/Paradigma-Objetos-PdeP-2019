import barrileteCosmico.*
object empresarial{
	method transportePreferido(_, __){
		return barrileteCosmico.elTransporteMasRapido()
	}
}
object estudiantil{
	method transportePreferido(usuario,destino){
		return usuario.elTransporteMasRapido(destino)
	}
	
}
object grupoFamiliar{
	method transportePreferido(_, __){
		return barrileteCosmico.loImportanteEsLaFamilia()
	}
}
