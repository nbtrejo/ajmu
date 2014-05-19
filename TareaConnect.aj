/**
* PROYECTO DE INVESTIGACIÓN: USABILIDAD Y AOP
* CÓDIGO: PI315
*/
package ajmu;

import java.awt.Dialog;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.swing.JOptionPane;
 

import org.aspectj.lang.Signature;

abstract aspect TareaConnect{
	boolean iniciada	= false;	
	Tarea miTarea = null;
	private int nroEvento = 0;
	//para ventans de dialogo
	private int nroDialogo	= 0;
	TareaMonitoreo monitor = null;
	
	
	/**
	 * EXTRAER string del tipo del metodo show*Dialog de JOptionPane
	 * @param nombreMetodoShow nombre del metodo show*Dialog de clase JOptionPane
	 * @return substring con nombre del tipo de JOptionPane : Message,Option,Input,Confirm, InternalMessage, InternalOption, InternalInput, InternalConfirm 
	 * */	
	private String strTipoJOption(String nombreMetodoShow) {
		
		Pattern pattern = Pattern.compile("(?<=show).*.(?=Dialog)");
		Matcher matcher = pattern.matcher(nombreMetodoShow);
		String auxTipo = null;		
		        
		while (matcher.find()) {			
			auxTipo = matcher.group().toString();		           
		}		
		return auxTipo;		        
	}
	
	/**
	 * EXTRAER nombre del icono del mensaje del JOPTIONPANE
	 * @param tipoMensaje parametro del m�todo show*Dialog que especifica el tipo de icono mostrado
	 * @return nombre del icono
	 * */
	private String tipoIconoMensajeJOption(Object tipoMensaje) {
		
		String auxTipo = null;
		
		switch (Integer.parseInt(tipoMensaje.toString())){
		case JOptionPane.ERROR_MESSAGE : auxTipo= "ERROR";break;
		case JOptionPane.INFORMATION_MESSAGE: auxTipo= "INFORMATIVO";break;
		case JOptionPane.PLAIN_MESSAGE: auxTipo= "SIN ICONO"; break;
		case JOptionPane.QUESTION_MESSAGE: auxTipo= "INTERROGATIVO"; break;
		case JOptionPane.WARNING_MESSAGE: auxTipo= "ADVERTENCIA"; break;
		}
		return auxTipo;       
	}
	
	/**
	 * POINTCUT INICIALIZACION()
	 * Descripción: Define el conjunto de puntos de corte que marcan el inicio de la tarea cuya usabilidad se desea estudiar.
	 */
	abstract pointcut inicializacion();
	
	before(): inicializacion(){
		if (!iniciada) {
			
			iniciada = true;
			monitor = new TareaMonitoreo(miTarea);
			monitor.start();
		}
	}
	
	/**
	 * POINTCUT FINALIZACION()
	 * Descripción: Define el conjunto de puntos de corte que marcan el fin de la tarea cuya usabilidad se desea estudiar.
	 */
	abstract pointcut finalizacion();
	
	/**
	 * The implementation for the after advice without returning needs to use a try/catch block
	 * 
	 */	 
	after() returning: finalizacion(){
		if (iniciada) {
			miTarea.finaliza();	
		}
		iniciada = false;
		nroEvento	= 0;
		nroDialogo	= 0;
		
	}

	/**
	 * POINTCUT ACCESODOCUMENTACION()
	 * Descripción: Define el conjunto de puntos de corte que indican el acceso a documentacion del sistema, disponible para usuario.
	 */
	abstract pointcut accesoDocumentacion();
	
	before(): accesoDocumentacion(){
		if((miTarea!=null)&&(!miTarea.isCompleta())){	
			 
			miTarea.setCantAccesosDocumentacion();
					
		}
	}
	
	/**
	 * POINCUT REGISTRAREXCEPCIONES()
	 * Descripción: Captura las excepciones gestionadas por catch, en el flujo de control iniciado por el pointcut inicializacion()
	 */
	pointcut excepcionesAlInicio(Throwable e): cflow(inicializacion())&&!cflow(adviceexecution())&&handler(Throwable+)&&args(e);
	before(Throwable e): excepcionesAlInicio(e){
		
		Signature sig = thisJoinPointStaticPart.getSignature();
		String kind = thisJoinPointStaticPart.getKind();
        String line =""+ thisJoinPointStaticPart.getSourceLocation().getLine();
        String sourceName = thisJoinPointStaticPart.getSourceLocation().getWithinType().getCanonicalName();
        
        String reg = "Excepción "+ ++nroEvento + ": Ocurrió una excepción en "+ sourceName+ "("+ kind +") línea " + line + " en el método " + sig + "(" + thisJoinPoint.toLongString() + ") Mensaje del error: " + e.getMessage();
		
		miTarea.setCantExcepciones();
		
		TareaLogger.aspectOf().grabar(reg);
		
	}
	
	/**
	 * Descripción: Captura las excepciones gestionadas por catch, en el flujo de control LUEGO de la accion definida en pointcut inicializacion()
	 */
	pointcut excepcionesEnEjecucion(Throwable e):!cflow(inicializacion())&&!cflow(adviceexecution())&&handler(Throwable+)&&args(e);
	
	before(Throwable e):excepcionesEnEjecucion(e){
		if((miTarea!=null)&&(!miTarea.isCompleta())){			 
			Signature sig = thisJoinPointStaticPart.getSignature();
			String kind = thisJoinPointStaticPart.getKind();
			String line =""+ thisJoinPointStaticPart.getSourceLocation().getLine();
	        String sourceName = thisJoinPointStaticPart.getSourceLocation().getWithinType().getCanonicalName();
	        
	        String reg = "Excepción "+ ++nroEvento + ": Ocurrió una excepción en "+ sourceName+ "("+ kind +") línea " + line + " en el método " + sig + "(" + thisJoinPoint.toLongString() + ") Mensaje del error: " + e.getMessage();
	    
	        miTarea.setCantExcepciones();
			
	        TareaLogger.aspectOf().grabar(reg);
						
		}
	}
	
	/**
	 * Descripción: La tarea inicia pero no finaliza
	 */	
	pointcut noFinalizoTarea():call(void java.lang.System.exit(..))&&!cflow(finalizacion())&&!cflow(adviceexecution());
	
	before(): noFinalizoTarea() {	
		if((miTarea!=null)&&(!miTarea.isCompleta())){
			TareaLogger.aspectOf().grabar("================= RESULTADOS FINALES ====================");
			TareaLogger.aspectOf().grabar("La tarea id " + miTarea.getId() + " NO ha finalizado");		
			TareaLogger.aspectOf().grabar("Excepciones gestionadas: " + miTarea.getCantExcepciones());			
			TareaLogger.aspectOf().grabar("Diálogos mostrados: " + miTarea.getCantDialogos());			
			TareaLogger.aspectOf().grabar("Accesos a la documentación: " + miTarea.getCantAccesosDocumentacion());
			TareaLogger.aspectOf().grabar("Mensajes sin icono: " + miTarea.getCantMensajesSinIcono());
			TareaLogger.aspectOf().grabar("Mensajes de error: " + miTarea.getCantMensajesIconoError());
			TareaLogger.aspectOf().grabar("Mensajes de advertencia: " + miTarea.getCantMensajesIconoAdvertencia());
			TareaLogger.aspectOf().grabar("Mensajes informativos: " + miTarea.getCantMensajesIconoInformativo());
			TareaLogger.aspectOf().grabar("Mensajes interrogativos: " + miTarea.getCantMensajesIconoPregunta());
		}
	}


	/**
	 * 
	 * Descripción: Captura ventanas de tipo Dialog gestionadas en el flujo de control LUEGO de la accion definida en pointcut inicializacion()
	 */	
	
	pointcut capturaDialogo(Dialog jd): !cflow(inicializacion())&&!cflow(adviceexecution()) && call( * *Dialog(..)) && target(jd);	
	
	before(Dialog jd): capturaDialogo(jd){
		if((miTarea!=null)&&(!miTarea.isCompleta())){	
			if (thisJoinPoint.getTarget().getClass().getSuperclass().getCanonicalName().equals("javax.swing.JDialog") ||
					thisJoinPoint.getTarget().getClass().getSuperclass().getCanonicalName().equals("java.awt.Dialog")){
				
				String tituloDialogo	= "Titulo: " + jd.getTitle();
				
				Signature sig = thisJoinPointStaticPart.getSignature();
				String kind = thisJoinPointStaticPart.getKind();
				String line =""+ thisJoinPointStaticPart.getSourceLocation().getLine();
		        String sourceName = thisJoinPointStaticPart.getSourceLocation().getWithinType().getCanonicalName();
		         
		        String reg = "Dialogo: "+  + ++nroDialogo + "-> TITULO: " + tituloDialogo + ": Ocurrio un llamado en "+ sourceName+ "("+ kind +") linea " + line + " al metodo " + sig + "(" + thisJoinPoint.toLongString() + ")";
		        
		        miTarea.setCantDialogos();
				TareaLogger.aspectOf().grabar(reg);
			}		
		}
	}
	
	/**
	 * 
	 * Descripción: Captura ventanas de tipo JOptionPane gestionadas en el flujo de control LUEGO de la accion definida en pointcut inicializacion()
	 */
	pointcut capturaOptionPane(): !cflow(inicializacion())&&!cflow(adviceexecution())&&call(* javax.swing.JOptionPane+.show*Dialog(..)) && !within(ajmu.TareaGradoSatisfacccion.*);	
		
	before(): capturaOptionPane(){ 
		if((miTarea!=null)&&(!miTarea.isCompleta())){
			String tipoJOptionPane	= strTipoJOption(thisJoinPoint.getSignature().getName());
			Object [] parametros	= thisJoinPoint.getArgs();			
			String tituloMensaje	= parametros[2].toString();
			int tipoIcono	= -1;
			String tipoMensajeIconificado	= "SIN ICONO PERSONALIZADO";
			if (tipoJOptionPane.equals("Message") || tipoJOptionPane.equals("InternalMessage")){
				if (parametros.length == 4) { 
					//System.out.println("JOptionPane MESSAGE. Titulo: " + parametros[2] + " tipo Mensaje: " + tipoIconoMensajeJOption(parametros[3]));
					tipoIcono	= Integer.parseInt(parametros[3].toString());
					tipoMensajeIconificado	= tipoIconoMensajeJOption(parametros[3]);
				} else {
					tipoIcono	= 1;
					tipoMensajeIconificado	= "INFORMATIVO" ;
				} 
			}else if (tipoJOptionPane.equals("Option") || tipoJOptionPane.equals("InternalOption")) {
				if (parametros.length == 5) { 
					//System.out.println("JOptionPane OPTION. Titulo: " + parametros[2] + " tipo Mensaje: " + tipoIconoMensajeJOption(parametros[4]));
					tipoIcono	= Integer.parseInt(parametros[4].toString());				
					tipoMensajeIconificado	= "BOTONES PERSONALIZADOS " + tipoIconoMensajeJOption(parametros[4]);
				}
			}else if (tipoJOptionPane.equals("Input") || tipoJOptionPane.equals("InternalInput")) {	
				 if (parametros.length == 4) { 
					 //System.out.println("JOptionPane INPUT. Titulo: " + parametros[2] + " tipo Mensaje: " + tipoIconoMensajeJOption(parametros[3]));
					 tipoIcono	= Integer.parseInt(parametros[3].toString());
					 tipoMensajeIconificado	= "ENTRADA DE USUARIO " + tipoIconoMensajeJOption(parametros[3]);
				}else {
					tipoIcono	= 3;
					tipoMensajeIconificado	= "ENTRADA DE USUARIO INTERROGATIVO" ;
				} 
			}else if (tipoJOptionPane.equals("Confirm") || tipoJOptionPane.equals("InternalConfirm")) {	
				 if (parametros.length == 4) { 
					 //System.out.println("JOptionPane CONFIRM.titulo: " + parametros[2]);	
					 tipoIcono	= 3;
					 tipoMensajeIconificado	= "CONFIRMACION INTERROGATIVO" ;
				 	}
				 	else if (parametros.length == 5) { 
				 		//System.out.println("JOptionPane CONFIRM. Titulo: " + parametros[2] + " tipo Mensaje: " + tipoIconoMensajeJOption(parametros[4]));
				 		tipoIcono	= Integer.parseInt(parametros[4].toString());
				 		tipoMensajeIconificado	= "CONFIRMACION " + tipoIconoMensajeJOption(parametros[4]);
				 	} else {
				 		tipoIcono	= 3;
						tipoMensajeIconificado	= "CONFIRMACION INTERROGATIVO" ;
					} 				
			}
			//incrementar los contadores en la clase Tarea
			switch (tipoIcono){
				case -1: miTarea.setCantMensajesSinIcono();break;
				case 0: miTarea.setCantMensajesIconoError();break;
				case 1: miTarea.setCantMensajesIconoInformativo();break;
				case 2: miTarea.setCantMensajesIconoAdvertencia();break;
				case 3: miTarea.setCantMensajesIconoPregunta();break;
			}
				
			Signature sig = thisJoinPointStaticPart.getSignature();
			String kind = thisJoinPointStaticPart.getKind();
			String line =""+ thisJoinPointStaticPart.getSourceLocation().getLine();
		    String sourceName = thisJoinPointStaticPart.getSourceLocation().getWithinType().getCanonicalName();
		         
		    String reg = "Dialogo: "+  + ++nroDialogo + "-> TITULO: '" +tituloMensaje + "' TIPO DE MENSAJE: " + tipoMensajeIconificado + " : Ocurrio un llamado en "+ sourceName+ " ("+ kind +") linea " + line + " al metodo " + sig + "(" + thisJoinPoint.toLongString() + ")";
		        
		    miTarea.setCantDialogos();
			TareaLogger.aspectOf().grabar(reg);
				
		}
	}
}
