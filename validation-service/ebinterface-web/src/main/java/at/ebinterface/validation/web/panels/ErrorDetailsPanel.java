package at.ebinterface.validation.web.panels;

import at.ebinterface.validation.validator.jaxb.Result;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.list.ListItem;
import org.apache.wicket.markup.html.list.ListView;
import org.apache.wicket.markup.html.panel.Panel;
import org.apache.wicket.model.Model;

import java.util.List;

/**
 * This class is used to show the generated error messages from the schematron validation
 *
 * @author pl
 */
public class ErrorDetailsPanel extends Panel {

    public ErrorDetailsPanel(String id, List<Result.Error> errors) {
        super(id);

        //Create a table with the error messages
        ListView<Result.Error> listview = new ListView<Result.Error>("repeater", errors) {
            @Override
            protected void populateItem(ListItem<Result.Error> item) {
                item.add(new Label("errorElement", Model.of(item.getModelObject().getViolatingElement())));
                item.add(new Label("errorMessage", Model.of(item.getModelObject().getErrorMessage())));
            }

        };
        this.add(listview);

    }


}
