import conocimientos.*
import cumbre.*
import paises.*
import empresas.*

class Participante {
	const pais
	const conocimientos = #{}
	var cantidadDeCommits
	
	method pais() = pais
	method conocimientos() = conocimientos
	method cantidadDeCommits() = cantidadDeCommits
	
	method esCape()
	method agregarConocimiento(unConocimiento) {conocimientos.add(unConocimiento)}
	method sumarCommits(unaCantidad) {cantidadDeCommits += unaCantidad}
	method puedeParticipar(unaCumbre) = conocimientos.contains(programacionBasica)
	method esExtranjero() = !cumbre.auspiciantes().contains(self.pais())
	method hacerActividad(unaActividad, tiempo){
		self.agregarConocimiento(unaActividad)
		self.sumarCommits(tiempo*unaActividad.commitsPorHora())
	}	
}

class Programador inherits Participante {
	var horasDeCapacitacion = 0
	
	method horasDeCapacitacion() = horasDeCapacitacion
	method agregarHorasDeCapacitacion(unaCantidad) {horasDeCapacitacion += unaCantidad}
	override method esCape() = cantidadDeCommits > 500
	override method puedeParticipar(unaCumbre) = super(cumbre) and cantidadDeCommits >= cumbre.minimoDeCommits()
	override method hacerActividad(unaActividad, tiempo){
		super(unaActividad, tiempo)
		horasDeCapacitacion += tiempo
	}
}

class Especialista inherits Participante {
	
	override method esCape() = conocimientos.size() > 2
	override method puedeParticipar(unaCumbre) = super(cumbre) and cantidadDeCommits >= (cumbre.minimoDeCommits() - 100) and conocimientos.contains(objetos)
}

class Gerente inherits Participante {
	const empresa
	
	override method esCape() = empresa.esMultinacional()
	override method puedeParticipar(unaCumbre) = super(unaCumbre) and conocimientos.contains(manejoDeGrupos)
}