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

public class TareaMonitoreo extends Thread{
	Tarea tareaMonitoreada = null;
	public TareaMonitoreo(Tarea t) {
		tareaMonitoreada = t;
	}
	public void run(){
		while(!tareaMonitoreada.isCompleta()){
			try{
				sleep(15000);
				if(!tareaMonitoreada.isCompleta()){
					TareaLogger.aspectOf().registrarDatosParciales(tareaMonitoreada);
				}
			}catch(InterruptedException e){
				e.printStackTrace();
			}
		}
		tareaMonitoreada = null;
    }
}
