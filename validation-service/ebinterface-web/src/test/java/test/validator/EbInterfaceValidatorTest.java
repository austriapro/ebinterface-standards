package test.validator;

import at.ebinterface.validation.validator.EbInterfaceValidator;
import at.ebinterface.validation.validator.EbInterfaceVersion;
import at.ebinterface.validation.validator.Rules;
import at.ebinterface.validation.validator.ValidationResult;
import at.ebinterface.validation.validator.jaxb.Result;
import org.apache.commons.lang.StringUtils;
import org.apache.wicket.util.io.IOUtils;
import org.junit.Assert;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.List;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;

/**
 * Test class for testing the schematron validator
 *
 * @author pl
 */
public class EbInterfaceValidatorTest {


    private static final Logger LOG = LoggerFactory.getLogger(EbInterfaceValidatorTest.class.getName());


    static {


        //Set the manual keystore, otherwise the RTR certificate is not trusted
        try {
            URL url = EbInterfaceValidatorTest.class.getResource("/keystore.jks");
            LOG.debug("Setting key store reference to {}", url.getPath());
            System.setProperty("javax.net.ssl.trustStore", url.getPath());
            System.setProperty("javax.net.ssl.trustStorePassword", "");

        } catch (Exception e1) {
            throw new RuntimeException("Error while reading SSL Keystore. Unable to proceed.", e1);
        }


    }

    /**
     * Test the schema validator
     *
     * @throws IOException
     */
    @Test
    public void test4p1SchemaValidator() throws IOException {

        // Valid schema
        InputStream input = this.getClass().getResourceAsStream("/ebinterface/4p1/ebInterface_4p1_sample.xml");
        byte[] uploadedData = null;

        assertNotNull(input);
        // Step 1 - validate against the schema
        uploadedData = IOUtils.toByteArray(input);
        EbInterfaceValidator validator = new EbInterfaceValidator();
        ValidationResult result = validator.validateXMLInstanceAgainstSchema(uploadedData);
        assertTrue(StringUtils.isEmpty(result.getSchemaValidationErrorMessage()));


        // Invalid schema
        input = this.getClass().getResourceAsStream("/ebinterface/4p1/ebInterface_4p1_sample_invalid.xml");
        uploadedData = IOUtils.toByteArray(input);
        validator = new EbInterfaceValidator();
        result = validator.validateXMLInstanceAgainstSchema(uploadedData);
        assertFalse(StringUtils.isEmpty(result.getSchemaValidationErrorMessage()));


    }


    /**
     * Test the schema validator
     *
     * @throws IOException
     */
    @Test
    public void test4p0SchemaValidator() throws IOException {

        // Valid schema
        InputStream input = this.getClass().getResourceAsStream("/ebinterface/4p0/testinstance-valid-schema.xml");
        byte[] uploadedData = null;

        assertNotNull(input);
        // Step 1 - validate against the schema
        uploadedData = IOUtils.toByteArray(input);
        EbInterfaceValidator validator = new EbInterfaceValidator();
        ValidationResult result = validator.validateXMLInstanceAgainstSchema(uploadedData);
        assertTrue(StringUtils.isEmpty(result.getSchemaValidationErrorMessage()));

        input = this.getClass().getResourceAsStream("/ebinterface/4p0/ebinterface4-test1.xml");
        uploadedData = IOUtils.toByteArray(input);
        validator = new EbInterfaceValidator();
        result = validator.validateXMLInstanceAgainstSchema(uploadedData);
        assertTrue(StringUtils.isEmpty(result.getSchemaValidationErrorMessage()));

        // Invalid schema
        input = this.getClass().getResourceAsStream("/ebinterface/4p0/testinstance-invalid-schema.xml");
        uploadedData = IOUtils.toByteArray(input);
        validator = new EbInterfaceValidator();
        result = validator.validateXMLInstanceAgainstSchema(uploadedData);
        assertFalse(StringUtils.isEmpty(result.getSchemaValidationErrorMessage()));

        //Invalid schema with non-qualified attributes
        input = this.getClass().getResourceAsStream("/ebinterface/4p0/ebinterface4-test1-noprefix.xml");
        uploadedData = IOUtils.toByteArray(input);
        validator = new EbInterfaceValidator();
        result = validator.validateXMLInstanceAgainstSchema(uploadedData);
        assertFalse(StringUtils.isEmpty(result.getSchemaValidationErrorMessage()));



    }



    @Test
    public void test4p0SchemaValidatorWithSignedSamples() throws IOException {

        InputStream input;
        byte[]  uploadedData;
        EbInterfaceValidator validator;
        ValidationResult result;


        //Test a sample with is entirely incorrect (signature as ROOT element, which is not allowed)
        input = this.getClass().getResourceAsStream("/ebinterface/4p0/ebinterface4_signed_and_invalid.xml");
        uploadedData = IOUtils.toByteArray(input);
        validator = new EbInterfaceValidator();
        result = validator.validateXMLInstanceAgainstSchema(uploadedData);
        //Must be ebinterface 4p0
        assertEquals(EbInterfaceVersion.E4P0, result.getDeterminedEbInterfaceVersion());
        //Must be signed
        assertEquals(true, result.getDeterminedEbInterfaceVersion().isSigned());
        //Signature is invalid - thus no response
        assertNull(result.getVerifyDocumentResponse());
        //Signature validation exception message must be present
        assertFalse(StringUtils.isEmpty(result.getSignatureValidationExceptionMessage()));

        //Test a correctly signed sample
        //TODO - since 2014-07-24 the valid sample does not work any more (although the sample validates correctly
        //on the Web interface)

//        input = this.getClass().getResourceAsStream("/ebinterface/4p0/ebinterface4_signed_and_valid.xml");
//        uploadedData = IOUtils.toByteArray(input);
//        validator = new EbInterfaceValidator();
//        result = validator.validateXMLInstanceAgainstSchema(uploadedData);
//        //Must be ebinterface 4p0
//        assertEquals(EbInterfaceVersion.E4P0, result.getDeterminedEbInterfaceVersion());
//        //Must be signed
//        assertEquals(true, result.getDeterminedEbInterfaceVersion().isSigned());
//        //Signature must be valid - i.e. there must be an answer from the signature service
//        assertNotNull(result.getVerifyDocumentResponse());



    }


    /**
     * Test the schema validator
     *
     * @throws IOException
     */
    @Test
    public void test3p02SchemaValidator() throws IOException {

        // Valid schema
        InputStream input = this.getClass().getResourceAsStream("/ebinterface/3p02/InvoiceExample1.xml");

        assertNotNull(input);

        // Step 1 - validate against the schema
        EbInterfaceValidator validator = new EbInterfaceValidator();
        byte[] uploadedData = IOUtils.toByteArray(input);
        ValidationResult result = validator.validateXMLInstanceAgainstSchema(uploadedData);
        assertTrue(StringUtils.isEmpty(result.getSchemaValidationErrorMessage()));

        input = this.getClass().getResourceAsStream("/ebinterface/3p02/InvoiceExample2.xml");
        validator = new EbInterfaceValidator();
        uploadedData = IOUtils.toByteArray(input);
        result = validator.validateXMLInstanceAgainstSchema(uploadedData);
        assertTrue(StringUtils.isEmpty(result.getSchemaValidationErrorMessage()));

        input = this.getClass().getResourceAsStream("/ebinterface/3p02/valid_and_signed.xml");
        validator = new EbInterfaceValidator();
        uploadedData = IOUtils.toByteArray(input);
        result = validator.validateXMLInstanceAgainstSchema(uploadedData);
        assertTrue(StringUtils.isEmpty(result.getSchemaValidationErrorMessage()));

        // Invalid schema
        input = this.getClass().getResourceAsStream("/ebinterface/3p02/InvoiceExample-invalid.xml");
        validator = new EbInterfaceValidator();
        uploadedData = IOUtils.toByteArray(input);
        result = validator.validateXMLInstanceAgainstSchema(uploadedData);
        assertFalse(StringUtils.isEmpty(result.getSchemaValidationErrorMessage()));

        System.out.println(result);

    }


    /**
     * Test the schema validator
     *
     * @throws IOException
     */
    @Test
    public void test3p0SchemaValidator() throws IOException {

        // Valid schema
        InputStream input = this.getClass().getResourceAsStream("/ebinterface/3p0/InvoiceExample1.xml");

        assertNotNull(input);

        // Step 1 - validate against the schema
        byte[] uploadedData = IOUtils.toByteArray(input);
        EbInterfaceValidator validator = new EbInterfaceValidator();
        ValidationResult result = validator.validateXMLInstanceAgainstSchema(uploadedData);
        assertTrue(StringUtils.isEmpty(result.getSchemaValidationErrorMessage()));

        input = this.getClass().getResourceAsStream("/ebinterface/3p0/valid1.xml");
        uploadedData = IOUtils.toByteArray(input);
        validator = new EbInterfaceValidator();
        result = validator.validateXMLInstanceAgainstSchema(uploadedData);
        assertTrue(StringUtils.isEmpty(result.getSchemaValidationErrorMessage()));

        input = this.getClass().getResourceAsStream("/ebinterface/3p0/valid2.xml");
        uploadedData = IOUtils.toByteArray(input);
        validator = new EbInterfaceValidator();
        result = validator.validateXMLInstanceAgainstSchema(uploadedData);
        assertTrue(StringUtils.isEmpty(result.getSchemaValidationErrorMessage()));

        input = this.getClass().getResourceAsStream("/ebinterface/3p0/valid3.xml");
        uploadedData = IOUtils.toByteArray(input);
        validator = new EbInterfaceValidator();
        result = validator.validateXMLInstanceAgainstSchema(uploadedData);
        assertTrue(StringUtils.isEmpty(result.getSchemaValidationErrorMessage()));

        input = this.getClass().getResourceAsStream("/ebinterface/3p0/valid4.xml");
        uploadedData = IOUtils.toByteArray(input);
        validator = new EbInterfaceValidator();
        result = validator.validateXMLInstanceAgainstSchema(uploadedData);
        assertTrue(StringUtils.isEmpty(result.getSchemaValidationErrorMessage()));

        input = this.getClass().getResourceAsStream("/ebinterface/3p0/valid5.xml");
        uploadedData = IOUtils.toByteArray(input);
        validator = new EbInterfaceValidator();
        result = validator.validateXMLInstanceAgainstSchema(uploadedData);
        assertTrue(StringUtils.isEmpty(result.getSchemaValidationErrorMessage()));

        input = this.getClass().getResourceAsStream("/ebinterface/3p0/valid6.xml");
        uploadedData = IOUtils.toByteArray(input);
        validator = new EbInterfaceValidator();
        result = validator.validateXMLInstanceAgainstSchema(uploadedData);
        assertTrue(StringUtils.isEmpty(result.getSchemaValidationErrorMessage()));

        // Invalid schema
        input = this.getClass().getResourceAsStream("/ebinterface/3p0/InvoiceExample-invalid.xml");
        uploadedData = IOUtils.toByteArray(input);
        validator = new EbInterfaceValidator();
        result = validator.validateXMLInstanceAgainstSchema(uploadedData);
        assertFalse(StringUtils.isEmpty(result.getSchemaValidationErrorMessage()));

        System.out.println(result);

    }

    /**
     * Test the SVNR numbers
     *
     * @throws IOException
     */
    @Test
    public void testSchematronValidatorSVNR() throws IOException {

        // CASE 1
        // Test a file with no SVNR - no rule shall be fired
        InputStream input = this.getClass().getResourceAsStream("/ebinterface/4p0/testinstance-no-svnr.xml");
        byte[] uploadedData = IOUtils.toByteArray(input);
        final String schematronFile = Rules.getRule("Sozialversicherung (ebInterface 4p0)", EbInterfaceVersion.E4P0).getFileReference();
        assertNotNull(input);

        final EbInterfaceValidator validator = new EbInterfaceValidator();
        Result result = validator.validateXMLInstanceAgainstSchematron(uploadedData, schematronFile);
        List<Result.Error> errors = result.getErrors();

        assertTrue(errors.size() == 0);

        // CASE 2
        // Test a file with two valid SVNR
        input = this.getClass().getResourceAsStream("/ebinterface/4p0/testinstance-valid-svnr.xml");
        uploadedData = IOUtils.toByteArray(input);
        assertNotNull(input);

        result = validator.validateXMLInstanceAgainstSchematron(uploadedData, schematronFile);
        errors = result.getErrors();

        assertTrue(errors.size() == 0);

        // CASE 3
        // Test a file with one invalid SVNR
        input = this.getClass().getResourceAsStream("/ebinterface/4p0/testinstance-invalid-svnr.xml");
        uploadedData = IOUtils.toByteArray(input);
        assertNotNull(input);

        result = validator.validateXMLInstanceAgainstSchematron(uploadedData, schematronFile);
        errors = result.getErrors();

        assertTrue(errors.size() > 0);

    }

    /**
     * Test the schematron validator
     *
     * @throws IOException
     */
    @Test
    public void testSchematronValidatorSVBillersContractPartnerNumber() throws IOException {

        // CASE 1
        // Test a file where the biller contract partner number is not present
        InputStream input = this.getClass()
                .getResourceAsStream("/ebinterface/4p0/testinstance-no-billerscontractpartnernumberpresent.xml");
        byte[] uploadedData = IOUtils.toByteArray(input);
        final String schematronFile = Rules.getRule("Sozialversicherung (ebInterface 4p0)", EbInterfaceVersion.E4P0).getFileReference();
        assertNotNull(input);

        // No rule must fire in this case and no error must be produced
        final EbInterfaceValidator validator = new EbInterfaceValidator();
        Result result = validator.validateXMLInstanceAgainstSchematron(uploadedData, schematronFile);
        List<Result.Error> errors = result.getErrors();

        assertTrue(errors.size() == 0);

        // CASE 2
        // Test a file with a valid biller contract partner number
        input = this.getClass()
                .getResourceAsStream("/ebinterface/4p0/testinstance-valid-billerscontractpartnernumber.xml");
        uploadedData = IOUtils.toByteArray(input);
        assertNotNull(input);

        // Rule must fire but no error must be produced
        result = validator.validateXMLInstanceAgainstSchematron(uploadedData, schematronFile);
        errors = result.getErrors();

        assertTrue(errors.size() == 0);

        // CASE 3
        // Test a file with a invalid biller contract partner number
        input = this.getClass()
                .getResourceAsStream("/ebinterface/4p0/testinstance-invalid-billerscontractpartnernumber.xml");
        uploadedData = IOUtils.toByteArray(input);
        assertNotNull(input);

        // Rule must fire and error must be produced
        result = validator.validateXMLInstanceAgainstSchematron(uploadedData, schematronFile);
        errors = result.getErrors();
        assertTrue(errors.size() > 0);
        printErrors(errors);

    }



    @Test
    public void testXXEExploit() throws IOException {

        InputStream input = this.getClass().getResourceAsStream("/ebinterface/4p0/xxe-exploit.xml");
        Assert.assertNotNull(input);
        byte [] uploadedData = IOUtils.toByteArray(input);
        EbInterfaceValidator validator = new EbInterfaceValidator();
        ValidationResult result = validator.validateXMLInstanceAgainstSchema(uploadedData);
        assertFalse(StringUtils.isEmpty(result.getSchemaValidationErrorMessage()));
    }

    /**
     * Print the errors
     *
     * @param errors
     */
    private void printErrors(final List<Result.Error> errors) {
        for (final Result.Error error : errors) {
            out("Violating element: " + error.getViolatingElement() + " Error message: " + error.getErrorMessage());
        }
    }

    private void out(final String s) {
        System.out.println(s);
    }

}
