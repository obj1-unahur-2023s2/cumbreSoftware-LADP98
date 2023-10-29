class Pais {
	const conflictoCon = #{}
	method conflictoCon() = conflictoCon
	
	method registrarConflictoCon(unPais){
		conflictoCon.add(unPais)
		unPais.conflictoCon().add(self)
	}
}