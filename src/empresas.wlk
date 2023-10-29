class Empresa {
	const paises = []
	
	method paises() = paises
	method agregarPais(unPais) = paises.add(unPais) 
	method esMultinacional() = paises.size() >= 3
}