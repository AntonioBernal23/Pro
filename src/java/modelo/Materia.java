package modelo;

public class Materia {

    private int id;
    private String nombre;
    private String codigo;
    private String descripcion;
    private String dia;
    private String hora;

    public Materia(int id, String nombre, String codigo, String descripcion, String dia, String hora) {
        this.id = id;
        this.nombre = nombre;
        this.codigo = codigo;
        this.descripcion = descripcion;
        this.dia = dia;
        this.hora = hora;

    }

    public Materia(String nombre, String codigo, String descripcion) {
        this.nombre = nombre;
        this.codigo = codigo;
        this.descripcion = descripcion;
        this.dia = dia;
        this.hora = hora;
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

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

}
