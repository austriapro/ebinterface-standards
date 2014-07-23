package at.ebinterface.validation.rtr.generated;

import javax.xml.bind.annotation.*;
import javax.xml.bind.annotation.adapters.CollapsedStringAdapter;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;


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
 *         &lt;element name="Document" type="{http://www.w3.org/2001/XMLSchema}base64Binary"/>
 *         &lt;element name="FileID" type="{http://www.w3.org/2001/XMLSchema}token" minOccurs="0"/>
 *         &lt;element name="TrustProfileID" type="{http://www.w3.org/2001/XMLSchema}token" minOccurs="0"/>
 *         &lt;element name="RequestPDFReport" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/>
 *         &lt;element name="Language" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
        "version",
        "document",
        "fileID",
        "trustProfileID",
        "requestPDFReport",
        "language"
})
@XmlRootElement(name = "VerifyDocumentRequest", namespace = "http://reference.e-government.gv.at/namespace/verificationservice/20120922#")
public class VerifyDocumentRequest {

    @XmlElement(name = "Version", namespace = "http://reference.e-government.gv.at/namespace/verificationservice/20120922#")
    protected Integer version;
    @XmlElement(name = "Document", namespace = "http://reference.e-government.gv.at/namespace/verificationservice/20120922#", required = true)
    protected byte[] document;
    @XmlElement(name = "FileID", namespace = "http://reference.e-government.gv.at/namespace/verificationservice/20120922#")
    @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
    @XmlSchemaType(name = "token")
    protected String fileID;
    @XmlElement(name = "TrustProfileID", namespace = "http://reference.e-government.gv.at/namespace/verificationservice/20120922#")
    @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
    @XmlSchemaType(name = "token")
    protected String trustProfileID;
    @XmlElement(name = "RequestPDFReport", namespace = "http://reference.e-government.gv.at/namespace/verificationservice/20120922#")
    protected Boolean requestPDFReport;
    @XmlElement(name = "Language", namespace = "http://reference.e-government.gv.at/namespace/verificationservice/20120922#")
    protected String language;

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
     * Gets the value of the document property.
     *
     * @return possible object is
     * byte[]
     */
    public byte[] getDocument() {
        return document;
    }

    /**
     * Sets the value of the document property.
     *
     * @param value allowed object is
     *              byte[]
     */
    public void setDocument(byte[] value) {
        this.document = value;
    }

    /**
     * Gets the value of the fileID property.
     *
     * @return possible object is
     * {@link String }
     */
    public String getFileID() {
        return fileID;
    }

    /**
     * Sets the value of the fileID property.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setFileID(String value) {
        this.fileID = value;
    }

    /**
     * Gets the value of the trustProfileID property.
     *
     * @return possible object is
     * {@link String }
     */
    public String getTrustProfileID() {
        return trustProfileID;
    }

    /**
     * Sets the value of the trustProfileID property.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setTrustProfileID(String value) {
        this.trustProfileID = value;
    }

    /**
     * Gets the value of the requestPDFReport property.
     *
     * @return possible object is
     * {@link Boolean }
     */
    public Boolean isRequestPDFReport() {
        return requestPDFReport;
    }

    /**
     * Sets the value of the requestPDFReport property.
     *
     * @param value allowed object is
     *              {@link Boolean }
     */
    public void setRequestPDFReport(Boolean value) {
        this.requestPDFReport = value;
    }

    /**
     * Gets the value of the language property.
     *
     * @return possible object is
     * {@link String }
     */
    public String getLanguage() {
        return language;
    }

    /**
     * Sets the value of the language property.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setLanguage(String value) {
        this.language = value;
    }

}
