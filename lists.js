export function searchOnList(list, id){
    return list.find(item => item.value == id).label
}

export const instructionGradeList = [
    {label: 'Ninguno', value: 1},
    {label: 'Prescolar', value: 2},
    {label: 'Primaria', value: 3},
    {label: 'Bachillerato', value: 4},
    {label: 'Universitario', value: 5},
    {label: 'Postgrado', value: 6},
]

export const bloodTypeList = [
    {label: 'A+', value: 1},
    {label: 'A-', value: 2},
    {label: 'B+', value: 3},
    {label: 'B-', value: 4},
    {label: 'AB+', value: 5},
    {label: 'AB-', value: 6},
    {label: 'O+', value: 7},
    {label: 'O-', value: 8},
]

export const sexList = [
    {label: 'Masculino', value: 1},
    {label: 'Femenino', value: 2}
]

export const identificationList = [
    {label: 'V', value: 1},
    {label: 'E', value: 2},
    {label: 'Cod.', value: 3},
]

export const trueFalseList = [
    {label: 'Si', value: true},
    {label: 'No', value: false},
]

export const raceList = [
    {label: 'Blanco', value: 1},
    {label: 'Negro', value: 2},
    {label: 'Moreno', value: 3},
    {label: 'Indigena', value: 4},
]

export const alimentsList = [
    {label: 'Adenopatias', value: 0},
    {label: 'Afeccion cardiovascular', value: 1},
    {label: 'Afecciones hematologicas', value: 2},
    {label: 'Afeccion renal', value: 3},
    {label: 'Afeccion neurologica', value: 4},
    {label: 'Afeccion hepatica', value: 5},
    {label: 'Diabetes', value: 6},
    {label: 'Trastornos gastrointestinales', value: 7},
    {label: 'Fiebre reumatica', value: 8},
    {label: 'Asma', value: 9},
    {label: 'Cefaleas frecuentes', value: 10},
    {label: 'Herpes', value: 11},
    {label: 'VIH', value: 12},
    {label: 'VPH', value: 13},
    {label: 'ETS', value: 14},
    {label: 'Perdida de peso', value: 15},
    {label: 'Convulsiones', value: 16},
    {label: 'Sindrome Genetico', value: 17},
    {label: 'Retraso mental', value: 18},
    {label: 'Trastornos auditivos o de habla', value: 19},
    {label: 'Trastorno respiratorio', value: 20},
    {label: 'Alergias a medicamentos', value: 21},
    {label: 'Enfermedades infectocontagiosas', value: 22},
    {label: 'Afecciones O.R.L.', value: 23},
    {label: 'Dificultades de aprendizaje', value: 24},
]

export const userTypeList = [
    {label: 'Administrador de sistemas', value: 0},
    {label: 'Docente', value: 1},
    {label: 'Estudiante', value: 2},
    {label: 'Administrador de estudios', value: 3},
]

export const dateStatus = [
    {label: 'Pendiente', value: 1},
    {label: 'Atendida', value: 2},
    {label: 'Cancelada', value: 3},
]

export const relationshipType = [
    {label: 'Madre', value: 1},
    {label: 'Padre', value: 2},
    {label: 'Abuelo/a', value: 4},
    {label: 'Hermano/a', value: 5},
    {label: 'Nieto/a', value: 6},
    {label: 'Hijo/a', value: 7},
    {label: 'Esposo/a', value: 8},
    {label: 'Tio/a', value: 9},
    {label: 'Sobrino/a', value: 10},
    {label: 'Otros', value: 11},
]

export const listOfThree = [
    {label: 'Si', value: 1},
    {label: 'No', value: 2},
    {label: 'No Sabe', value: 3}
]

export const homeOwnership = [
    {label: 'Familiar', value: 1},
    {label: 'Propia', value: 2},
    {label: 'Alquilada', value: 3},
]

export const ethnicityList = [
    {label: "Wayuu", value: 1},
    {label: "Añu", value: 2},
    {label: "Bari", value: 3},
    {label: "Yukpa", value: 4},
    {label: "Japreria", value: 5},
    {label: "Otros", value: 6},
]