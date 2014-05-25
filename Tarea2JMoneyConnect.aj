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
 * Tarea1JMoneyConnect. Declara los pointcut de inicio y fin de la tarea que se define a continuación.
 * 
 * Tarea1: Agregar entradas a una cuenta existente.
 * 
 * Descripción: En esta tarea, el usuario agrega nuevas entradas en la cuenta que ha seleccionado desde el panel lateral.
 * Puede ingresar datos en formatos no válidos
 * 
 * Inicio de la tarea: La tarea se considerará iniciada luego de que el usuario haya presionado el botón "New" del 
 * panel "Entries" del panel derecho donde se muestras las entradas y propiedades de la cuenta
 *  
 * Fin de la tarea: La tarea se considerará finalizada luego de que el usuario guarde, los cambios desde el menú File/Save, desde 
 * la barra de herramientas o si sale del sistema sin guardar los cambios y responde afirmativamente al mensaje de guardar los cambios
 * 
 * @author PI-315
 *
 */

public aspect Tarea2JMoneyConnect extends TareaConnect{
	
	pointcut inicializacion():execution(void net.sf.jmoney.gui.AccountEntriesPanel.newEntry());
	
	before(): inicializacion(){
		if(!connectOcupado){
			if (!iniciada) {
				
				miTarea = new Tarea("Agregar nuevas entradas en cuenta");
				
			}
		}
	}
	
	pointcut finalizacion():execution(void net.sf.jmoney.gui.MainFrame.saveSession())||execution(void net.sf.jmoney.gui.MainFrame.saveSessionAs());
	
	pointcut accesoDocumentacion(): execution(void net.sf.jmoney.gui.AboutDialog.showDialog());
		
	
}
