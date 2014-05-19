/**
* PROYECTO DE INVESTIGACIÓN: USABILIDAD Y OAP
* CÓDIGO: PI315
*/
package ajmu;

import java.rmi.server.ObjID;

public class Tarea {
	//private long id;
	private ObjID id;
	private boolean completa;
	private Long inicializacion,finalizacion;
	private int cantExcepciones;
	private String descripcion;
	//para ventanas de dialogo
	private int cantDialogos;
	private int cantAccesosDocumentacion;
	//mensajes por tipo de icono
	private int cantMensajesSinIcono;
	private int cantMensajesIconoError;
	private int cantMensajesIconoInformativo;
	private int cantMensajesIconoAdvertencia;
	private int cantMensajesIconoPregunta;
	private String gradoSatisfaccion;
    
	public Tarea(String desc) {
		
		//id = this.hashCode();
		id	= new ObjID();
		completa = false;
		inicializacion = System.currentTimeMillis();
		finalizacion = null;
		cantExcepciones = 0;
		descripcion = desc;
		cantAccesosDocumentacion = 0;
		gradoSatisfaccion = "No sabe / No responde";
	}
	
	public String getGradoSatisfaccion() {
		return gradoSatisfaccion;
	}

	public void setGradoSatisfaccion(String gradoSatisfaccion) {
		this.gradoSatisfaccion = gradoSatisfaccion;
	}

	
	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	
	//public long getId() {
	public ObjID getId() {
		return id;
	}
	
	public boolean isCompleta() {
		return completa;
	}

	public Long getInicializacion() {
		return inicializacion;
	}

	public Long getFinalizacion() {
		return finalizacion;
	}
	
	//public void finaliza(ObjID id){
	public void finaliza(){	
			finalizacion = System.currentTimeMillis();
			completa = true;
			
	}
	
	public Long tiempoDeEjecucion(){
		return finalizacion - inicializacion;
	}
	
	public String tiempoDeEjecucionSeg(){
		Long tejecucion = finalizacion - inicializacion;
		
		Long horas = tejecucion / 3600000;
		Long restoHoras = tejecucion%3600000;
		
		Long minutos = restoHoras / 60000;
		Long restoMinutos = restoHoras%60000;
		
		Long segundos = restoMinutos / 1000;
		Long restoSegundos = restoMinutos%1000;
		
		return horas + ":" + minutos + ":" + segundos + "." + restoSegundos;
		
	}
	
	public int getCantExcepciones() {
		return cantExcepciones;
	}

	public void setCantExcepciones() {
		this.cantExcepciones++;
	}
	
	public int getCantDialogos() {
		return cantDialogos;
	}

	public void setCantDialogos() {
		this.cantDialogos++;
	}
	public int getCantAccesosDocumentacion(){
		return this.cantAccesosDocumentacion;
	}
	public void setCantAccesosDocumentacion(){
		this.cantAccesosDocumentacion++;
	}
	public void setCantMensajesSinIcono() {
		this.cantMensajesSinIcono++;
	}
	public int getCantMensajesSinIcono() {
		return this.cantMensajesSinIcono;
	}
	public void setCantMensajesIconoError() {
		this.cantMensajesIconoError++;
	}
	public int getCantMensajesIconoError() {
		return this.cantMensajesIconoError;
	}
	public void setCantMensajesIconoInformativo() {
		this.cantMensajesIconoInformativo++;
	}
	public int getCantMensajesIconoInformativo() {
		return this.cantMensajesIconoInformativo;
	}
	public void setCantMensajesIconoAdvertencia() {
		this.cantMensajesIconoAdvertencia++;
	}
	public int getCantMensajesIconoAdvertencia() {
		return this.cantMensajesIconoAdvertencia;
	}
	public void setCantMensajesIconoPregunta() {
		this.cantMensajesIconoPregunta++;
	}
	public int getCantMensajesIconoPregunta() {
		return this.cantMensajesIconoPregunta;
	} 
}
