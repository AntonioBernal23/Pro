function agregarClase(id) {
    let url = "/AgregarClase?id=" + encodeURIComponent(id);
    
    window.open(url, "_blank", "width=600,height=400,resizable=yes,scrollbars=yes");
}