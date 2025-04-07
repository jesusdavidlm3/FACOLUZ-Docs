antecedentesMedicos = {
    //Cardiovascular
    hipertensionArterial: null || true,
    enfermedadcoronaria: false || true,
    infartos: false || true,
    insuficienciaCardiaca: false || true,
    arritmiasCardiacas: false || true,
    valvulopatias: false || true,
    
    //Metabolico
    resistenciaInsulina: false || true,
    diabetes: false || true,

    //Respiratoria
    asma: false || true,
    apneaSueno: false || true,
    dificultadRespiratoria: false || true,

    //Gastroinstetinal/Hepatico
    hepatitis: false || true, //Agregar Texto
    ulcerasGastricas: false || true,
    gastritis: false || true,
    reflujoGastroesofalico: false || true,
    
    //Hematologico
    anemia: false || true,
    leucemia: false || true,
    trastornosCoangulacion: false || true,
    transfusionesSanguineas: false || true,
    
    //Endocrino
    enfermedadTiroidea:false || true, //Agregar Texto

    //Infectocontagiosas
    vih: false || true,
    vph: false || true,
    herpes: false || true,
    sifilis: false || true,
    tuberculosis: false || true,

    //Neurologico
    epilepsias: false || true,
    parkinson: false || true,
    alzheimer: false || true,
    migranasFrecuentes: false || true,

    //Osteomuscular
    esclerosisMultiple: false || true,
    osteoporosis: false || true,

    otros: null || 'string', //Agregar texto

    reaccionAnestesiaGeneral: null || 'string',
    alergicoMedicamentoAlimento: null || 'string',
    cancer: null || {
        localizacion: 'string',
        tipo: 'string',
        anoDx: int,
        tipoTratamiento: 'string',
    },

    //Pacientes Femeninos
    periodoMestrual: 'Normal' || 'Abundante' || 'Poco' || 'Ausente'
}

antecedentesFamiliares = 'string'

antecedentesOdontologicos = {
    visitaOdontologo: 'Urgencia' || 'Primera vez' || ['Periodicamente', int],
    tratamientosRealizados: 'string',
    reaccionAnestesiaLocal: null || 'string',
    habitos: {
        //Bucales
        deglucionAtipica: false || true,
        succionDigital: false || true,
        succionLabialSup: false || true,
        succionLabialInf: false || true,
        succionLingual: false || true,
        respitacionBucal: false || true,
        onicotagia: false || true,
        bruxismo: false || true,
        posicional: false || true,


        //Actividades
        tabaquismo: null || Int,
        vapeo: null || int,
        drogas: null || int,
        alcohol: null || int,
        otro: null || ['string', int],
    },

    //Padecimientos
    padecimiento: 'Resequedad' || 'Ulceraciones' || 'Dolor' || 'Mal Sabor' || 'string',
}

tratamientoPrimeraVisita = {
    dosis: int,
    frecuencia: int,
    visitaMedico: null || 'string',
    tratamientoBifosfonato: null || 'string'
}

examenFisico = {
    cara: 'string',
    ganglios: 'string',
    atm: 'string',
    muscMasticarios: 'string',
}

examenintraOral = {
    labios: 'string',
    mucosaOral: 'string',
    paladarDuro: 'string',
    paladarBlando: 'string',
    lengua: 'string',
    pisoBoca: 'string',
    glandulasSalivales: 'string',
    
    //Encias
    encias: {
        //Acomodar segun el cuadro en las historias
        color: 'Rosado Coral' || 'Rojo Intenso' || 'Rojo Violáceo' || 'Pigmentado',
        sss: 'Marginal y papilar' || 'Difuso',
        lugar: 'Generalizado' || ['Localizado', 'string'],
        tamano: 'Leve' || 'Moderado' || 'Severo',
        textura: 'Puntillado' || 'Leve perdida de Puntillado' || 'Moderada perdida de Puntillado' || 'Exagerada perdida de Puntillado',
        consistencia: 'Firme' || 'Blanda y depresible' || 'Fibrosa',
        posicion: 'Apical' || 'Coronal',
        forma: 'Festoneada' || 'Perdida del Festoneado Leve' || 'Perdida del Festoneado Moderada' || 'Perdida del Festoneado Exagerada' || 'Irregular',
        

    },

    //Irritantes Locales
    biopelicula: 'Ausente' || 'Escaso' || 'Moderado' || 'Abundante',
    calculoDental: 'Ausente' || 'Escaso' || 'Moderado' || 'Abundante',

    //Exudado
    saguineo: 'string',
    purulente: 'string',
    seroso: 'string',

    otrasObservaciones: 'string',
}

examenRadiografico = {
    //Imagenes en los maxilares
    radiolucidos: null || ['string', int],
    radiopacos: null || ['string', int],

    nivelOseo:{
        tipo: 'Horizontal' || 'Vertical',
        localizacion: 'Generalizado' || ['Localizado','string'],
        continuidadLaminaDura: 'string',
    },
    periapicalesAisladas: {
        od: int,
        rl: 'string',
        ro: 'string',
        EspLigamentoPeriodontal: 'string',
        interpretacion: 'string',
    }
}

diagnostico = {
    diagnostico: 'string',
    etiologia: 'string',
}

pronostico = {
    observacion: 'Bueno' || 'Reservado' || 'Malo',
    pacienteAltoRiesgo: true || false,
    interpretacion: 'string',
}

planes = {
    preventivo: 'string',
    tratamiento: {
        urgencia: 'string',
        higienica: 'string',
        curativa: 'string',
        rehabilitacion: 'string',
        mantenimiento: 'string',
    }
}


