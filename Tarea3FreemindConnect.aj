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

/**
 * Tarea3FreemindConnect. Declara los pointcut de inicio y fin de la tarea que se define a continuación.
 * 
 * Tarea3: Abrir un mapa existente y editarlo.
 * 
 * Descripción: En esta tarea, el usuario deberá abrir un mapa ya existente, facilitado a los efectos del experimento, para su edición.
 * Para ello deberá seleccionar la opción abrir desde el menú principal o desde la barra de herramientas.
 * Una vez abierto el mapa, se le solicitará:
 * > eliminar dos nodos.
 * > agregar al menos 3 nodos hijos y 3 nodos hermanos.
 * > asignar prioridad a los nodos.
 * > cambiar el formato del nodo padre.
 * Finalmente se pedirá que guarde el mapa mental en el escritorio de su ordenador con un nombre significativo.
 * 
 * Inicio de la tarea: La tarea se considerará iniciada luego de que el usuario haya seleccionado la opción "Abrir" del 
 * menú principal o desde la barra de herramientas.
 * 
 * Fin de la tarea: La tarea se considerará finalizada luego de que el usuario guarde, por primera vez, el mapa en el escritorio.
 * 
 * @author PI-315
 *
 */

public aspect Tarea3FreemindConnect extends TareaConnect{
	
	pointcut inicializacion():execution(void freemind.modes.ControllerAdapter.OpenAction.actionPerformed(ActionEvent));
	
	before(): inicializacion(){
		if(!connectOcupado){
			if (!iniciada) {
				
				miTarea = new Tarea("Tarea: Abrir un mapa existente y editarlo");
				
			}
		}
	}
	
	pointcut finalizacion():execution(* freemind.modes.ControllerAdapter.SaveAsAction.*(..))||execution(* freemind.modes.ControllerAdapter.SaveAction.*(..));
	
	pointcut accesoDocumentacion():execution(void freemind.controller.Controller.DocumentationAction.actionPerformed(ActionEvent));
	
	
	
}
