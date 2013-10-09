package at.ebinterface.validation.validator;

import at.ebinterface.validation.validator.jaxb.Result;

/**
 * DTO for the validation result
 * @author pl
 *
 */
public class ValidationResult {

	
	private String schemaValidationErrorMessage;
	private EbInterfaceVersion determinedEbInterfaceVersion;
	
	/** Schematronvalidation result */
	private Result result;
	
	//Certificate specific results
	private boolean certificateOK;
	private boolean signatureOK;
	
	private String certificateIssuer;
	private String certificateSubject;
	private String certificateSerialNumber;
	
	private Boolean certificateOfSignatorQualified;
	private Boolean certificateOfSignatorFromAPublicAuthority;
	
	
	
	public String getSchemaValidationErrorMessage() {
		return schemaValidationErrorMessage;
	}
	public void setSchemaValidationErrorMessage(String schemaValidationErrorMessage) {
		this.schemaValidationErrorMessage = schemaValidationErrorMessage;
	}
	public EbInterfaceVersion getDeterminedEbInterfaceVersion() {
		return determinedEbInterfaceVersion;
	}
	public void setDeterminedEbInterfaceVersion(
			EbInterfaceVersion determinedEbInterfaceVersion) {
		this.determinedEbInterfaceVersion = determinedEbInterfaceVersion;
	}
	public Result getResult() {
		return result;
	}
	public void setResult(Result result) {
		this.result = result;
	}
	public boolean isCertificateOK() {
		return certificateOK;
	}
	public void setCertificateOK(boolean certificateOK) {
		this.certificateOK = certificateOK;
	}
	public boolean isSignatureOK() {
		return signatureOK;
	}
	public void setSignatureOK(boolean signatureOK) {
		this.signatureOK = signatureOK;
	}
	public String getCertificateIssuer() {
		return certificateIssuer;
	}
	public void setCertificateIssuer(String certificateIssuer) {
		this.certificateIssuer = certificateIssuer;
	}
	public String getCertificateSubject() {
		return certificateSubject;
	}
	public void setCertificateSubject(String certificateSubject) {
		this.certificateSubject = certificateSubject;
	}
	public String getCertificateSerialNumber() {
		return certificateSerialNumber;
	}
	public void setCertificateSerialNumber(String certificateSerialNumber) {
		this.certificateSerialNumber = certificateSerialNumber;
	}
	public Boolean getCertificateOfSignatorQualified() {
		return certificateOfSignatorQualified;
	}
	public void setCertificateOfSignatorQualified(
			Boolean certificateOfSignatorQualified) {
		this.certificateOfSignatorQualified = certificateOfSignatorQualified;
	}
	public Boolean getCertificateOfSignatorFromAPublicAuthority() {
		return certificateOfSignatorFromAPublicAuthority;
	}
	public void setCertificateOfSignatorFromAPublicAuthority(
			Boolean certificateOfSignatorFromAPublicAuthority) {
		this.certificateOfSignatorFromAPublicAuthority = certificateOfSignatorFromAPublicAuthority;
	}

	
	
	
	
	
	
}
