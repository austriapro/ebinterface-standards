package at.ebinterface.validation.rtr.generated;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for ContentExLocRefBaseType complex type.
 * <p/>
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p/>
 * <pre>
 * &lt;complexType name="ContentExLocRefBaseType">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="Base64Content" type="{http://www.w3.org/2001/XMLSchema}base64Binary"/>
 *         &lt;element name="FileType" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ContentExLocRefBaseType", namespace = "http://reference.e-government.gv.at/namespace/verificationservice/20120922#", propOrder = {
        "base64Content",
        "fileType"
})
public class ContentExLocRefBaseType {

    @XmlElement(name = "Base64Content", required = true)
    protected byte[] base64Content;
    @XmlElement(name = "FileType", required = true)
    protected String fileType;

    /**
     * Gets the value of the base64Content property.
     *
     * @return possible object is
     * byte[]
     */
    public byte[] getBase64Content() {
        return base64Content;
    }

    /**
     * Sets the value of the base64Content property.
     *
     * @param value allowed object is
     *              byte[]
     */
    public void setBase64Content(byte[] value) {
        this.base64Content = value;
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

}
