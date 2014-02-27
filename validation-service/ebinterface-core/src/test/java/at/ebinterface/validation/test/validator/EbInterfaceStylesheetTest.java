package at.ebinterface.validation.test.validator;

import java.io.IOException;
import java.io.InputStream;

import org.apache.wicket.util.io.IOUtils;
import org.junit.Assert;
import org.junit.Test;

import at.ebinterface.validation.validator.EbInterfaceValidator;
import at.ebinterface.validation.validator.EbInterfaceVersion;

/**
 * Used to test the application of stylesheets
 * @author pl
 *
 */
public class EbInterfaceStylesheetTest {

	
	
	
	@Test
	public void testApplyStylesheet() throws IOException {
		
		//3p02
		InputStream input = this.getClass().getResourceAsStream("/ebinterface/3p02/InvoiceExample1.xml");		
		Assert.assertNotNull(input);	
		byte [] inputData = IOUtils.toByteArray(input);
		
		EbInterfaceValidator validator = new EbInterfaceValidator();		
		String s = validator.transformInput(inputData, EbInterfaceVersion.E3P02);
		System.out.print(s);
		Assert.assertFalse(hasError(s));
		
		//3p0
		input = this.getClass().getResourceAsStream("/ebinterface/3p0/InvoiceExample1.xml");		
		Assert.assertNotNull(input);	
		inputData = IOUtils.toByteArray(input);			
		s = validator.transformInput(inputData, EbInterfaceVersion.E3P0);
		Assert.assertFalse(hasError(s));
		System.out.print(s);
		
		//4p0
		input = this.getClass().getResourceAsStream("/ebinterface/4p0/ebinterface4-test1.xml");		
		Assert.assertNotNull(input);	
		inputData = IOUtils.toByteArray(input);			
		s = validator.transformInput(inputData, EbInterfaceVersion.E4P0);
		Assert.assertFalse(hasError(s));
		
		System.out.print(s);
		
		
	}
	
	
	
	private boolean hasError(String s) {
		return s.startsWith("XSLT Transformation konnte nicht ausgeführt werden");
	}
	
}
