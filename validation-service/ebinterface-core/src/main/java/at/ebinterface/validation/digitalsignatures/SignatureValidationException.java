package at.ebinterface.validation.digitalsignatures;

@SuppressWarnings("serial")
public class SignatureValidationException extends Exception {

	public SignatureValidationException() {
		// TODO Auto-generated constructor stub
	}

	public SignatureValidationException(String message) {
		super(message);
	}

	public SignatureValidationException(Throwable cause) {
		super(cause);
	}

	public SignatureValidationException(String message, Throwable cause) {
		super(message, cause);
	}

}
