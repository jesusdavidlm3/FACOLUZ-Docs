padecimientos = {
	afeccionCardiobascular: null || 'string',
	afeccionesEmatologicas: null || 'string',
	afeccionRenal: null || 'string',
	afeccionNeurologica: null || 'string',
	afeccionesHepaticas: null || 'string',
	diabetes: null || 'string',
	trastornosGastrointestinales: null || 'string',
	herpes: null || 'string',
	VPH: null || 'string',
	ETS: null || 'string',
	causaHospitalizacion:  null || 'string',
	causaintervencionQuirurgica:  null || 'string',
	alergiaMedicamentos:  null || 'string',	
}
antecedentes = {
	alergiaMedicamento: true || false,
	alergiaMedicamentoDescripcion: null || 'string',
	efectosAnestesia: 'Si', 'No', 'No sabe'
	cicloMestrual: 'Normal', 'Anormal', 'Menopausia', 'No aplica',
	embarazo: true || false,
	semanasEmbarazo: null || int,
	lactancia: true || false,
	visitaAlOdontologoPor: 'Emergencia', 'Primera vez', 'Periodicamente',
	recibioTratamientoPeriodontal: true || false,
	descripcionTratamientoPeriodontal: null || 'string',
	fechaTratamientoPeriodontal: null || Date,
	personaDeAltoRiesgo: true || false,
	antyecedentesFamiliares: null || 'string'
}

habitos = {
	tabaco: true || false,
	tabacoCantidad: null || int,
	morderseLasUñas: true || false,
	morderseLosLabios: true || false,
	morderseLasMejillas: true || false,
	respiracionBucal: true || false,
	morderObjetos: true || false,
	otros: true || false,
	cual: null || 'string'
}

examenFisico = {
	cabeza: 'string',
	cara: 'string',
	cuello: 'string',
	otros: 'string',
}

examenIntraOral = {
	carrillos: 'string',
	lengua: 'string',
	pisoDeBoca: 'string',
	insercionFrenillos: 'string',
	regionOrofaringea: 'string',
	otros: 'string',
}

evaluacionDeEncia = {
	color: 'string',
	textura: 'string',
	consistencia: 'string',
	tamaño: 'string',
	forma: 'string',
	posicion: 'string',
	placa bacteriana: 'Ausente' || 'Escaso' || 'Moderado' || 'Abundante',
	exudadoHemorragico: true || false,
	exudadoSeroso: true || false,
	exudadoPurulento: true || false,
	tipoDeExudado: 'Espontaneo' || 'Provocado',
	calculoDentalSupraGingival: 'Ausente' || 'Escaso' || 'Moderado' || 'Ausente',
	subGingival: 'Ausente' || 'Escaso' || 'Moderado' || 'Ausente',
	bolsasPeriodontales: 'Supraoseas' || 'Infraoseas' || 'Falsas'
}

 dentalDiagram.lenght(32): JSON = {[{
 	pSondaje: int || null,
 	nInsercion: ? ||null,
 	inPlaca: ? || null,
 	inSangrado: true || false,
 	position: int (0, 0, 0, 0, 0),
 	retraccion: 1 || 2 || 3 || 4 || 5 || 6 || 7 || 8,
 	retraccionDescripcion: 
}]}

 childrenDentalDiagram.lenght(20): JSON = {[{
 	cavityPosition: int (0, 0, 0, 0, 0),
 	
 }]}