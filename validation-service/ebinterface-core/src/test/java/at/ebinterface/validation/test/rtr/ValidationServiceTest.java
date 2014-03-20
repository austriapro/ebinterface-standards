package at.ebinterface.validation.test.rtr;


import at.ebinterface.validation.rtr.VerificationServiceInvoker;
import at.ebinterface.validation.rtr.generated.VerificationFault;
import at.ebinterface.validation.rtr.generated.VerifyDocumentRequest;
import at.ebinterface.validation.rtr.generated.VerifyDocumentResponse;
import org.apache.commons.io.IOUtils;
import org.apache.wicket.util.crypt.Base64;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import static org.junit.Assert.fail;

public class ValidationServiceTest {



    private static final Logger LOG = LoggerFactory.getLogger(ValidationServiceTest.class.getName());


    @Test
    public void testValidationService() throws  Exception {





        //Get an invoice instance
        String invoice = IOUtils.toString(this.getClass().getResourceAsStream("/ebinterface-samples/3p02/valid_and_signed.xml"));

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

            String s = "";


        } catch (VerificationFault verificationFault) {
            LOG.error("Fehler bei der Verarbeitung. Error code {}, Error message {}", verificationFault.getFaultInfo().getErrorCode(), verificationFault.getFaultInfo().getInfo());
        }
        catch (Exception e) {
            LOG.error("Unable to get validation result. ", e);
            fail();
        }


    }



}