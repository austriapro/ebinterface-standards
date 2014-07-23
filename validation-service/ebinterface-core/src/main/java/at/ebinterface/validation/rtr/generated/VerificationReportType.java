package at.ebinterface.validation.rtr.generated;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;
import java.util.ArrayList;
import java.util.List;


/**
 * <p>Java class for VerificationReportType complex type.
 * <p/>
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p/>
 * <pre>
 * &lt;complexType name="VerificationReportType">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="FileInfo" type="{http://reference.e-government.gv.at/namespace/verificationservice/20120922#}FileInfoType"/>
 *         &lt;element name="SignatureInfo" type="{http://reference.e-government.gv.at/namespace/verificationservice/20120922#}SignatureInfoType" maxOccurs="unbounded"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "VerificationReportType", namespace = "http://reference.e-government.gv.at/namespace/verificationservice/20120922#", propOrder = {
        "fileInfo",
        "signatureInfo"
})
public class VerificationReportType {

    @XmlElement(name = "FileInfo", required = true)
    protected FileInfoType fileInfo;
    @XmlElement(name = "SignatureInfo", required = true)
    protected List<SignatureInfoType> signatureInfo;

    /**
     * Gets the value of the fileInfo property.
     *
     * @return possible object is
     * {@link FileInfoType }
     */
    public FileInfoType getFileInfo() {
        return fileInfo;
    }

    /**
     * Sets the value of the fileInfo property.
     *
     * @param value allowed object is
     *              {@link FileInfoType }
     */
    public void setFileInfo(FileInfoType value) {
        this.fileInfo = value;
    }

    /**
     * Gets the value of the signatureInfo property.
     * <p/>
     * <p/>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the signatureInfo property.
     * <p/>
     * <p/>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getSignatureInfo().add(newItem);
     * </pre>
     * <p/>
     * <p/>
     * <p/>
     * Objects of the following type(s) are allowed in the list
     * {@link SignatureInfoType }
     */
    public List<SignatureInfoType> getSignatureInfo() {
        if (signatureInfo == null) {
            signatureInfo = new ArrayList<SignatureInfoType>();
        }
        return this.signatureInfo;
    }

}
