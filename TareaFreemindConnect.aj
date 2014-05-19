/**
* PROYECTO DE INVESTIGACIÓN: USABILIDAD Y AOP
* CÓDIGO: PI315
*/
package ajmu;

import java.awt.event.ActionEvent;

public aspect TareaFreemindConnect extends TareaConnect{
	
	pointcut inicializacion():execution(void freemind.modes.common.actions.NewMapAction.actionPerformed(ActionEvent));
	
	before(): inicializacion(){
		if (!iniciada) {
			
			miTarea = new Tarea("Tarea: Creación de Mapa Conceptual con 5 nodos");
			
		}
	}
	
	pointcut finalizacion():execution(* freemind.modes.ControllerAdapter.SaveAsAction.*(..))||execution(* freemind.modes.ControllerAdapter.SaveAction.*(..));
	
	pointcut accesoDocumentacion():execution(void freemind.controller.Controller.DocumentationAction.actionPerformed(ActionEvent));
	
	
	
}
