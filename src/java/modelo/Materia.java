package modelo;

public class Materia {

    private int id;
    private String nombre;
    private String codigo;
    private String cupos;
    private String descripcion;
    private String dia;
    private String hora_comienzo;
    private String hora_fin;

    @Override
    protected void finalize() throws Throwable {
        super.finalize(); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }

    public Materia(int id, String nombre, String codigo, String cupos, String descripcion, String dia, String hora_comienzo, String hora_fin) {
        this.id = id;
        this.nombre = nombre;
        this.codigo = codigo;
        this.cupos = cupos;
        this.descripcion = descripcion;
        this.dia = dia;
        this.hora_comienzo = hora_comienzo;
        this.hora_fin = hora_fin;

    }

    public Materia(String nombre, String codigo, String cupos, String descripcion, String dia, String hora_comienzo, String hora_fin) {
        this.nombre = nombre;
        this.codigo = codigo;
        this.cupos = cupos;
        this.descripcion = descripcion;
        this.dia = dia;
        this.hora_comienzo = hora_comienzo;
        this.hora_fin = hora_fin;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getCupos() {
        return cupos;
    }

    public void setCupos(String cupos) {
        this.cupos = cupos;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getDia() {
        return dia;
    }

    public void setDia(String dia) {
        this.dia = dia;
    }

    public String getHora_comienzo() {
        return hora_comienzo;
    }

    public void setHora_comienzo(String hora_comienzo) {
        this.hora_comienzo = hora_comienzo;
    }

    public String getHora_fin() {
        return hora_fin;
    }

    public void setHora_fin(String hora_fin) {
        this.hora_fin = hora_fin;
    }

}
