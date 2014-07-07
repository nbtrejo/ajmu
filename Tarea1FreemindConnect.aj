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
 * Tarea1FreemindConnect. Declara los pointcut de inicio y fin de la tarea que se define a continuación.
 * 
 * Tarea1: Creación de un Mapa Mental Básico.
 * 
 * Descripción: En esta tarea, el usuario deberá crear un nuevo mapa desde el menú principal o desde la barra de herramientas.
 * Luego, mediante las diferentes opciones que ofrece la aplicación, deberá agregar, al menos, 10 nodos, organizados en una jerarquía 
 * de al menos tres niveles. 
 * Se podrán solicitar a los usuario que apliquen formato, tal como cambiar el color del nodo principal, su morfología, el tamaño de 
 * la fuente, etc.
 * Finalmente se pedirá que guarde el mapa conceptual en el escritorio de su ordenador con un nombre significativo.
 * 
 * Inicio de la tarea: La tarea se considerará iniciada luego de que el usuario haya seleccionado la opción "Nuevo" del 
 * menú principal o desde la barra de herramientas.
 * 
 * Fin de la tarea: La tarea se considerará finalizada luego de que el usuario guarde, por primera vez, el mapa en el escritorio. 
 * 
 * @author PI-315
 *
 */
public aspect Tarea1FreemindConnect extends TareaConnect{
	
	pointcut inicializacion():execution(void freemind.modes.common.actions.NewMapAction.actionPerformed(ActionEvent));
	
	before(): inicializacion(){
		if(!connectOcupado){
			if (!iniciada) {
				
				miTarea = new Tarea("Tarea: Creación de un Mapa Conceptual Básico");
				
			}
		}
	}
	
	pointcut finalizacion():execution(* freemind.modes.ControllerAdapter.SaveAsAction.*(..))||execution(* freemind.modes.ControllerAdapter.SaveAction.*(..));
	
	
	
}
