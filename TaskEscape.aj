package ajmu;

abstract aspect TaskEscape extends TareaEvent{
	/**
	 * POINTCUT condicionNoFinaliza()
	 * Captura el cierre de la aplicación cuando la tarea aún no finaliza
	 */
	abstract pointcut NoFinaliza();
	pointcut condicionNoFinaliza():(call(void java.lang.System.exit(..))&&!flujoFinalizacion()&&!flujoAspecto()&&tareaEnEjecucion())||(NoFinaliza()&&tareaEnEjecucion());

	/**
	 * ADVICE before()
	 * Si el cierre inesperado de la aplicación es capturado cuando la tarea aún no ha finalizado, se registra el estado de los contadores
	 * en el log a través del aspecto TareaLogger. 
	 */
	before(): condicionNoFinaliza() {	
		miTarea.setEstado("No finalizada");
		miTarea = null;
	}
}
