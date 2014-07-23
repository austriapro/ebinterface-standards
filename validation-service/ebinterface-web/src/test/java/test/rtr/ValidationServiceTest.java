package test.rtr;


import at.ebinterface.validation.dto.SignatureValidationResult;
import at.ebinterface.validation.rtr.VerificationServiceInvoker;
import at.ebinterface.validation.rtr.generated.VerificationFault;
import at.ebinterface.validation.rtr.generated.VerifyDocumentRequest;
import at.ebinterface.validation.rtr.generated.VerifyDocumentResponse;
import org.apache.commons.io.IOUtils;
import org.junit.Assert;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.net.URL;

import static org.junit.Assert.fail;

public class ValidationServiceTest {


    private static final Logger LOG = LoggerFactory.getLogger(ValidationServiceTest.class.getName());


    static {
        //Set the manual keystore, otherwise the RTR certificate is not trusted
        try {
            URL url = ValidationServiceTest.class.getResource("/keystore.jks");
            System.setProperty("javax.net.ssl.trustStore", url.getPath());
            System.setProperty("javax.net.ssl.trustStorePassword", "");

        } catch (Exception e1) {
            throw new RuntimeException("Error while reading SSL Keystore. Unable to proceed.", e1);
        }

    }

    @Test
    public void testValidationService() throws Exception {

        //Get an invoice instance
        String invoice = IOUtils.toString(this.getClass().getResourceAsStream("/ebinterface/3p02/valid_and_signed.xml"));

        //Create a verification request
        VerifyDocumentRequest request = new VerifyDocumentRequest();

        //Set the document
        request.setDocument(invoice.getBytes());
        //No PDF report required
        request.setRequestPDFReport(false);
        //Expect German results
        request.setLanguage("de");

        //Get a response
        try {
            VerifyDocumentResponse response = VerificationServiceInvoker.verifyDocument(request);

            SignatureValidationResult result = new SignatureValidationResult(response);
            Assert.assertTrue(result.isCertificateValid());
            Assert.assertTrue(result.isSignatureValid());
            Assert.assertTrue(result.isManifestValid());


        } catch (VerificationFault verificationFault) {
            LOG.error("Fehler bei der Verarbeitung. Error code {}, Error message {}", verificationFault.getFaultInfo().getErrorCode(), verificationFault.getFaultInfo().getInfo());
        } catch (Exception e) {
            LOG.error("Unable to get validation result. ", e);
            fail();
        }


        //Get an invalid invoice
        invoice = IOUtils.toString(this.getClass().getResourceAsStream("/ebinterface/3p02/mesonic1-corrupted.xml"));
        request = new VerifyDocumentRequest();
        //Set the document
        request.setDocument(invoice.getBytes());
        //No PDF report required
        request.setRequestPDFReport(false);
        //Expect German results
        request.setLanguage("de");

        //Get a response
        try {
            VerifyDocumentResponse response = VerificationServiceInvoker.verifyDocument(request);
            fail();

        } catch (VerificationFault verificationFault) {
            LOG.error("Fehler bei der Verarbeitung. Error code {}, Error message {}", verificationFault.getFaultInfo().getErrorCode(), verificationFault.getFaultInfo().getInfo());
        } catch (Exception e) {
            LOG.error("Unable to get validation result. ", e);
        }


    }


}