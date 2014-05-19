package ajmu;

import javax.swing.Icon;
import javax.swing.JOptionPane;

public aspect TareaGradoSatisfaccion {
	declare precedence: TareaGradoSatisfaccion, TareaLogger;
	
pointcut registrarDatos(Tarea t):execution(void Tarea.finaliza(..))&&this(t);
	Icon icon;
	before(Tarea t): registrarDatos(t){
		Object[] opciones = {"Muy buena", "Buena", "regular", "mala"};
		String s = (String)JOptionPane.showInputDialog(
		                    null,
		                    "Por favor:\n"
		                    + "\"Indique su grado de satisfacción con la aplicación para realizar la tarea:...\"",
		                    "Grado de Satisfacción",
		                    JOptionPane.PLAIN_MESSAGE,	
		                    icon,
		                    opciones,
		                    "Muy buena");

		//If a string was returned, say so.
		if ((s != null) && (s.length() > 0)) {
		    t.setGradoSatisfaccion(s);
		    return;
		}

		
		 
        
		
	}
}
