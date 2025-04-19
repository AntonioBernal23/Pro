function agregarClase(id) {
    let url = "/AgregarClase?id=" + encodeURIComponent(id);
    
    window.open(url, "_blank", "width=600,height=400,resizable=yes,scrollbars=yes");
}

console.log("JS cargado correctamente");

function mostrarPopup(nombre, id, maestro) {
    console.log("Mostrando popup:", id, nombre);
    document.getElementById("popup-title").innerText = nombre;
    document.getElementById("popup-id").innerText = id;
    document.getElementById("popup-maestro").innerText = maestro;
    document.getElementById("popup").classList.remove("popup-hidden");
}

function cerrarPopup() {
    console.log("Cerrando popup");
    document.getElementById("popup").classList.add("popup-hidden");
}
