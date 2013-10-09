package at.ebinterface.validation.parser;

import java.io.InputStream;

import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;

import org.apache.commons.lang.StringUtils;
import org.xml.sax.InputSource;

import at.ebinterface.validation.exception.NamespaceUnknownException;
import at.ebinterface.validation.validator.EbInterfaceVersion;

/**
 * Custom parser for XML instances. Used to determine the used XML Schema based
 * on the namespace
 * 
 * @author pl
 * 
 */
public enum CustomParser {
	
	INSTANCE;

	private static CustomHandler customHandler;
	private static SAXParser saxParser;

	static {

		SAXParserFactory factory = SAXParserFactory.newInstance();
		try {
			saxParser = factory.newSAXParser();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}

		customHandler = new CustomHandler();
	}

	/**
	 * Determines the correct ebInterface version
	 * 
	 * @param stream
	 * @return
	 */
	public EbInterfaceVersion getEbInterfaceDetails(InputSource source) throws NamespaceUnknownException {

		//Get the namespace from the instace
		try {
			saxParser.parse(source, customHandler);
		} catch (Exception e) {
			throw new NamespaceUnknownException("Der Namespace des Invoice-ROOT Elements konnte nicht bestimmt werden.");
		}

		
		//Map it to an enumeration
		if (!StringUtils.isEmpty(customHandler.getFoundNameSpace())) {
			for (EbInterfaceVersion v : EbInterfaceVersion.values()) {
				if (v.getNamespace().equals(customHandler.getFoundNameSpace())) {
					//Set whether its signed or not
					v.setSigned(customHandler.isContainsSignature());
					//Set the NS of the Signature element
					v.setSignatureNamespacePrefix(customHandler.getSignatureNamespacePrefix());
					return v;
				}
			}
		}
		

		throw new NamespaceUnknownException("Unbekannter Namespace gefunden: " + customHandler.getFoundNameSpace());

	}
	
	
	/**
	 * Determines the ebInterface version of the upload
	 * @param inputStream
	 * @return
	 * @throws NamespaceUnknownException
	 */
	public EbInterfaceVersion getEbInterfaceDetails(InputStream inputStream) throws NamespaceUnknownException {
		return getEbInterfaceDetails(new InputSource(inputStream));		
	}
	
	
	

}
