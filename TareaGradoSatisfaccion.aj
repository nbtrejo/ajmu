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

import javax.swing.Icon;
import javax.swing.JOptionPane;

public aspect TareaGradoSatisfaccion {
	
	Icon icon;
	
	pointcut registrarDatos(Tarea t):execution(void Tarea.finaliza(..))&&this(t);
	
	before(Tarea t): registrarDatos(t){
		Object[] opciones = {"Muy buena", "Buena", "Regular", "Mala"};
		String s = (String)JOptionPane.showInputDialog(
		                    null,
		                    "Por favor:\n"
		                    + "\"Indique su grado de satisfacción con la aplicación \n para realizar la tarea:"+ t.getDescripcion() +"\"",
		                    "Grado de Satisfacción",
		                    JOptionPane.PLAIN_MESSAGE,	
		                    icon,
		                    opciones,
		                    "Muy buena");		
		if ((s != null) && (s.length() > 0)) {
		    t.setGradoSatisfaccion(s);
		    return;
		}
		t = null;
	}
}
