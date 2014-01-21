package at.ebinterface.validation.web.pages;

import java.io.IOException;
import java.io.StringWriter;

import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.link.Link;
import org.apache.wicket.model.Model;
import org.apache.wicket.util.io.IOUtils;

import at.ebinterface.validation.web.components.CodeBox;



/**
 * Page for showing the details of Schematron rules
 * @author pl
 *
 */
public class ShowRulesPage extends BasePage {


  public ShowRulesPage(final String selectedSchematron, final String selectedSchematronFile) {

    //Add a label showing the selected Schematron file
    add(new Label("selectedSchematron", Model.of(selectedSchematron)));


    //Add a return link
    add(new Link<Object>("returnLink") {
      @Override
      public void onClick() {
        setResponsePage(StartPage.class);
      }
    });

    final StringWriter writer = new StringWriter();
    try {
      IOUtils.copy(this.getClass().getResourceAsStream(selectedSchematronFile), writer, "UTF-8");
    } catch (final IOException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }

    //Add the codebox for showing the schematron rules
    final CodeBox codeBox = new CodeBox("message", writer.toString()).setDisplayLineNumbers(true);
    add(codeBox);


  }

}
