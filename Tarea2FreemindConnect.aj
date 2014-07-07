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

/**
 * Tarea2FreemindConnect. Declara los pointcut de inicio y fin de la tarea que se define a continuación.
 * 
 * Tarea2: Creación de un Mapa Mental Cifrado.
 * 
 * Descripción: En esta tarea, el usuario deberá crear un nuevo mapa cifrado, es decir que el archivo fuente del mapa mental
 * estará protegido por una contraseña que le será solicitada cuando cree el mapa.
 * Para ello, desde el menú principal deberá seleccionar la opción "Crear mapa cifrado". Una vez realizada esta operación, se 
 * solicitará al usuario que ingrese una contraseña.
 * Luego de crear el mapa, se le solicitará al usuario agregar nodos hijos o hermanos y nodos cifrados, todos ellos organizados
 * en una jerarquía de al menos tres niveles.
 * Finalmente, se pedirá que guarde el mapa conceptual en su escritorio con un nombre significativo.
 * 
 * Inicio de la tarea: La tarea se considerará iniciada luego de que el usuario haya seleccionado la opción "Nuevo Mapa Cifrado" 
 * desde el menú principal.
 * 
 * Fin de la tarea: La tarea se considerará finalizada luego de que el usuario guarde, por primera vez, el mapa en el escritorio. 
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
	
	
}
