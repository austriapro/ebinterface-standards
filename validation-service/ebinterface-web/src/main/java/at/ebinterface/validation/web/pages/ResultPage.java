package at.ebinterface.validation.web.pages;

import at.ebinterface.validation.dto.SignatureValidationResult;
import at.ebinterface.validation.validator.ValidationResult;
import at.ebinterface.validation.validator.jaxb.Result;
import at.ebinterface.validation.web.pages.StartPage.ActionType;
import at.ebinterface.validation.web.panels.ErrorDetailsPanel;
import org.apache.commons.lang.StringUtils;
import org.apache.wicket.markup.html.WebMarkupContainer;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.link.Link;
import org.apache.wicket.markup.html.panel.EmptyPanel;
import org.apache.wicket.model.Model;

/**
 * Used to show the results of a validation
 *
 * @author pl
 */
public class ResultPage extends BasePage {


    /**
     * Create a new result page
     *
     * @param validationResult
     * @param selectedSchematron
     * @param selectedAction
     */
    public ResultPage(final ValidationResult validationResult, final String selectedSchematron, final ActionType selectedAction) {

        final StringBuffer schemaVersion = new StringBuffer();

        if (validationResult.getDeterminedEbInterfaceVersion() != null) {
            schemaVersion.append(validationResult.getDeterminedEbInterfaceVersion().getCaption());
            if (validationResult.getDeterminedEbInterfaceVersion().isSigned()) {
                schemaVersion.append(" (signiert)");
            } else {
                schemaVersion.append(" (unsigniert)");
            }
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
        WebMarkupContainer signatureResultContainer = new WebMarkupContainer("signatureResultContainer");
        //If no signature is applied we do not show the containers
        if (validationResult.getDeterminedEbInterfaceVersion() == null || !validationResult.getDeterminedEbInterfaceVersion().isSigned()) {
            signatureResultContainer.setVisibilityAllowed(false);
        }


        //Get the result details for the signature
        SignatureValidationResult signatureValidationResult = new SignatureValidationResult(validationResult.getVerifyDocumentResponse());


        //Signature
        signatureResultContainer.add(new Label("signatureResult", Model.of(signatureValidationResult.isSignatureValid() ? "gültig" : "ungültig")));
        signatureResultContainer.add(new Label("signatureText", Model.of(signatureValidationResult.getSignatureText())));

        //Certificate
        signatureResultContainer.add(new Label("certificateResult", Model.of(signatureValidationResult.isCertificateValid() ? "gültig" : "ungültig")));
        signatureResultContainer.add(new Label("certificateText", Model.of(signatureValidationResult.getCertificateText())));

        //Manifest
        signatureResultContainer.add(new Label("manifestResult", Model.of(signatureValidationResult.isManifestValid() ? "gültig" : "ungültig")));
        signatureResultContainer.add(new Label("manifestText", Model.of(signatureValidationResult.getManifestText())));


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
        } else {
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
        else if (schematronResult == null || schematronResult.getErrors() == null || schematronResult.getErrors().size() == 0) {
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


}

