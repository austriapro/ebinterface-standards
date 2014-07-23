package at.ebinterface.validation.web;

import at.ebinterface.validation.web.pages.StartPage;
import org.apache.wicket.Page;
import org.apache.wicket.RuntimeConfigurationType;
import org.apache.wicket.protocol.http.WebApplication;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.net.URL;


/**
 * The application class for the ebInterface validation application
 *
 * @author pl
 */
public class ValidationApplication extends WebApplication {


    /**
     * Defines wether the application shall be started in develop or deployment mode
     */
    private static RuntimeConfigurationType CONFIGURATION_TYPE = RuntimeConfigurationType.DEVELOPMENT;

    private static final Logger LOG = LoggerFactory.getLogger(ValidationApplication.class.getName());

    static {
        //Set the manual keystore, otherwise the RTR certificate is not trusted
        try {
            URL url = ValidationApplication.class.getResource("/keystore.jks");
            LOG.info("Setting key store reference to {}", url.getPath());
            System.setProperty("javax.net.ssl.trustStore", url.getPath());
            System.setProperty("javax.net.ssl.trustStorePassword", "");

        } catch (Exception e1) {
            throw new RuntimeException("Error while reading SSL Keystore. Unable to proceed.", e1);
        }

    }


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
