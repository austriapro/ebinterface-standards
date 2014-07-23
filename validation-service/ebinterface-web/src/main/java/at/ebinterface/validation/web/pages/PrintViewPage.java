package at.ebinterface.validation.web.pages;

import org.apache.wicket.markup.html.WebPage;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.model.Model;

/**
 * Page for showing the print view of an ebInterface instance
 *
 * @author pl
 */
public class PrintViewPage extends WebPage {


    public PrintViewPage(final String xsltOutput) {

        final Label printViewLabel = new Label("printViewPanel", Model.of(xsltOutput));
        printViewLabel.setEscapeModelStrings(false);
        add(printViewLabel);

    }


}
