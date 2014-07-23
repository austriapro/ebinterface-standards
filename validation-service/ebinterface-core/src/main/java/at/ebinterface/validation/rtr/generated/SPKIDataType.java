package at.ebinterface.validation.rtr.generated;

import org.w3c.dom.Element;

import javax.xml.bind.annotation.*;


/**
 * <p>Java class for SPKIDataType complex type.
 * <p/>
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p/>
 * <pre>
 * &lt;complexType name="SPKIDataType">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="SPKISexp" type="{http://www.w3.org/2001/XMLSchema}base64Binary"/>
 *         &lt;any processContents='lax' namespace='##other'/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "SPKIDataType", propOrder = {
        "spkiSexp",
        "any"
})
public class SPKIDataType {

    @XmlElement(name = "SPKISexp", required = true)
    protected byte[] spkiSexp;
    @XmlAnyElement(lax = true)
    protected Object any;

    /**
     * Gets the value of the spkiSexp property.
     *
     * @return possible object is
     * byte[]
     */
    public byte[] getSPKISexp() {
        return spkiSexp;
    }

    /**
     * Sets the value of the spkiSexp property.
     *
     * @param value allowed object is
     *              byte[]
     */
    public void setSPKISexp(byte[] value) {
        this.spkiSexp = value;
    }

    /**
     * Gets the value of the any property.
     *
     * @return possible object is
     * {@link Object }
     * {@link Element }
     */
    public Object getAny() {
        return any;
    }

    /**
     * Sets the value of the any property.
     *
     * @param value allowed object is
     *              {@link Object }
     *              {@link Element }
     */
    public void setAny(Object value) {
        this.any = value;
    }

}
