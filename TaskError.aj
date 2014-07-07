package ajmu;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.swing.JOptionPane;

import org.aspectj.lang.Signature;

public aspect TaskError extends TareaEvent{
	/**
	 * POINCUT excepcionesAlInicio()
	 * Captura las excepciones gestionadas por catch, en el flujo de control iniciado por el pointcut inicializacion()
	 */
	pointcut excepcionesAlInicio(Throwable e): flujoInicializacion()&&!flujoAspecto()&&handler(Throwable+)&&args(e);
	/**
	 * ADVICE before()
	 * Cuando una excepción es capturada, se registra en el log invocando al aspecto TareaLogger, y se contabiliza su ocurrencia en el objeto miTarea. 
	 * @param e es un objeto de la clase Throwable de la cual heredan los diferentes tipos de excepciones que pueden ocurrir en una aplicación.
	 */
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
	 * POINTCUT excepcionesEnEjecucion()
	 * Captura las excepciones gestionadas por catch, en el flujo de control LUEGO de la accion definida en pointcut inicializacion()
	 */
	pointcut excepcionesEnEjecucion(Throwable e):!flujoInicializacion()&&!flujoAspecto()&&handler(Throwable+)&&args(e)&&tareaEnEjecucion();
	/**
	 * ADVICE before()
	 * Cuando una excepción es capturada, se registra en el log invocando al aspecto TareaLogger, y se contabiliza su ocurrencia en el objeto miTarea.
	 * @param e es un objeto de la clase Throwable de la cual heredan los diferentes tipos de excepciones que pueden ocurrir en una aplicación.
	 */
	before(Throwable e):excepcionesEnEjecucion(e){
		Signature sig = thisJoinPointStaticPart.getSignature();
		String kind = thisJoinPointStaticPart.getKind();
		String line =""+ thisJoinPointStaticPart.getSourceLocation().getLine();
        String sourceName = thisJoinPointStaticPart.getSourceLocation().getWithinType().getCanonicalName();
        
        String reg = "Excepción "+ ++nroEvento + ": Ocurrió una excepción en "+ sourceName+ "("+ kind +") línea " + line + " en el método " + sig + "(" + thisJoinPoint.toLongString() + ") Mensaje del error: " + e.getMessage();
    
        miTarea.setCantExcepciones();
		
        TareaLogger.aspectOf().grabar(reg);
	}
	/**
	 * POINTCUT capturaOptionPane()
	 * Captura ventanas de tipo JOptionPane gestionadas en el flujo de control LUEGO de la accion definida en pointcut inicializacion()
	 */
	pointcut capturaOptionPane(): !flujoInicializacion()&&!flujoAspecto()&&call(* javax.swing.JOptionPane+.show*Dialog(..)) && !within(ajmu.TareaGradoSatisfacccion.*)&& tareaEnEjecucion();
	/**
	 * ADVICE before()
	 * cuando una ventana de tipo JOptionPane es capturada, se analiza si se trata de un mensaje informativo, una advertencia, 
	 * una pregunta, o un error. Luego, se registra en el log mediante el aspecto TareaLogger y se contabiliza seteando el 
	 * atributo correspondiente en el objeto miTarea.
	 */
	before(): capturaOptionPane(){ 
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
	 * @param tipoMensaje parametro del método show*Dialog que especifica el tipo de icono mostrado
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
}
