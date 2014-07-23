package at.ebinterface.validation.rtr.generated;

import javax.xml.bind.annotation.*;


/**
 * <p>Java class for anonymous complex type.
 * <p/>
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p/>
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="Version" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/>
 *         &lt;element name="VerificationReport" type="{http://reference.e-government.gv.at/namespace/verificationservice/20120922#}VerificationReportType"/>
 *         &lt;element name="PDFDocument" type="{http://www.w3.org/2001/XMLSchema}base64Binary" minOccurs="0"/>
 *         &lt;element ref="{http://www.w3.org/2000/09/xmldsig#}Signature"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
        "version",
        "verificationReport",
        "pdfDocument",
        "signature"
})
@XmlRootElement(name = "VerifyDocumentResponse", namespace = "http://reference.e-government.gv.at/namespace/verificationservice/20120922#")
public class VerifyDocumentResponse {

    @XmlElement(name = "Version", namespace = "http://reference.e-government.gv.at/namespace/verificationservice/20120922#")
    protected Integer version;
    @XmlElement(name = "VerificationReport", namespace = "http://reference.e-government.gv.at/namespace/verificationservice/20120922#", required = true)
    protected VerificationReportType verificationReport;
    @XmlElement(name = "PDFDocument", namespace = "http://reference.e-government.gv.at/namespace/verificationservice/20120922#")
    protected byte[] pdfDocument;
    @XmlElement(name = "Signature", required = true)
    protected SignatureType signature;

    /**
     * Gets the value of the version property.
     *
     * @return possible object is
     * {@link Integer }
     */
    public Integer getVersion() {
        return version;
    }

    /**
     * Sets the value of the version property.
     *
     * @param value allowed object is
     *              {@link Integer }
     */
    public void setVersion(Integer value) {
        this.version = value;
    }

    /**
     * Gets the value of the verificationReport property.
     *
     * @return possible object is
     * {@link VerificationReportType }
     */
    public VerificationReportType getVerificationReport() {
        return verificationReport;
    }

    /**
     * Sets the value of the verificationReport property.
     *
     * @param value allowed object is
     *              {@link VerificationReportType }
     */
    public void setVerificationReport(VerificationReportType value) {
        this.verificationReport = value;
    }

    /**
     * Gets the value of the pdfDocument property.
     *
     * @return possible object is
     * byte[]
     */
    public byte[] getPDFDocument() {
        return pdfDocument;
    }

    /**
     * Sets the value of the pdfDocument property.
     *
     * @param value allowed object is
     *              byte[]
     */
    public void setPDFDocument(byte[] value) {
        this.pdfDocument = value;
    }

    /**
     * Gets the value of the signature property.
     *
     * @return possible object is
     * {@link SignatureType }
     */
    public SignatureType getSignature() {
        return signature;
    }

    /**
     * Sets the value of the signature property.
     *
     * @param value allowed object is
     *              {@link SignatureType }
     */
    public void setSignature(SignatureType value) {
        this.signature = value;
    }

}
