package ajmu;

public class TareaMonitoreo extends Thread{
	Tarea tareaMonitoreada = null;
	public TareaMonitoreo(Tarea t) {
		// TODO Auto-generated constructor stub
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
    }
}
