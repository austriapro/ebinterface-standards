package at.ebinterface.validation.test.digitalsignatures;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.commons.io.IOUtils;
import org.junit.Assert;
import org.junit.Ignore;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import at.ebinterface.validation.digitalsignatures.MOASignatureValidator;
import at.ebinterface.validation.exception.NamespaceUnknownException;
import at.ebinterface.validation.parser.CustomParser;
import at.ebinterface.validation.validator.EbInterfaceVersion;
import at.gv.egovernment.moa.spss.api.xmlverify.VerifyXMLSignatureResponse;

public class SubmittedFilesTest
{

  public static final Logger LOG = LoggerFactory.getLogger (SubmittedFilesTest.class.getName ());

  @Test
  @Ignore
  public void testHandySignaturJosefBogad ()
  {
    // Should work but fails
    test ("/input-ebinterface-forum/josefbogad/TestRechnung20120525.xml");
    // Should work but fails
    test ("/input-ebinterface-forum/josefbogad/2012-123-2012-03-12.XML");
  }

  @Test
  @Ignore
  public void testHandySignaturJosefBogadRTR ()
  {
    // Should work but fails
    test ("/input-ebinterface-forum/josefbogad/rtr-2011-0001-2011-09-12.XML");
  }

  private void test (final String file)
  {

    // Valid instance
    final InputStream input = this.getClass ().getResourceAsStream (file);
    Assert.assertNotNull (input);

    try
    {
      // Get a byte array of the input stream in order to allow for reuse
      final ByteArrayOutputStream baos = new ByteArrayOutputStream ();
      IOUtils.copy (input, baos);
      final byte [] bytes = baos.toByteArray ();

      // Determine the ebInterface version
      EbInterfaceVersion version = null;
      try
      {
        version = CustomParser.INSTANCE.getEbInterfaceDetails (new InputSource (new ByteArrayInputStream (bytes)));

        LOG.debug ("File is signed {}", Boolean.toString (version.isSigned ()));
        LOG.debug ("Namespace prefix of Signature element is {}", version.getSignatureNamespacePrefix ());

      }
      catch (final NamespaceUnknownException e1)
      {
        LOG.error ("Failed to determine ebInterface version, ", e1);
        Assert.fail ();
      }

      if (version.isSigned ())
      {

        final VerifyXMLSignatureResponse verifyResponse = MOASignatureValidator.INSTANCE.validate (new ByteArrayInputStream (bytes),
                                                                                                   version.getSignatureNamespacePrefix ());
        Assert.assertEquals (0, verifyResponse.getSignatureCheck ().getCode ());
        Assert.assertEquals (0, verifyResponse.getCertificateCheck ().getCode ());
      }
      else
      {
        LOG.info ("Nothing to validate - file is not signed.");
      }

    }
    catch (final Exception e)
    {
      LOG.error ("Test failed", e);
      Assert.fail ();

    }

  }

  /**
   * read a Document from a given input stream
   * 
   * @param input
   *        stream pointing to an Xml document. Must not be null.
   * @return Document resulted from parsing input
   */
  public Document readDocument (final InputStream input) throws SAXException, IOException, ParserConfigurationException
  {

    final DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance ();
    dbf.setNamespaceAware (true);
    final Document doc = dbf.newDocumentBuilder ().parse (input);
    return doc;
  }

}
