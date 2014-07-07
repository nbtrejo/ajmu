package ajmu;

abstract aspect TaskAccessDocumentation extends TareaEvent{
	/**
	 * POINTCUT accesoDocumentacion()
	 * Define el conjunto de puntos de corte que indican el acceso a documentacion del sistema, disponible para usuario.
	 */
	abstract pointcut accesoDocumentacion();
	
	pointcut condicionAccesoDocumentation(): accesoDocumentacion()&&tareaEnEjecucion();
	/**
	 * ADVICE before()
	 * Si la tarea se encuentra en ejecución, es decir que existe un objeto miTarea que aún no se ha completado, entonces
	 * contabiliza los accesos a la documentación.  
	 */
	before(): condicionAccesoDocumentation(){
		miTarea.setCantAccesosDocumentacion();
	}
}
