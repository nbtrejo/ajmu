package ajmu;

public aspect TareaFreemindEvent extends TaskEscape {
	pointcut NoFinaliza():call(void freemind.controller.Controller.close(..));
}
