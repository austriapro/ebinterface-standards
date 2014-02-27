package at.ebinterface.validation.web.pages;

import org.apache.commons.lang.StringUtils;
import org.apache.wicket.behavior.AttributeAppender;
import org.apache.wicket.markup.html.WebMarkupContainer;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.link.Link;
import org.apache.wicket.markup.html.panel.EmptyPanel;
import org.apache.wicket.model.IModel;
import org.apache.wicket.model.Model;

import at.ebinterface.validation.validator.ValidationResult;
import at.ebinterface.validation.validator.jaxb.Result;
import at.ebinterface.validation.web.pages.StartPage.ActionType;
import at.ebinterface.validation.web.panels.ErrorDetailsPanel;

/**
 * Used to show the results of a validation
 * @author pl
 *
 */
public class ResultPage extends BasePage {


  /**
   * Create a new result page
   * @param validationResult
   * @param selectedSchematron
   * @param selectedAction
   */
  public ResultPage(final ValidationResult validationResult, final String selectedSchematron, final ActionType selectedAction) {

    final StringBuffer schemaVersion = new StringBuffer();
    schemaVersion.append(validationResult.getDeterminedEbInterfaceVersion().getCaption());
    if (validationResult.getDeterminedEbInterfaceVersion() != null && validationResult.getDeterminedEbInterfaceVersion().isSigned()) {
      schemaVersion.append(" (signiert)");
    }
    else {
      schemaVersion.append(" (unsigniert)");
    }

    //Add a label with the schema version
    add(new Label("schemaVersion", Model.of(schemaVersion.toString())));

    //Schema OK Container
    final WebMarkupContainer schemaOkContainer = new WebMarkupContainer("schemvalidationOK");
    add(schemaOkContainer);

    //Schema NOK Container
    final WebMarkupContainer schemaNOkContainer = new WebMarkupContainer("schemvalidationNOK");
    schemaNOkContainer.add(new Label("schemaValidationError", Model.of(validationResult.getSchemaValidationErrorMessage())));
    add(schemaNOkContainer);

    //Is there a schema validation message?
    //Schema is OK
    if (StringUtils.isEmpty(validationResult.getSchemaValidationErrorMessage())) {
      schemaOkContainer.setVisible(true);
      schemaNOkContainer.setVisible(false);
    }
    //Schema NOK
    else {
      schemaOkContainer.setVisible(false);
      schemaNOkContainer.setVisible(true);
    }



    //Signature result container
    final WebMarkupContainer signatureResultContainer = new WebMarkupContainer("signatureResultContainer");
    //If no signature is applied we do not show the containers
    if (validationResult.getDeterminedEbInterfaceVersion() == null || !validationResult.getDeterminedEbInterfaceVersion().isSigned()) {
      signatureResultContainer.setVisibilityAllowed(false);
    }

    //Set the certificate details
    signatureResultContainer.add(new Label("certificateQualified", getBooleanAsString(validationResult.getCertificateOfSignatorQualified())));
    signatureResultContainer.add(new Label("certificateFromAPublicAuthority", getBooleanAsString(validationResult.getCertificateOfSignatorFromAPublicAuthority())));

    signatureResultContainer.add(new Label("issuer", Model.of(validationResult.getCertificateIssuer())));
    signatureResultContainer.add(new Label("subject", Model.of(validationResult.getCertificateSubject())));
    signatureResultContainer.add(new Label("serialNumber", Model.of(validationResult.getCertificateSerialNumber())));



    Label signatureResult;
    Label certificateResult;

    //Certificate result
    if (validationResult.isCertificateOK()) {
      certificateResult = new Label("certificateResult", Model.of("Zertifikat gültig."));
      certificateResult.add(new AttributeAppender("class", Model.of("alert alert-success")));
    }
    else {
      certificateResult = new Label("certificateResult", Model.of("Zertifikat ungültig."));
      certificateResult.add(new AttributeAppender("class", Model.of("alert alert-error")));
    }

    //Signature result
    if (validationResult.isSignatureOK()) {
      signatureResult = new Label("signatureResult", Model.of("Signatur gültig."));
      signatureResult.add(new AttributeAppender("class", Model.of("alert alert-success")));
    }
    else {
      signatureResult = new Label("signatureResult", Model.of("Signatur ungültig."));
      signatureResult.add(new AttributeAppender("class", Model.of("alert alert-error")));
    }

    signatureResultContainer.add(signatureResult);
    signatureResultContainer.add(certificateResult);
    add(signatureResultContainer);


    //Schematron OK Container
    final WebMarkupContainer schematronOkContainer = new WebMarkupContainer("schematronOK");

    //Add a label with the selected Schematron
    schematronOkContainer.add(new Label("selectedSchematron", Model.of(selectedSchematron)));
    add(schematronOkContainer);

    //Schematron NOK Container
    final WebMarkupContainer schematronNokContainer = new WebMarkupContainer("schematronNOK");

    schematronNokContainer.add(new Label("selectedSchematron", Model.of(selectedSchematron)));

    final Result schematronResult = validationResult.getResult();

    //Add schematron error messages if there some
    if (schematronResult == null || schematronResult.getErrors() == null || schematronResult.getErrors().size() == 0) {
      schematronNokContainer.add(new EmptyPanel("errorDetailsPanel"));
    }
    else {
      schematronNokContainer.add(new ErrorDetailsPanel("errorDetailsPanel", schematronResult.getErrors()));
    }

    add(schematronNokContainer);

    //In case the Schema validation failed, or only schema validation is turned on we do not show anything about the schematron
    if (selectedAction == ActionType.SCHEMA_VALIDATION || !StringUtils.isEmpty(validationResult.getSchemaValidationErrorMessage())) {
      schematronOkContainer.setVisible(false);
      schematronNokContainer.setVisible(false);
    }
    //Are there schematron validation messages?
    //Everything OK
    else if (schematronResult == null || schematronResult.getErrors() == null  || schematronResult.getErrors().size() == 0) {
      schematronOkContainer.setVisible(true);
      schematronNokContainer.setVisible(false);
    }
    //NOK
    else {
      schematronOkContainer.setVisible(false);
      schematronNokContainer.setVisible(true);
    }


    add(new Link<Object>("returnLink") {
      @Override
      public void onClick() {
        setResponsePage(StartPage.class);
      }
    });


  }


  /**
   * Returns a correct String for a Boolean value
   * @param b
   * @return
   */
  private IModel<String> getBooleanAsString(final Boolean b) {
    if (b == null) {
      return Model.of("-");
    }
    else if (b.equals(Boolean.TRUE)) {
      return Model.of("ja");
    }
    else {
      return Model.of("nein");
    }
  }





}

