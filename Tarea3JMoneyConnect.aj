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

import javax.swing.tree.DefaultMutableTreeNode;
/**
 * Tarea1JMoneyConnect. Declara los pointcut de inicio y fin de la tarea que se define a continuación.
 * 
 * Tarea1: Generar reporte de balances de cuentas existentes.
 * 
 * Descripción: En esta tarea, el usuario genera un reporte de los balances de las cuentas existentes.
 * Puede aplicar filtros al reporte: All Entries / Cleared Entries / Date
 * 
 * Inicio de la tarea: La tarea se considerará iniciada luego de que el usuario haya seleccionado la opción "Account Balances" del 
 * panel lateral
 *  
 * Fin de la tarea: La tarea se considerará finalizada luego de que el usuario genera el reporte presionado el botón "Generate"
 * del panel derecho
 * 
 * @author PI-315
 *
 */

public aspect Tarea3JMoneyConnect extends TareaConnect{
	
	//pointcut inicializacion():execution(void net.sf.jmoney.gui.IncomeExpenseReportPanel.setSession(net.sf.jmoney.model.Session));
	pointcut inicializacion():execution(void net.sf.jmoney.gui.AccountBalancesReportPanel.setSession(net.sf.jmoney.model.Session));
	
	before(): inicializacion(){
		if(!connectOcupado){
			if (!iniciada) {
				
				miTarea = new Tarea("Generar reporte de balances de cuentas");
				
			}
		}
	}
	
	pointcut finalizacion():execution(void net.sf.jmoney.gui.AccountBalancesReportPanel.generateReport());
	
	pointcut accesoDocumentacion(): execution(void net.sf.jmoney.gui.AboutDialog.showDialog());
		
	
}
