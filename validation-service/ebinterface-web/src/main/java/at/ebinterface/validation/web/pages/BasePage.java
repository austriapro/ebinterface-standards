package at.ebinterface.validation.web.pages;

import org.apache.wicket.markup.html.IHeaderResponse;
import org.apache.wicket.markup.html.WebPage;
import org.apache.wicket.markup.html.image.Image;
import org.apache.wicket.request.resource.PackageResourceReference;

import at.ebinterface.validation.web.pages.images.ImagesLogoAccessor;

/**
 * Base page for all web pages
 * @author pl
 *
 */
public abstract class BasePage extends WebPage {

	
	 
	
	/**
	 *  
	 */
	public BasePage() {
		
		//Add the ebInterface Logo
		add(new Image("ebInterfaceLogo", new PackageResourceReference(ImagesLogoAccessor.class, "ebInterfaceLogo.jpg")));
		 
		 
	}
	
	
	
	
	
	
	@Override
	public void renderHead(IHeaderResponse response) {
		super.renderHead(response);
		
		// Add the necessary CSS references for bootstrap
		response.renderCSSReference(new PackageResourceReference(BasePage.class,
				"css/bootstrap.css"));
		response.renderCSSReference(new PackageResourceReference(BasePage.class,
				"css/bootstrap-responsive.css"));

	}
	
		
	
}
