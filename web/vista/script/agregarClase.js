document.addEventListener('DOMContentLoaded', function () {
    const input = document.getElementById('materiaInput');
    const datalist = document.getElementById('materias');
    const infoDiv = document.getElementById('materiaInfo');

    const tdNombre = document.getElementById('tdNombre');
    const tdCodigo = document.getElementById('tdCodigo');
    const tdCupos = document.getElementById('tdCupos');
    const tdDescripcion = document.getElementById('tdDescripcion');
    const tdDia = document.getElementById('tdDia');
    const tdHoraInicio = document.getElementById('tdHoraInicio');
    const tdHoraFin = document.getElementById('tdHoraFin');
    const materiaIdHidden = document.getElementById('materiaIdHidden');  // Asegúrate de tener este campo oculto

    input.addEventListener('input', function () {
        const materiaSeleccionada = materiasData.find(m => m.nombre === input.value);

        if (materiaSeleccionada) {
            infoDiv.style.display = 'block';

            tdNombre.textContent = materiaSeleccionada.nombre;
            tdCodigo.textContent = materiaSeleccionada.codigo;
            tdCupos.textContent = materiaSeleccionada.cupos;
            tdDescripcion.textContent = materiaSeleccionada.descripcion;
            tdDia.textContent = materiaSeleccionada.dia;
            tdHoraInicio.textContent = materiaSeleccionada.horaInicio;
            tdHoraFin.textContent = materiaSeleccionada.horaFin;

            // Actualizar el campo oculto con el id de la materia
            materiaIdHidden.value = materiaSeleccionada.id;
        } else {
            infoDiv.style.display = 'none';
            materiaIdHidden.value = '';  // Limpiar el id cuando no hay coincidencia
        }
    });

    input.addEventListener('change', function() {
        // Cuando se selecciona un valor del datalist, se busca el id
        const selectedOption = [...datalist.options].find(option => option.value === input.value);
        if (selectedOption) {
            const materiaId = selectedOption.getAttribute('data-id');
            materiaIdHidden.value = materiaId; // Asigna el id al campo oculto
        }
    });
});
