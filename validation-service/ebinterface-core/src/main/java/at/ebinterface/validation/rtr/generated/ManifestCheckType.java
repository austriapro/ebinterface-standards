package at.ebinterface.validation.rtr.generated;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for ManifestCheckType complex type.
 * <p/>
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p/>
 * <pre>
 * &lt;complexType name="ManifestCheckType">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="Manifest" type="{http://reference.e-government.gv.at/namespace/verificationservice/20120922#}CheckResultType" minOccurs="0"/>
 *         &lt;element name="XMLDsigManifest" type="{http://reference.e-government.gv.at/namespace/verificationservice/20120922#}CheckResultType" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ManifestCheckType", namespace = "http://reference.e-government.gv.at/namespace/verificationservice/20120922#", propOrder = {
        "manifest",
        "xmlDsigManifest"
})
public class ManifestCheckType {

    @XmlElement(name = "Manifest")
    protected CheckResultType manifest;
    @XmlElement(name = "XMLDsigManifest")
    protected CheckResultType xmlDsigManifest;

    /**
     * Gets the value of the manifest property.
     *
     * @return possible object is
     * {@link CheckResultType }
     */
    public CheckResultType getManifest() {
        return manifest;
    }

    /**
     * Sets the value of the manifest property.
     *
     * @param value allowed object is
     *              {@link CheckResultType }
     */
    public void setManifest(CheckResultType value) {
        this.manifest = value;
    }

    /**
     * Gets the value of the xmlDsigManifest property.
     *
     * @return possible object is
     * {@link CheckResultType }
     */
    public CheckResultType getXMLDsigManifest() {
        return xmlDsigManifest;
    }

    /**
     * Sets the value of the xmlDsigManifest property.
     *
     * @param value allowed object is
     *              {@link CheckResultType }
     */
    public void setXMLDsigManifest(CheckResultType value) {
        this.xmlDsigManifest = value;
    }

}
