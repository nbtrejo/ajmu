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

abstract aspect TareaConnect {

	static boolean connectOcupado = false;
	boolean iniciada	= false;	
	Tarea miTarea = null;
	int nroEvento = 0;
	int nroDialogo	= 0;
	static TareaMonitoreo monitor = null;
	
	/**
	 * POINTCUT inicializacion()
	 * Define el conjunto de puntos de corte que marcan el inicio de la tarea cuya usabilidad se desea estudiar.
	 */
	abstract pointcut inicializacion();
	/**
	 * ADVICE before()
	 * Si la tarea aún no ha iniciado, cambia el estado del atributo iniciada a true, crea un objeto de la clase
	 * TareaMonitoreo y activa el ciclo de control sobre la tarea miTarea. 
	 */
	before(): inicializacion(){
		if(!connectOcupado){
			if (!iniciada) {
				iniciada = true;
				connectOcupado = true;
				monitor = new TareaMonitoreo(miTarea);
				monitor.start();
			}
		}
	}
	
	/**
	 * POINTCUT finalizacion()
	 * Define el conjunto de puntos de corte que marcan el fin de la tarea cuya usabilidad se desea estudiar.
	 */
	abstract pointcut finalizacion();
	/**
	 * ADVICE after() returning.
	 * Si la tarea se encuentra iniciada cuando alguno de los joinpoints es capturado, entonces cambia el estado
	 * de la tarea a finalizada e inicializa los atributos del aspecto.  
	 */	 
	after() returning: finalizacion(){
		if (iniciada) {
			miTarea.finaliza();	
			
		}
		iniciada = false;
		connectOcupado = false;
		nroEvento	= 0;
		nroDialogo	= 0;	
		miTarea = null;
	}
	/**
	 * POINTCUT accesoDocumentacion()
	 * Define el conjunto de puntos de corte que indican el acceso a documentacion del sistema, disponible para usuario.
	 */
	abstract pointcut accesoDocumentacion();
	/**
	 * ADVICE before()
	 * Si la tarea se encuentra en ejecución, es decir que existe un objeto miTarea que aún no se ha completado, entonces
	 * contabiliza los accesos a la documentación.  
	 */
	before(): accesoDocumentacion(){
		if((miTarea!=null)&&(!miTarea.isCompleta())){	
			miTarea.setCantAccesosDocumentacion();
		}
	}
	
	
}
