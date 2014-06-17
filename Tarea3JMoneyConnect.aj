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

import javax.swing.tree.DefaultMutableTreeNode;
/**
 * Tarea1JMoneyConnect. Declara los pointcut de inicio y fin de la tarea que se define a continuaci�n.
 * 
 * Tarea1: Generar reporte de balances de cuentas existentes.
 * 
 * Descripci�n: En esta tarea, el usuario genera un reporte de los balances de las cuentas existentes.
 * Puede aplicar filtros al reporte: All Entries / Cleared Entries / Date
 * 
 * Inicio de la tarea: La tarea se considerar� iniciada luego de que el usuario haya seleccionado la opci�n "Account Balances" del 
 * panel lateral
 *  
 * Fin de la tarea: La tarea se considerar� finalizada luego de que el usuario genera el reporte presionado el bot�n "Generate"
 * del panel derecho
 * 
 * @author PI-315
 *
 */

public aspect Tarea3JMoneyConnect extends TareaEvent{
//public aspect Tarea3JMoneyConnect extends TareaConnect{
	
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
