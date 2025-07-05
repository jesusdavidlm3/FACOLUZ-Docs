Revisar:
========
* Como organizar evaluacion de las encias?
* consultations y citas tienen ambas patientId, deberia eliminarse?
* asignar ancho maximo a seleccion de padecimientos en las historias.
* La hepatitis se cura? debe ir en citas o en pacientes?
* Habitos dieteticos en historia de niños varian segun consulta? o van a historia? son modificables?
    * Esto podria aplicar una solusion similar al campo de propenso al sangrado
* En la base de datos en consultas hay un campo de tratamiento, es el tratamiento medico actual o el que se le recetara?
    * Tambien estan pronostico general e individual, cual es la diferencia? ambos son necesarios?
    * En la misma tabla existen physical test y fisical Examination, son lo mismo?
    * Revisar Historia, que es:
        * OculusionExamination.
        * Pulp Vitality.
        * Examenes complementarios.

Tareas pendientes:
==================
* Definir la lista de opciones para el estado de un diente en el odontograma
* Codificar la estructura del JSON para el odontograma

Como resolver:
==============
* Cuando el paciente llega por primera vez
    * Al obtener la histoia traemos las consultas a las que ah asistido, si no tiene ninguna es primera vez que va, pedir datos de primera vez

* Cuando actualizar los datos del paciente?
    * Los datos socio economico se preguntan al agendar cita y datos medicos durante la consulta.

* Hay datos que puedan cambiar en cualquier momento como propenso al sangrado?
    * Incluirlo siempre en el formulario de consulta pero con el valor actual como predeterminado (Se llevara registro o solo el actual se almacenara?)