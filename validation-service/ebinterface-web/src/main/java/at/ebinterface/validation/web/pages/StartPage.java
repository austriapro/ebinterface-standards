package at.ebinterface.validation.web.pages;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.wicket.feedback.ContainerFeedbackMessageFilter;
import org.apache.wicket.markup.html.form.DropDownChoice;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.SubmitLink;
import org.apache.wicket.markup.html.form.upload.FileUpload;
import org.apache.wicket.markup.html.form.upload.FileUploadField;
import org.apache.wicket.markup.html.image.Image;
import org.apache.wicket.markup.html.panel.FeedbackPanel;
import org.apache.wicket.model.CompoundPropertyModel;
import org.apache.wicket.model.ResourceModel;
import org.apache.wicket.request.resource.PackageResourceReference;
import org.apache.wicket.util.io.IOUtils;

import at.ebinterface.validation.validator.EbInterfaceValidator;
import at.ebinterface.validation.validator.EbInterfaceVersion;
import at.ebinterface.validation.validator.Rules;
import at.ebinterface.validation.validator.ValidationResult;
import at.ebinterface.validation.validator.jaxb.Result;
import at.ebinterface.validation.web.model.InputModel;
import at.ebinterface.validation.web.pages.images.ImagesLogoAccessor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * First page of the ebInterface Validation Service
 * @author pl
 *
 */
public class StartPage extends BasePage {

  /** The three possible actions */
  public enum ActionType {SCHEMA_VALIDATION, SCHEMA_AND_SCHEMATRON_VALIDATION, VISUALIZATION}


    private static final Logger LOG = LoggerFactory.getLogger(StartPage.class.getName());

  /**
   * Construc the start page
   */
  public StartPage() {


    //Add the input form
    final InputForm inputForm = new InputForm("inputForm");
    add(inputForm);


    //Add the form for showing the supported rules
    final ShowRulesForm showRulesForm = new ShowRulesForm("showRulesForm");
    add(showRulesForm);


  }


  /**
   * Form for showing the rules which are currently supported
   * @author pl
   *
   */
  private class ShowRulesForm extends Form {

    /** Panel for providing feedback in case of errorneous input */
    FeedbackPanel feedbackPanel;

    /** Dropdown choice for the schmeatrno rules */
    DropDownChoice rules;

    public ShowRulesForm(final String id) {
      super(id);

      //Add a feedback panel
      feedbackPanel = new FeedbackPanel("feedback", new ContainerFeedbackMessageFilter(this));
      feedbackPanel.setVisible(false);
      add(feedbackPanel);


      //Get the currently supported rules
      final List ruleValues = Rules.getRuleslist();

      //Add the drop down choice for the different rules which are currently supported
      rules = new DropDownChoice("ruleSelector", new CompoundPropertyModel<InputModel>(new InputModel()), ruleValues);
      add(rules);

      //Add a submit button
      add(new SubmitLink("showSchematron"));
    }

    @Override
    protected void onSubmit() {
      // TODO Auto-generated method stub
      super.onSubmit();

      //Did the user select a schematron file?
      if (rules.getModelObject() == null || rules.getModelObject().toString().equals("")) {
        error(new ResourceModel("ruleSelector.NoSelected").getObject());
        onError();
        return;
      }

      //Bundesrechenzentrum is currently not supported
      if (rules.getModelObject().toString().equals(Rules.BRZ)) {
        error("BRZ wird im Moment noch nicht unterstützt.");
        onError();
        return;
      }


      //Get the selected Schematron
      final String schematronRuleFile = Rules.getSchematronFile(rules.getModelObject().toString());
      final String selectedSchematronRule = rules.getModelObject().toString();

      //Redirect
      setResponsePage(new ShowRulesPage(selectedSchematronRule, schematronRuleFile));
    }


    /**
     * Process errors
     */
    @Override
    protected void onError() {
      //Show the feedback panel in case on an error
      feedbackPanel.setVisible(true);
    }
  }


  /**
   * The input form class
   * @author pl
   *
   */
  private class InputForm extends Form {



    /** Panel for providing feedback in case of errorneous input */
    FeedbackPanel feedbackPanel;

    /** Dropdown choice for the schmeatrno rules */
    DropDownChoice rules;

    /** Upload field for the ebInterface instance */
    FileUploadField fileUploadField;

    public InputForm(final String id) {
      super(id);

      //Set the form to multi part since we use file upload
      setMultiPart(true);

      //Add a feedback panel
      feedbackPanel = new FeedbackPanel("feedback", new ContainerFeedbackMessageFilter(this));
      feedbackPanel.setVisible(false);
      add(feedbackPanel);


      //Add the file upload field
      fileUploadField = new FileUploadField("fileInput");
      fileUploadField.setRequired(true);
      add(fileUploadField);


      //Get the currently supported rules
      final List ruleValues = Rules.getRuleslist();

      //Add the drop down choice for the different rules which are currently supported
      rules = new DropDownChoice("ruleSelector", new CompoundPropertyModel<InputModel>(new InputModel()), ruleValues);
      add(rules);

      //Add a second submit button
      add(new SubmitLink("submitButtonSchemaOnly") {
        @Override
        public void onSubmit() {
          submit(ActionType.SCHEMA_VALIDATION);
        }
      });


      //Add a submit button
      add(new SubmitLink("submitButtonSchematron") {
        @Override
        public void onSubmit() {
          submit(ActionType.SCHEMA_AND_SCHEMATRON_VALIDATION);
        }
      });


      //Add a button to visualize
      add(new SubmitLink("submitButtonVisualize") {
        @Override
        public void onSubmit() {
          submit(ActionType.VISUALIZATION);
        }
      });





      //Add a reset button - if clicked we reload the page
      final SubmitLink resetButton = new SubmitLink("resetButton") {
        @Override
        public void onSubmit() {
          this.getPage().setResponsePage(StartPage.class);
        }
      };
      resetButton.setDefaultFormProcessing(false);
      add(resetButton);

    }

    /**
     * Process the input
     */
    protected void submit(final ActionType selectedAction) {

      //Hide the feedback panel first (will be shown in case of an error)
      feedbackPanel.setVisible(false);


      //Get the selected schematron rule
      String schematronRuleFile = "";
      String selectedSchematronRule = "";

      //Schematron validation?
      //Schematron set must be selected
      if (selectedAction == ActionType.SCHEMA_AND_SCHEMATRON_VALIDATION) {
        if (rules.getModelObject() == null) {
          error(new ResourceModel("ruleSelector.Required").getObject());
          onError();
          return;
        }

        //Get the selected schematron rule
        schematronRuleFile = Rules.getSchematronFile(rules.getModelObject().toString());
        selectedSchematronRule = rules.getModelObject().toString();

        //Bundesrechenzentrum is currently not supported
        if (selectedSchematronRule.equals(Rules.BRZ)) {
          error("BRZ wird im Moment noch nicht unterstützt.");
          onError();
          return;
        }

      }

      //Get the file input
      final FileUpload upload = fileUploadField.getFileUpload();
      byte [] uploadedData = null;

      try {
        final InputStream inputStream = upload.getInputStream();
        uploadedData = IOUtils.toByteArray(inputStream);
      } catch (final IOException e) {
        LOG.error("Unable to get content of uploaded file", e);
      }

      //Validate the XML instance
      final EbInterfaceValidator validator = new EbInterfaceValidator();
      final ValidationResult validationResult = validator.validateXMLInstanceAgainstSchema(uploadedData);


      //Schematron validation too?
      if (selectedAction == ActionType.SCHEMA_AND_SCHEMATRON_VALIDATION) {
        //Schematron validation may only be started in case of ebInterface 4p0
        if (validationResult.getDeterminedEbInterfaceVersion() == EbInterfaceVersion.E4P0) {
          //Invoke the validation
          final Result r = validator.validateXMLInstanceAgainstSchematron(uploadedData, schematronRuleFile);
          validationResult.setResult(r);
        }
        //Wrong ebInterface version
        else {
          error("Schematronregeln können nur auf ebInterface 4.0 Instanzen angewendet werden. Erkannte ebInterface Version ist jedoch: " + validationResult.getDeterminedEbInterfaceVersion().getCaption());
          onError();
          return;
        }
      }
      //Visualization?
      else if (selectedAction == ActionType.VISUALIZATION) {
        //Visualization is only possible for valid instances
        if (!StringUtils.isEmpty(validationResult.getSchemaValidationErrorMessage())) {
          error("Die gewählte ebInterface Instanz ist nicht valide. Es können nur valide Schemainstanzen in der Druckansicht angezeigt werden.");
          onError();
          return;
        }

        //Get the transformed string
        final String s = validator.transformInput(uploadedData, validationResult.getDeterminedEbInterfaceVersion());
        //Redirect to the printview page
        setResponsePage(new PrintViewPage(s));
        return;


      }


      //Redirect to the result page
      setResponsePage(new ResultPage(validationResult, selectedSchematronRule, selectedAction));

    }

    /**
     * Process errors
     */
    @Override
    protected void onError() {
      //Show the feedback panel in case on an error
      feedbackPanel.setVisible(true);
    }
  }


}
