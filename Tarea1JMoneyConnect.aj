/**
* 
* PROYECTO DE INVESTIGACI�N
* USABILIDAD & AOP: DESARROLLO Y EVALUACI�N DE UN FRAMEWORK DE DOMINIO.
* (2014-2015)
* C�DIGO: 29/A315
* 
* M�S INFORMACI�N EN {@link https://sites.google.com/site/profeprog/proyecto5}
* 
*/ 
package ajmu;

import java.awt.event.ActionEvent;
/**
 * Tarea1JMoneyConnect. Declara los pointcut de inicio y fin de la tarea que se define a continuaci�n.
 * 
 * Tarea1: Crear nueva cuenta.
 * 
 * Descripci�n: En esta tarea, el usuario crea nueva cuenta seleccionado "New Account" 
 * desde el panel lateral con el bot�n derecho en el nodo Accounts.
 * Puede ingresar datos referidos a las propiedades de la cuenta
 * 
 * Inicio de la tarea: La tarea se considerar� iniciada luego de que el usuario haya presionado el bot�n "New Account" del 
 * nodo Accounts del panel derecho donde se muestran las cuentas registradas o ninguna si a�n no se cre� cuenta alguna
 *  
 * Fin de la tarea: La tarea se considerar� finalizada luego de que el usuario guarde, los cambios desde el men� File/Save, desde 
 * la barra de herramientas o si sale del sistema sin guardar los cambios y responde afirmativamente al mensaje de guardar los cambios
 * 
 * @author PI-315
 *
 */

public aspect Tarea1JMoneyConnect extends TareaEvent{	
//public aspect Tarea1JMoneyConnect extends TareaConnect{		
	
	pointcut inicializacion():execution(void net.sf.jmoney.gui.MainFrame.newAccount());
	before(): inicializacion(){
		if(!connectOcupado){
			if (!iniciada) {
				
				miTarea = new Tarea("Crear nueva cuenta");
				
			}
		}
	}
	
	pointcut finalizacion():execution(void net.sf.jmoney.gui.MainFrame.saveSession())||execution(void net.sf.jmoney.gui.MainFrame.saveSessionAs());
	
	pointcut accesoDocumentacion(): execution(void net.sf.jmoney.gui.AboutDialog.showDialog());
		
	
}
