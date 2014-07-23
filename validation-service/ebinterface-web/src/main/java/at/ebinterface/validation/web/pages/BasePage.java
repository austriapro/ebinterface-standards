package at.ebinterface.validation.web.pages;

import at.ebinterface.validation.web.pages.images.ImagesLogoAccessor;
import org.apache.wicket.markup.html.WebPage;
import org.apache.wicket.markup.html.image.Image;
import org.apache.wicket.request.resource.PackageResourceReference;

/**
 * Base page for all web pages
 *
 * @author pl
 */
public abstract class BasePage extends WebPage {


    /**
     *
     */
    public BasePage() {

        //Add the ebInterface Logo
        add(new Image("ebInterfaceLogo", new PackageResourceReference(ImagesLogoAccessor.class, "ebInterfaceLogo.jpg")));


    }


}
