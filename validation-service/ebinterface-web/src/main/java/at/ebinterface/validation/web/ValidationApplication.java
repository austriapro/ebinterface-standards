package at.ebinterface.validation.web;

import org.apache.wicket.Page;
import org.apache.wicket.RuntimeConfigurationType;
import org.apache.wicket.protocol.http.WebApplication;

import at.ebinterface.validation.web.pages.StartPage;


/**
 * The application class for the ebInterface validation application
 * @author pl
 *
 */
public class ValidationApplication extends WebApplication {

	
	
	/** Defines wether the application shall be started in develop or deployment mode */
	private static RuntimeConfigurationType CONFIGURATION_TYPE = RuntimeConfigurationType.DEVELOPMENT;
	
	
	
	/**
	 * Returns the configuration type (develop or deployment)
	 */
	@Override
	public RuntimeConfigurationType getConfigurationType() {
		
		return CONFIGURATION_TYPE;

	}
	
	
	/**
	 * Returns the home page
	 */
	@Override
	public Class<? extends Page> getHomePage() {
		return StartPage.class;
	}

}
