package test.parser;

import at.ebinterface.validation.exception.NamespaceUnknownException;
import at.ebinterface.validation.parser.CustomParser;
import at.ebinterface.validation.validator.EbInterfaceVersion;
import org.junit.Assert;
import org.junit.Test;
import org.xml.sax.InputSource;

import java.io.InputStream;

/**
 * Used to test the custom parser class
 *
 * @author pl
 */
public class CustomParserTest {

    @Test
    public void testCustomParser() throws NamespaceUnknownException {


        // invalid text input
        InputStream inputStream = this.getClass().getResourceAsStream(
                "/ebinterface/2p2/textdummy.xml");
        InputSource source = new InputSource(inputStream);

        try {
            CustomParser.INSTANCE.getEbInterfaceDetails(source);
        } catch (NamespaceUnknownException ne) {
            Assert.assertNotNull(ne);
            System.out.println(ne.getMessage());
        }

        //Invalid binary dummy
        inputStream = this.getClass().getResourceAsStream(
                "/ebinterface/2p2/binarydummy.jpg");
        source = new InputSource(inputStream);

        try {
            CustomParser.INSTANCE.getEbInterfaceDetails(source);
        } catch (NamespaceUnknownException ne) {
            Assert.assertNotNull(ne);
            System.out.println(ne.getMessage());
        }

        // 2p2 - invalid
        inputStream = this.getClass().getResourceAsStream(
                "/ebinterface/2p2/Instance_2p2.xml");
        source = new InputSource(inputStream);

        try {
            CustomParser.INSTANCE.getEbInterfaceDetails(source);
        } catch (NamespaceUnknownException ne) {
            Assert.assertNotNull(ne);
            System.out.println(ne.getMessage());
        }

        // 3p0
        inputStream = this.getClass().getResourceAsStream(
                "/ebinterface/3p0/ebInterface_Instance_withExtension.xml");
        source = new InputSource(inputStream);

        Assert.assertEquals(EbInterfaceVersion.E3P0,
                CustomParser.INSTANCE.getEbInterfaceDetails(source));

        // 3p02
        inputStream = this.getClass().getResourceAsStream(
                "/ebinterface/3p02/InvoiceExample2.xml");
        source = new InputSource(inputStream);

        Assert.assertEquals(EbInterfaceVersion.E3P02,
                CustomParser.INSTANCE.getEbInterfaceDetails(source));

        inputStream = this.getClass().getResourceAsStream(
                "/ebinterface/3p02/InvoiceExample1.xml");
        source = new InputSource(inputStream);

        Assert.assertEquals(EbInterfaceVersion.E3P02,
                CustomParser.INSTANCE.getEbInterfaceDetails(source));

        // 4p0
        inputStream = this.getClass().getResourceAsStream(
                "/ebinterface/4p0/testinstance-valid-schema.xml");
        source = new InputSource(inputStream);

        Assert.assertEquals(EbInterfaceVersion.E4P0,
                CustomParser.INSTANCE.getEbInterfaceDetails(source));

        // 4p1
        inputStream = this.getClass().getResourceAsStream(
                "/ebinterface/4p1/ebInterface_4p1_sample.xml");
        source = new InputSource(inputStream);

        Assert.assertEquals(EbInterfaceVersion.E4P1,
                CustomParser.INSTANCE.getEbInterfaceDetails(source));


    }

}
