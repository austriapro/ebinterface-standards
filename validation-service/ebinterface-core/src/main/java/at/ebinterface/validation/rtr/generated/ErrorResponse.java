package at.ebinterface.validation.rtr.generated;

import javax.xml.bind.annotation.*;
import java.math.BigInteger;


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
 *         &lt;element name="ErrorCode" type="{http://www.w3.org/2001/XMLSchema}integer"/>
 *         &lt;element name="Info" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
        "errorCode",
        "info"
})
@XmlRootElement(name = "ErrorResponse", namespace = "http://reference.e-government.gv.at/namespace/verificationservice/20120922#")
public class ErrorResponse {

    @XmlElement(name = "ErrorCode", namespace = "http://reference.e-government.gv.at/namespace/verificationservice/20120922#", required = true)
    protected BigInteger errorCode;
    @XmlElement(name = "Info", namespace = "http://reference.e-government.gv.at/namespace/verificationservice/20120922#", required = true)
    protected String info;

    /**
     * Gets the value of the errorCode property.
     *
     * @return possible object is
     * {@link BigInteger }
     */
    public BigInteger getErrorCode() {
        return errorCode;
    }

    /**
     * Sets the value of the errorCode property.
     *
     * @param value allowed object is
     *              {@link BigInteger }
     */
    public void setErrorCode(BigInteger value) {
        this.errorCode = value;
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
