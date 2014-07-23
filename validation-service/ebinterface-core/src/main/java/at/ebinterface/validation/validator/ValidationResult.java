package at.ebinterface.validation.validator;

import at.ebinterface.validation.rtr.generated.VerifyDocumentResponse;
import at.ebinterface.validation.validator.jaxb.Result;

/**
 * DTO for the validation result
 *
 * @author pl
 */
public class ValidationResult {


    private String schemaValidationErrorMessage;
    private EbInterfaceVersion determinedEbInterfaceVersion;

    /**
     * Schematronvalidation result
     */
    private Result result;

    /**
     * Holds a potential signature validation exception, which is returned by the validation service *
     */
    private String signatureValidationExceptionMessage;

    /**
     * Certificate specific results
     */
    private VerifyDocumentResponse verifyDocumentResponse;


    public String getSchemaValidationErrorMessage() {
        return schemaValidationErrorMessage;
    }

    public void setSchemaValidationErrorMessage(final String schemaValidationErrorMessage) {
        this.schemaValidationErrorMessage = schemaValidationErrorMessage;
    }

    public EbInterfaceVersion getDeterminedEbInterfaceVersion() {
        return determinedEbInterfaceVersion;
    }

    public void setDeterminedEbInterfaceVersion(
            final EbInterfaceVersion determinedEbInterfaceVersion) {
        this.determinedEbInterfaceVersion = determinedEbInterfaceVersion;
    }

    public Result getResult() {
        return result;
    }

    public void setResult(final Result result) {
        this.result = result;
    }

    public VerifyDocumentResponse getVerifyDocumentResponse() {
        return verifyDocumentResponse;
    }

    public void setVerifyDocumentResponse(VerifyDocumentResponse verifyDocumentResponse) {
        this.verifyDocumentResponse = verifyDocumentResponse;
    }


    public String getSignatureValidationExceptionMessage() {
        return signatureValidationExceptionMessage;
    }

    public void setSignatureValidationExceptionMessage(String signatureValidationExceptionMessage) {
        this.signatureValidationExceptionMessage = signatureValidationExceptionMessage;
    }
}
