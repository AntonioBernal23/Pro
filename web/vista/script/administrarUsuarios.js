let usuarioSeleccionado = null;
let filaSeleccionada = null;

function agregarUsuario() {
    let url = "/vista/formularios/agregarUsuario.jsp";

    negarBotones();

    // Abre una nueva ventana con el formulario de agregar usuario
    window.open(url, "_blank", "width=600,height=400,resizable=yes,scrollbars=yes");
}

function seleccionarFila(fila, id, nombre, usuario, correo, rol) {
    // Quitar la selección de la fila anterior
    if (filaSeleccionada) {
        filaSeleccionada.classList.remove("seleccionada");
    }

    // Asignar la nueva fila seleccionada
    filaSeleccionada = fila;
    filaSeleccionada.classList.add("seleccionada");

    // Guardar datos del usuario seleccionado
    usuarioSeleccionado = {id, nombre, usuario, correo, rol};

    // Mostrar botones
    document.getElementById("btnAgregar").style.display = "none";
    document.getElementById("btnActualizar").style.display = "block";
    document.getElementById("btnEliminar").style.display = "block";
    document.getElementById("btnCancelar").style.display = "block";
}

function actualizarUsuario() {
    if (usuarioSeleccionado) {
        let url = "/vista/formularios/actualizarUsuario.jsp?id=" + usuarioSeleccionado.id +
                "&nombre=" + encodeURIComponent(usuarioSeleccionado.nombre) +
                "&usuario=" + encodeURIComponent(usuarioSeleccionado.usuario) +
                "&correo=" + encodeURIComponent(usuarioSeleccionado.correo) +
                "&rol=" + encodeURIComponent(usuarioSeleccionado.rol);

        negarBotones();

        window.open(url, "_blank", "width=600,height=400,resizable=yes,scrollbars=yes");
    }
}

function confirmarEliminar() {
    let confirmar = confirm("¿Estás seguro de que deseas eliminar este elemento?");

    if (confirmar) {
        window.location.href = "/EliminarUsuario";
    }
}

function cancelarSeleccion() {
    // Ocultar botones
    document.getElementById("btnActualizar").style.display = "none";
    document.getElementById("btnCancelar").style.display = "none";

    // Remover la selección de la fila
    if (filaSeleccionada) {
        filaSeleccionada.classList.remove("seleccionada");
    }

    // Resetear variables
    usuarioSeleccionado = null;
    filaSeleccionada = null;
}

//funcion para negar botones
function negarBotones() {
    document.getElementById("btnAgregar").style.display = "none";
    document.getElementById("btnActualizar").style.display = "none";
    document.getElementById("btnEliminar").style.display = "none";
    document.getElementById("btnCancelar").style.display = "none";
}