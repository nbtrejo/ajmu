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
 * Luego, mediantes las diferentes opciones que ofrece la aplicación, deberá agregar al mapa al menos 11 nodos, 
 * incluyendo al nodo raíz, organizados en una jerarquía de al menos tres niveles. 
 * Se podrán solicitar a los usuario, que apliquen funciones de formateo, tal como cambiar el color del nodo principal, su morfología, 
 * el tamaño de la fuente, etc.
 * Finalmente se pedirá que guarde el mapa conceptual con el su nombre de la siguienta manera: MapaBásico_APELLIDONombre.mm (Ej. MapaBásico_PEREZJuan.mm).
 * 
 * Inicio de la tarea: La tarea se considerará iniciada luego de que el usuario haya seleccionado la opción "Nuevo Mapa" del 
 * menú principal o desde la barra de herramientas.
 * 
 * Fin de la tarea: La tarea se considerará finalizada luego de que el usuario guarde, por primera vez, el mapa en un archivo 
 * con el nombre solicitado. 
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
	
	pointcut accesoDocumentacion():execution(void freemind.controller.Controller.DocumentationAction.actionPerformed(ActionEvent));
	
	
	
}
