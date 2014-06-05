/**
* 
* PROYECTO DE INVESTIGACIÓN
* USABILIDAD & AOP: DESARROLLO Y EVALUACIÓN DE UN FRAMEWORK DE DOMINIO.
* (2014-2015)
* CÓDIGO: 29/A315
* 
* MÁS INFORMACIÓN EN {@link https://sites.google.com/site/profeprog/proyecto5}
* 
*/
package ajmu;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public aspect TareaLogger {
	
	private static final Logger loggerTarea = LoggerFactory.getLogger(Tarea.class);
	private static final Logger loggerEventos = LoggerFactory.getLogger(Logger.class);
	
	pointcut registrarInicio(Tarea t):initialization(Tarea.new(String))&&this(t);
	
	after(Tarea t): registrarInicio(t){
		loggerTarea.info("===================== INICIO TAREA: "+ t.getDescripcion() +" =========================");
		loggerTarea.info("La tarea id " + t.getId() + " ha sido iniciada.");
	}
	
	pointcut registrarDatos(Tarea t):execution(void Tarea.finaliza(..))&&this(t);
	
	after(Tarea t): registrarDatos(t){
		loggerTarea.info("================= RESULTADOS FINALES ====================");
		loggerTarea.info("La tarea id " + t.getId() + " ha finalizado");
		loggerTarea.info("Tiempo de ejecución: " + t.tiempoDeEjecucion() + "ms" + "("+ t.tiempoDeEjecucionSeg() +")");
		loggerTarea.info("Excepciones gestionadas: " + t.getCantExcepciones());
		loggerTarea.info("Diálogos mostrados: " + t.getCantDialogos());
		loggerTarea.info("Accesos a la documentación: " + t.getCantAccesosDocumentacion());
		loggerTarea.info("Mensajes sin icono: " + t.getCantMensajesSinIcono());
		loggerTarea.info("Mensajes de error: " + t.getCantMensajesIconoError());
		loggerTarea.info("Mensajes de advertencia: " + t.getCantMensajesIconoAdvertencia());
		loggerTarea.info("Mensajes informativos: " + t.getCantMensajesIconoInformativo());
		loggerTarea.info("Mensajes interrogativos: " + t.getCantMensajesIconoPregunta());
		loggerTarea.info("Sastifaccion: " + t.getGradoSatisfaccion());
	}
	
	pointcut deteccionEventos(Tarea t): execution(void Tarea.setCant*(..))&&this(t);
	
	after(Tarea t): deteccionEventos(t){
		loggerTarea.info("================= RESULTADOS PARCIALES ====================");
		loggerTarea.info("Tarea id " + t.getId() + " / Estado: En ejecución");
		loggerTarea.info("Excepciones gestionadas: " + t.getCantExcepciones());
		loggerTarea.info("Diálogos mostrados: " + t.getCantDialogos());
		loggerTarea.info("Accesos a la documentación: " + t.getCantAccesosDocumentacion());
		loggerTarea.info("Mensajes sin icono: " + t.getCantMensajesSinIcono());
		loggerTarea.info("Mensajes de error: " + t.getCantMensajesIconoError());
		loggerTarea.info("Mensajes de advertencia: " + t.getCantMensajesIconoAdvertencia());
		loggerTarea.info("Mensajes informativos: " + t.getCantMensajesIconoInformativo());
		loggerTarea.info("Mensajes interrogativos: " + t.getCantMensajesIconoPregunta());
		
	}
	public void grabar(String reg){
		loggerEventos.info("<==> "+reg);
	}
}
