package ajmu;

public aspect TaskFreemindAccessDocumentation extends TaskAccessDocumentation {
	pointcut accesoDocumentacion():execution(void freemind.controller.Controller.DocumentationAction.actionPerformed(..));
}
