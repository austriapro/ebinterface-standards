package at.ebinterface.validation.rtr.generated;

import javax.xml.bind.annotation.*;
import javax.xml.bind.annotation.adapters.CollapsedStringAdapter;
import javax.xml.bind.annotation.adapters.XmlJavaTypeAdapter;


/**
 * <p>Java class for FileInfoType complex type.
 * <p/>
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p/>
 * <pre>
 * &lt;complexType name="FileInfoType">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="FileID" type="{http://www.w3.org/2001/XMLSchema}token" minOccurs="0"/>
 *         &lt;element name="FileType" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="File-Hash" type="{http://www.w3.org/2001/XMLSchema}base64Binary"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "FileInfoType", namespace = "http://reference.e-government.gv.at/namespace/verificationservice/20120922#", propOrder = {
        "fileID",
        "fileType",
        "fileHash"
})
public class FileInfoType {

    @XmlElement(name = "FileID")
    @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
    @XmlSchemaType(name = "token")
    protected String fileID;
    @XmlElement(name = "FileType", required = true)
    protected String fileType;
    @XmlElement(name = "File-Hash", required = true)
    protected byte[] fileHash;

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
     * Gets the value of the fileType property.
     *
     * @return possible object is
     * {@link String }
     */
    public String getFileType() {
        return fileType;
    }

    /**
     * Sets the value of the fileType property.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setFileType(String value) {
        this.fileType = value;
    }

    /**
     * Gets the value of the fileHash property.
     *
     * @return possible object is
     * byte[]
     */
    public byte[] getFileHash() {
        return fileHash;
    }

    /**
     * Sets the value of the fileHash property.
     *
     * @param value allowed object is
     *              byte[]
     */
    public void setFileHash(byte[] value) {
        this.fileHash = value;
    }

}
