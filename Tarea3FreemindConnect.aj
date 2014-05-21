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

import java.awt.event.ActionEvent;

public aspect Tarea3FreemindConnect extends TareaConnect{
	
	pointcut inicializacion():execution(void freemind.modes.ControllerAdapter.OpenAction.actionPerformed(ActionEvent));
	
	before(): inicializacion(){
		if (!iniciada) {
			
			miTarea = new Tarea("Tarea: Abrir un mapa existente y editarlo");
			
		}
	}
	
	pointcut finalizacion():execution(* freemind.modes.ControllerAdapter.SaveAsAction.*(..))||execution(* freemind.modes.ControllerAdapter.SaveAction.*(..));
	
	pointcut accesoDocumentacion():execution(void freemind.controller.Controller.DocumentationAction.actionPerformed(ActionEvent));
	
	
	
}
