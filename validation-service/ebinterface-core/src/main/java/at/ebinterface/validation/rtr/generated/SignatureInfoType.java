package at.ebinterface.validation.rtr.generated;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for SignatureInfoType complex type.
 * <p/>
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p/>
 * <pre>
 * &lt;complexType name="SignatureInfoType">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="InputData" type="{http://reference.e-government.gv.at/namespace/verificationservice/20120922#}ContentExLocRefBaseType" minOccurs="0"/>
 *         &lt;element name="SignerName" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="SignatureCheck" type="{http://reference.e-government.gv.at/namespace/verificationservice/20120922#}CheckResultType" minOccurs="0"/>
 *         &lt;element name="CertificateCheck" type="{http://reference.e-government.gv.at/namespace/verificationservice/20120922#}CheckResultType"/>
 *         &lt;element name="ManifestCheck" type="{http://reference.e-government.gv.at/namespace/verificationservice/20120922#}ManifestCheckType" minOccurs="0"/>
 *         &lt;element name="Annotations" type="{http://reference.e-government.gv.at/namespace/verificationservice/20120922#}AnnotationsType" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "SignatureInfoType", namespace = "http://reference.e-government.gv.at/namespace/verificationservice/20120922#", propOrder = {
        "inputData",
        "signerName",
        "signatureCheck",
        "certificateCheck",
        "manifestCheck",
        "annotations"
})
public class SignatureInfoType {

    @XmlElement(name = "InputData")
    protected ContentExLocRefBaseType inputData;
    @XmlElement(name = "SignerName", required = true)
    protected String signerName;
    @XmlElement(name = "SignatureCheck")
    protected CheckResultType signatureCheck;
    @XmlElement(name = "CertificateCheck", required = true)
    protected CheckResultType certificateCheck;
    @XmlElement(name = "ManifestCheck")
    protected ManifestCheckType manifestCheck;
    @XmlElement(name = "Annotations")
    protected AnnotationsType annotations;

    /**
     * Gets the value of the inputData property.
     *
     * @return possible object is
     * {@link ContentExLocRefBaseType }
     */
    public ContentExLocRefBaseType getInputData() {
        return inputData;
    }

    /**
     * Sets the value of the inputData property.
     *
     * @param value allowed object is
     *              {@link ContentExLocRefBaseType }
     */
    public void setInputData(ContentExLocRefBaseType value) {
        this.inputData = value;
    }

    /**
     * Gets the value of the signerName property.
     *
     * @return possible object is
     * {@link String }
     */
    public String getSignerName() {
        return signerName;
    }

    /**
     * Sets the value of the signerName property.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setSignerName(String value) {
        this.signerName = value;
    }

    /**
     * Gets the value of the signatureCheck property.
     *
     * @return possible object is
     * {@link CheckResultType }
     */
    public CheckResultType getSignatureCheck() {
        return signatureCheck;
    }

    /**
     * Sets the value of the signatureCheck property.
     *
     * @param value allowed object is
     *              {@link CheckResultType }
     */
    public void setSignatureCheck(CheckResultType value) {
        this.signatureCheck = value;
    }

    /**
     * Gets the value of the certificateCheck property.
     *
     * @return possible object is
     * {@link CheckResultType }
     */
    public CheckResultType getCertificateCheck() {
        return certificateCheck;
    }

    /**
     * Sets the value of the certificateCheck property.
     *
     * @param value allowed object is
     *              {@link CheckResultType }
     */
    public void setCertificateCheck(CheckResultType value) {
        this.certificateCheck = value;
    }

    /**
     * Gets the value of the manifestCheck property.
     *
     * @return possible object is
     * {@link ManifestCheckType }
     */
    public ManifestCheckType getManifestCheck() {
        return manifestCheck;
    }

    /**
     * Sets the value of the manifestCheck property.
     *
     * @param value allowed object is
     *              {@link ManifestCheckType }
     */
    public void setManifestCheck(ManifestCheckType value) {
        this.manifestCheck = value;
    }

    /**
     * Gets the value of the annotations property.
     *
     * @return possible object is
     * {@link AnnotationsType }
     */
    public AnnotationsType getAnnotations() {
        return annotations;
    }

    /**
     * Sets the value of the annotations property.
     *
     * @param value allowed object is
     *              {@link AnnotationsType }
     */
    public void setAnnotations(AnnotationsType value) {
        this.annotations = value;
    }

}
