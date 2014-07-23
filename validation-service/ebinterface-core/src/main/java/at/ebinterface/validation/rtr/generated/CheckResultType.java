package at.ebinterface.validation.rtr.generated;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;
import java.math.BigInteger;


/**
 * <p>Java class for CheckResultType complex type.
 * <p/>
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p/>
 * <pre>
 * &lt;complexType name="CheckResultType">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="Code" type="{http://www.w3.org/2001/XMLSchema}integer"/>
 *         &lt;element name="Info" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "CheckResultType", namespace = "http://reference.e-government.gv.at/namespace/verificationservice/20120922#", propOrder = {
        "code",
        "info"
})
public class CheckResultType {

    @XmlElement(name = "Code", required = true)
    protected BigInteger code;
    @XmlElement(name = "Info")
    protected String info;

    /**
     * Gets the value of the code property.
     *
     * @return possible object is
     * {@link BigInteger }
     */
    public BigInteger getCode() {
        return code;
    }

    /**
     * Sets the value of the code property.
     *
     * @param value allowed object is
     *              {@link BigInteger }
     */
    public void setCode(BigInteger value) {
        this.code = value;
    }

    /**
     * Gets the value of the info property.
     *
     * @return possible object is
     * {@link String }
     */
    public String getInfo() {
        return info;
    }

    /**
     * Sets the value of the info property.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setInfo(String value) {
        this.info = value;
    }

}
