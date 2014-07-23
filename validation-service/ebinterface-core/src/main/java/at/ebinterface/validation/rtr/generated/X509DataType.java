package at.ebinterface.validation.rtr.generated;

import org.w3c.dom.Element;

import javax.xml.bind.annotation.*;


/**
 * <p>Java class for X509DataType complex type.
 * <p/>
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p/>
 * <pre>
 * &lt;complexType name="X509DataType">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;choice>
 *           &lt;element name="X509IssuerSerial" type="{http://www.w3.org/2000/09/xmldsig#}X509IssuerSerialType"/>
 *           &lt;element name="X509SKI" type="{http://www.w3.org/2001/XMLSchema}base64Binary"/>
 *           &lt;element name="X509SubjectName" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *           &lt;element name="X509Certificate" type="{http://www.w3.org/2001/XMLSchema}base64Binary"/>
 *           &lt;element name="X509CRL" type="{http://www.w3.org/2001/XMLSchema}base64Binary"/>
 *           &lt;any processContents='lax' namespace='##other'/>
 *         &lt;/choice>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "X509DataType", propOrder = {
        "x509IssuerSerial",
        "x509SKI",
        "x509SubjectName",
        "x509Certificate",
        "x509CRL",
        "any"
})
public class X509DataType {

    @XmlElement(name = "X509IssuerSerial")
    protected X509IssuerSerialType x509IssuerSerial;
    @XmlElement(name = "X509SKI")
    protected byte[] x509SKI;
    @XmlElement(name = "X509SubjectName")
    protected String x509SubjectName;
    @XmlElement(name = "X509Certificate")
    protected byte[] x509Certificate;
    @XmlElement(name = "X509CRL")
    protected byte[] x509CRL;
    @XmlAnyElement(lax = true)
    protected Object any;

    /**
     * Gets the value of the x509IssuerSerial property.
     *
     * @return possible object is
     * {@link X509IssuerSerialType }
     */
    public X509IssuerSerialType getX509IssuerSerial() {
        return x509IssuerSerial;
    }

    /**
     * Sets the value of the x509IssuerSerial property.
     *
     * @param value allowed object is
     *              {@link X509IssuerSerialType }
     */
    public void setX509IssuerSerial(X509IssuerSerialType value) {
        this.x509IssuerSerial = value;
    }

    /**
     * Gets the value of the x509SKI property.
     *
     * @return possible object is
     * byte[]
     */
    public byte[] getX509SKI() {
        return x509SKI;
    }

    /**
     * Sets the value of the x509SKI property.
     *
     * @param value allowed object is
     *              byte[]
     */
    public void setX509SKI(byte[] value) {
        this.x509SKI = value;
    }

    /**
     * Gets the value of the x509SubjectName property.
     *
     * @return possible object is
     * {@link String }
     */
    public String getX509SubjectName() {
        return x509SubjectName;
    }

    /**
     * Sets the value of the x509SubjectName property.
     *
     * @param value allowed object is
     *              {@link String }
     */
    public void setX509SubjectName(String value) {
        this.x509SubjectName = value;
    }

    /**
     * Gets the value of the x509Certificate property.
     *
     * @return possible object is
     * byte[]
     */
    public byte[] getX509Certificate() {
        return x509Certificate;
    }

    /**
     * Sets the value of the x509Certificate property.
     *
     * @param value allowed object is
     *              byte[]
     */
    public void setX509Certificate(byte[] value) {
        this.x509Certificate = value;
    }

    /**
     * Gets the value of the x509CRL property.
     *
     * @return possible object is
     * byte[]
     */
    public byte[] getX509CRL() {
        return x509CRL;
    }

    /**
     * Sets the value of the x509CRL property.
     *
     * @param value allowed object is
     *              byte[]
     */
    public void setX509CRL(byte[] value) {
        this.x509CRL = value;
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
