package at.ebinterface.validation.dto;

import at.ebinterface.validation.rtr.generated.SignatureInfoType;
import at.ebinterface.validation.rtr.generated.VerifyDocumentResponse;

import java.io.Serializable;
import java.math.BigInteger;

/**
 * Used to represent the result of a signature validation based on the Web Service response
 * User: pl
 * Date: 20.03.14
 * Time: 12:43
 */
public class SignatureValidationResult implements Serializable {

    private boolean signatureValid;
    private boolean certificateValid;
    private boolean manifestValid;


    private String signatureText;
    private String certificateText;
    private String manifestText;


    /**
     * Contstruct a new signature validation result based on the results returned by the RTR Web Service
     *
     * @param result
     */
    public SignatureValidationResult(VerifyDocumentResponse result) {

        SignatureInfoType signatureInfo = null;

        if (result != null) {
            if (result.getVerificationReport() != null) {
                if (result.getVerificationReport().getSignatureInfo() != null &&
                        result.getVerificationReport().getSignatureInfo().size() > 0) {
                    signatureInfo = result.getVerificationReport().getSignatureInfo().get(0);
                }
            }

        }

        if (signatureInfo != null) {

            //Signature check details
            if (BigInteger.ZERO.equals(signatureInfo.getSignatureCheck().getCode())) {
                signatureValid = true;
            } else {
                signatureValid = false;
            }
            signatureText = signatureInfo.getSignatureCheck().getInfo();


            //Certificate check details
            if (BigInteger.ZERO.equals(signatureInfo.getCertificateCheck().getCode())) {
                certificateValid = true;
            } else {
                certificateValid = false;
            }
            certificateText = signatureInfo.getCertificateCheck().getInfo();

            //Manifest check
            if (BigInteger.ZERO.equals(signatureInfo.getManifestCheck().getManifest().getCode())) {
                manifestValid = true;
            } else {
                manifestValid = false;
            }
            manifestText = signatureInfo.getManifestCheck().getManifest().getInfo();


        }


    }


    public boolean isSignatureValid() {
        return signatureValid;
    }

    public void setSignatureValid(boolean signatureValid) {
        this.signatureValid = signatureValid;
    }

    public boolean isCertificateValid() {
        return certificateValid;
    }

    public void setCertificateValid(boolean certificateValid) {
        this.certificateValid = certificateValid;
    }

    public boolean isManifestValid() {
        return manifestValid;
    }

    public void setManifestValid(boolean manifestValid) {
        this.manifestValid = manifestValid;
    }

    public String getSignatureText() {
        return signatureText;
    }

    public void setSignatureText(String signatureText) {
        this.signatureText = signatureText;
    }

    public String getCertificateText() {
        return certificateText;
    }

    public void setCertificateText(String certificateText) {
        this.certificateText = certificateText;
    }

    public String getManifestText() {
        return manifestText;
    }

    public void setManifestText(String manifestText) {
        this.manifestText = manifestText;
    }
}


