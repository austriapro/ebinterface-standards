package at.ebinterface.validation.digitalsignatures;

import at.gv.egovernment.moa.spss.MOAException;
import at.gv.egovernment.moa.spss.api.SPSSFactory;
import at.gv.egovernment.moa.spss.api.SignatureVerificationService;
import at.gv.egovernment.moa.spss.api.common.Content;
import at.gv.egovernment.moa.spss.api.common.SignerInfo;
import at.gv.egovernment.moa.spss.api.xmlverify.VerifySignatureInfo;
import at.gv.egovernment.moa.spss.api.xmlverify.VerifySignatureLocation;
import at.gv.egovernment.moa.spss.api.xmlverify.VerifyXMLSignatureRequest;
import at.gv.egovernment.moa.spss.api.xmlverify.VerifyXMLSignatureResponse;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public enum MOASignatureValidator {

  INSTANCE;

  private static final Logger LOG = LoggerFactory.getLogger(MOASignatureValidator.class.getName());
  private static final SPSSFactory spssFac;
  private static final SignatureVerificationService sigVerifyService;


  static {
    //Set the reference to the configuration
    System.setProperty("moa.spss.server.configuration", "moa-config/sp.minimum.config.xml");


    // Initialize the necessary MOA libraries
    // Factory und Service instanzieren
    spssFac = SPSSFactory.getInstance();
    sigVerifyService = SignatureVerificationService.getInstance();

  }


  /**
   * Convenience method to allow calling w/ byte array.
   * 
   * @throws Exception
   */
  public VerifyXMLSignatureResponse validate(final byte[] signed, final String signatureNameSpacePrefix) throws Exception
  {
    final ByteArrayInputStream bIn = new ByteArrayInputStream(signed);
    return validate(bIn, signatureNameSpacePrefix);
  }

  /**
   * Validate an enveloped XML signature
   * @throws Exception

   */
  public VerifyXMLSignatureResponse validate(final InputStream signed, final String signatureNamespacePrefix) throws Exception {

    final Content sigDocContent = spssFac.createContent(signed, null);

    // Define the exact position of the signature element in the file
    final Map<String,String> nSMap = new HashMap<String,String>();
    nSMap.put(signatureNamespacePrefix, "http://www.w3.org/2000/09/xmldsig#");

    final StringBuffer signatureElementReference = new StringBuffer();
    signatureElementReference.append("//");
    if (!StringUtils.isEmpty(signatureNamespacePrefix)) {
      signatureElementReference.append(signatureNamespacePrefix).append(":");
    }
    signatureElementReference.append("Signature");
    final VerifySignatureLocation sigLocation = spssFac.createVerifySignatureLocation(signatureElementReference.toString(), nSMap);

    // Merge document and signature position
    final VerifySignatureInfo sigInfo = spssFac.createVerifySignatureInfo(sigDocContent, sigLocation);

    // Create request
    final VerifyXMLSignatureRequest verifyRequest = spssFac.createVerifyXMLSignatureRequest(null, // null
                                                                                            // =
                                                                                            // current
                                                                                            // time
                                                                                            sigInfo,
                                                                                            null, // No additional objects necessary
                                                                                            null, // No signature manifest check
                                                                                            true, // Do not return signed info
        "Signaturdienste"); // ID of the trusted profile

    VerifyXMLSignatureResponse verifyResponse = null;
    try {
      // Aufruf der Signaturprüfung
      verifyResponse = sigVerifyService.verifyXMLSignature(verifyRequest);
    } catch (final MOAException e) {
      LOG.error("Error while trying to verify signature", e);
      throw (new Exception("Signatur konnte mit Hilfe von MOA/SPSS nicht verifiziert werden. Fehlercode: " + e.getMessageId() + " Fehlernachricht: " + e.getMessage()));
    }
    catch (final Exception e) {
      LOG.error("Error while trying to verify signature", e);
      throw (new Exception("Signatur konnte mit Hilfe von MOA/SPSS nicht verifiziert werden. Fehlernachricht: " + e.getMessage()));
    }


    //Output details about the response in case DEBUG is enabled
    if (LOG.isDebugEnabled()) {

      // Besondere Eigenschaften des Signatorzertifikats
      final SignerInfo signerInfo = verifyResponse.getSignerInfo();
      LOG.debug("*** Ist Zertifikat des Signators qualifiziert? " + ((signerInfo.isQualifiedCertificate()) ? "ja" : "nein"));
      LOG.debug("*** Ist Zertifikat des Signators von einer Behörde? " + ((signerInfo.isPublicAuthority()) ? "ja" : "nein"));

      // Ergebnisse von Signatur- und Zertifikatsprüfung
      LOG.debug("Ergebniscode der Signaturprüfung: " + verifyResponse.getSignatureCheck().getCode());
      LOG.debug("Ergebniscode der Zertifikatsprüfung: " + verifyResponse.getCertificateCheck().getCode());

      // Signatorzertifikat
      LOG.debug("*** Zertifikat des Signators:");
      LOG.debug("Aussteller: " + signerInfo.getSignerCertificate().getIssuerDN());
      LOG.debug("Subject: " + signerInfo.getSignerCertificate().getSubjectDN());
      LOG.debug("Seriennummer: " + signerInfo.getSignerCertificate().getSerialNumber());

    }



    return verifyResponse;
  }
}
