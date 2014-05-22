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
 * Tarea2FreemindConnect. Declara los pointcut de inicio y fin de la tarea que se define a continuación.
 * 
 * Tarea2: Creación de un Mapa Mental Encriptado.
 * 
 * Descripción: En esta tarea, el usuario deberá crear un nuevo mapa encriptado, es decir que el archivo fuente del mapa mental
 * estará protegido por una contraseña que le será solicitada a todo aquel que desee visualizarlo y/o editarlo.
 * Para ello, desde el menú principal deberá seleccionar la opción "Crear mapa encriptado". Una vez realizada esta operación, se 
 * solicitará al usuario que ingrese una contraseña.
 * Una característica de este mapa mental, es que el nodo raíz se representa con un candado indicando que se encuentra protegido 
 * o encriptado.
 * Luego de crear el mapa se le solicitará al usuario, agregar al menos 6 nodos normales, y 6 nodos encriptados, todos ellos organizados
 * en una jerarquía de al menos tres niveles.
 * Finalmente se pedirá que guarde el mapa conceptual con el su nombre de la siguienta manera: MapaProtegido_APELLIDONombre.mm (Ej. MapaProtegido_PEREZJuan.mm).
 * 
 * Inicio de la tarea: La tarea se considerará iniciada luego de que el usuario haya seleccionado la opción "Nuevo Mapa Encriptado" del 
 * menú principal.
 * 
 * Fin de la tarea: La tarea se considerará finalizada luego de que el usuario guarde, por primera vez, el mapa en un archivo 
 * con el nombre solicitado. 
 * 
 * @author PI-315
 *
 */

public aspect Tarea2FreemindConnect extends TareaConnect{
	
	pointcut inicializacion():execution(void accessories.plugins.EncryptNode.newEncryptedMap());
	
	before(): inicializacion(){
		if(!connectOcupado){
			if (!iniciada) {
				
				miTarea = new Tarea("Tarea: Creación de Mapa Conceptual Encriptado");
				
			}
		}
	}
	
	pointcut finalizacion():execution(* freemind.modes.ControllerAdapter.SaveAsAction.*(..))||execution(* freemind.modes.ControllerAdapter.SaveAction.*(..));
	
	pointcut accesoDocumentacion():execution(void freemind.controller.Controller.DocumentationAction.actionPerformed(ActionEvent));
	
	
	
}
