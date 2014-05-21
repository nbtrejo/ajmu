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

public aspect Tarea1FreemindConnect extends TareaConnect{
	
	pointcut inicializacion():execution(void freemind.modes.common.actions.NewMapAction.actionPerformed(ActionEvent));
	
	before(): inicializacion(){
		if (!iniciada) {
			
			miTarea = new Tarea("Tarea: Creación de Mapa Conceptual con 5 nodos");
			
		}
	}
	
	pointcut finalizacion():execution(* freemind.modes.ControllerAdapter.SaveAsAction.*(..))||execution(* freemind.modes.ControllerAdapter.SaveAction.*(..));
	
	pointcut accesoDocumentacion():execution(void freemind.controller.Controller.DocumentationAction.actionPerformed(ActionEvent));
	
	
	
}
