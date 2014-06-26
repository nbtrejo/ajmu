package ajmu;

public aspect TareaFreemindEvent extends TareaEvent {
	pointcut NoFinaliza():call(void freemind.controller.Controller.close(..));
}
