import conocimientos.*
import participantes.*
import paises.*

object cumbre {
	const auspiciantes = #{}
	const participantes = #{}
	var minimoDeCommits = 300
	var esSegura = true
	const actividades = []
	
	method auspiciantes() = auspiciantes
	method participantes() = participantes
	method minimoDeCommits() = minimoDeCommits
	method esSegura() = esSegura
	method actividades() = actividades
	
	method agregarAuspiciante(unAuspiciante) {auspiciantes.add(unAuspiciante)}
	method agregarParticipante(unParticipante) {
		if (!self.puedeEntrar(unParticipante)){
			self.error("No puede entrar")
			esSegura = false
			}
		participantes.add(unParticipante)
	}
	method cambiarMinimoDeCommits(unaCantidad) {minimoDeCommits = unaCantidad}
	
	method esConflictivo(unPais) = !unPais.conflictoCon().intersection(auspiciantes).isEmpty()
	method paisesDeLosParticipantes() = participantes.map({participante => participante.pais()}.asSet())
	method cantidadDeParticipantesDe(unPais) = participantes.count({participante => participante.pais() == unPais})
	method paisConMasParticipantes() = self.paisesDeLosParticipantes().max({pais => self.cantidadDeParticipantesDe(pais)})
	method participantesExtranjeros() = participantes.filter({participante => !auspiciantes.contains(participante.pais())})
	method esRelevante() = participantes.all({participante => participante.esCape()})
	method restrigeElAcceso(unParticipante) = self.esConflictivo(unParticipante.pais()) or !self.puedeEntrarExtranjero(unParticipante)
	method puedeEntrarExtranjero(unParticipante) = if (unParticipante.esExtranjero(self)) {self.participantesExtranjeros().size()<2} else false
	method puedeEntrar(unParticipante) = unParticipante.puedeParticipar(self) and !self.restrigeElAcceso(unParticipante)
	method realizarActividad(unParticipante, unaActividad, tiempo){
		actividades.add([unParticipante, unaActividad, tiempo])
		unParticipante.hacerActividad(unaActividad, tiempo)		
	}
	method totalDeHorasDeActividades() = actividades.sum({actividad => actividad.get(2)})
}