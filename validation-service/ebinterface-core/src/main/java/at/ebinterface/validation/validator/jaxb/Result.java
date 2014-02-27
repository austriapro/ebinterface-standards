package at.ebinterface.validation.validator.jaxb;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlSchemaType;
import javax.xml.bind.annotation.XmlType;
import javax.xml.bind.annotation.XmlValue;
import org.jvnet.jaxb2_commons.lang.Equals;
import org.jvnet.jaxb2_commons.lang.EqualsStrategy;
import org.jvnet.jaxb2_commons.lang.HashCode;
import org.jvnet.jaxb2_commons.lang.HashCodeStrategy;
import org.jvnet.jaxb2_commons.lang.JAXBEqualsStrategy;
import org.jvnet.jaxb2_commons.lang.JAXBHashCodeStrategy;
import org.jvnet.jaxb2_commons.lang.JAXBToStringStrategy;
import org.jvnet.jaxb2_commons.lang.ToString;
import org.jvnet.jaxb2_commons.lang.ToStringStrategy;
import org.jvnet.jaxb2_commons.locator.ObjectLocator;
import org.jvnet.jaxb2_commons.locator.util.LocatorUtils;


/**
 * 
 * 						If the validationPassed attribute is false,
 * 						validation failed. In this case Error Elements are present and
 * 						each
 * 						Error Element specifies the particular violation.
 * 					
 * 
 * <p>Java class for ResultType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ResultType">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="Namespace" maxOccurs="unbounded" minOccurs="0">
 *           &lt;complexType>
 *             &lt;simpleContent>
 *               &lt;extension base="&lt;http://www.w3.org/2001/XMLSchema>string">
 *                 &lt;attribute name="prefix" use="required" type="{http://www.w3.org/2001/XMLSchema}anySimpleType" />
 *                 &lt;attribute name="uri" use="required" type="{http://www.w3.org/2001/XMLSchema}anySimpleType" />
 *               &lt;/extension>
 *             &lt;/simpleContent>
 *           &lt;/complexType>
 *         &lt;/element>
 *         &lt;element name="Error" maxOccurs="unbounded" minOccurs="0">
 *           &lt;complexType>
 *             &lt;complexContent>
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *                 &lt;sequence>
 *                   &lt;element name="ErrorMessage" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *                   &lt;element name="ViolatingElement" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *                 &lt;/sequence>
 *               &lt;/restriction>
 *             &lt;/complexContent>
 *           &lt;/complexType>
 *         &lt;/element>
 *       &lt;/sequence>
 *       &lt;attribute name="validationPassed" use="required" type="{http://www.w3.org/2001/XMLSchema}boolean" />
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ResultType", propOrder = {
    "namespaces",
    "errors"
})
@XmlRootElement(name = "Result")
public class Result
    implements Serializable, Equals, HashCode, ToString
{

    @XmlElement(name = "Namespace")
    protected List<Result.Namespace> namespaces;
    @XmlElement(name = "Error")
    protected List<Result.Error> errors;
    @XmlAttribute(name = "validationPassed", namespace = "http://validation.erpel.at", required = true)
    protected boolean validationPassed;

    /**
     * Gets the value of the namespaces property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the namespaces property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getNamespaces().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Result.Namespace }
     * 
     * 
     */
    public List<Result.Namespace> getNamespaces() {
        if (namespaces == null) {
            namespaces = new ArrayList<Result.Namespace>();
        }
        return this.namespaces;
    }

    /**
     * Gets the value of the errors property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the errors property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getErrors().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link Result.Error }
     * 
     * 
     */
    public List<Result.Error> getErrors() {
        if (errors == null) {
            errors = new ArrayList<Result.Error>();
        }
        return this.errors;
    }

    /**
     * Gets the value of the validationPassed property.
     * 
     */
    public boolean isValidationPassed() {
        return validationPassed;
    }

    /**
     * Sets the value of the validationPassed property.
     * 
     */
    public void setValidationPassed(boolean value) {
        this.validationPassed = value;
    }

    public String toString() {
        final ToStringStrategy strategy = JAXBToStringStrategy.INSTANCE;
        final StringBuilder buffer = new StringBuilder();
        append(null, buffer, strategy);
        return buffer.toString();
    }

    public StringBuilder append(ObjectLocator locator, StringBuilder buffer, ToStringStrategy strategy) {
        strategy.appendStart(locator, this, buffer);
        appendFields(locator, buffer, strategy);
        strategy.appendEnd(locator, this, buffer);
        return buffer;
    }

    public StringBuilder appendFields(ObjectLocator locator, StringBuilder buffer, ToStringStrategy strategy) {
        {
            List<Result.Namespace> theNamespaces;
            theNamespaces = this.getNamespaces();
            strategy.appendField(locator, this, "namespaces", buffer, theNamespaces);
        }
        {
            List<Result.Error> theErrors;
            theErrors = this.getErrors();
            strategy.appendField(locator, this, "errors", buffer, theErrors);
        }
        {
            boolean theValidationPassed;
            theValidationPassed = this.isValidationPassed();
            strategy.appendField(locator, this, "validationPassed", buffer, theValidationPassed);
        }
        return buffer;
    }

    public int hashCode(ObjectLocator locator, HashCodeStrategy strategy) {
        int currentHashCode = 1;
        {
            List<Result.Namespace> theNamespaces;
            theNamespaces = this.getNamespaces();
            currentHashCode = strategy.hashCode(LocatorUtils.property(locator, "namespaces", theNamespaces), currentHashCode, theNamespaces);
        }
        {
            List<Result.Error> theErrors;
            theErrors = this.getErrors();
            currentHashCode = strategy.hashCode(LocatorUtils.property(locator, "errors", theErrors), currentHashCode, theErrors);
        }
        {
            boolean theValidationPassed;
            theValidationPassed = this.isValidationPassed();
            currentHashCode = strategy.hashCode(LocatorUtils.property(locator, "validationPassed", theValidationPassed), currentHashCode, theValidationPassed);
        }
        return currentHashCode;
    }

    public int hashCode() {
        final HashCodeStrategy strategy = JAXBHashCodeStrategy.INSTANCE;
        return this.hashCode(null, strategy);
    }

    public boolean equals(ObjectLocator thisLocator, ObjectLocator thatLocator, Object object, EqualsStrategy strategy) {
        if (!(object instanceof Result)) {
            return false;
        }
        if (this == object) {
            return true;
        }
        final Result that = ((Result) object);
        {
            List<Result.Namespace> lhsNamespaces;
            lhsNamespaces = this.getNamespaces();
            List<Result.Namespace> rhsNamespaces;
            rhsNamespaces = that.getNamespaces();
            if (!strategy.equals(LocatorUtils.property(thisLocator, "namespaces", lhsNamespaces), LocatorUtils.property(thatLocator, "namespaces", rhsNamespaces), lhsNamespaces, rhsNamespaces)) {
                return false;
            }
        }
        {
            List<Result.Error> lhsErrors;
            lhsErrors = this.getErrors();
            List<Result.Error> rhsErrors;
            rhsErrors = that.getErrors();
            if (!strategy.equals(LocatorUtils.property(thisLocator, "errors", lhsErrors), LocatorUtils.property(thatLocator, "errors", rhsErrors), lhsErrors, rhsErrors)) {
                return false;
            }
        }
        {
            boolean lhsValidationPassed;
            lhsValidationPassed = this.isValidationPassed();
            boolean rhsValidationPassed;
            rhsValidationPassed = that.isValidationPassed();
            if (!strategy.equals(LocatorUtils.property(thisLocator, "validationPassed", lhsValidationPassed), LocatorUtils.property(thatLocator, "validationPassed", rhsValidationPassed), lhsValidationPassed, rhsValidationPassed)) {
                return false;
            }
        }
        return true;
    }

    public boolean equals(Object object) {
        final EqualsStrategy strategy = JAXBEqualsStrategy.INSTANCE;
        return equals(null, null, object, strategy);
    }

    public Result withNamespaces(Result.Namespace... values) {
        if (values!= null) {
            for (Result.Namespace value: values) {
                getNamespaces().add(value);
            }
        }
        return this;
    }

    public Result withNamespaces(Collection<Result.Namespace> values) {
        if (values!= null) {
            getNamespaces().addAll(values);
        }
        return this;
    }

    public Result withErrors(Result.Error... values) {
        if (values!= null) {
            for (Result.Error value: values) {
                getErrors().add(value);
            }
        }
        return this;
    }

    public Result withErrors(Collection<Result.Error> values) {
        if (values!= null) {
            getErrors().addAll(values);
        }
        return this;
    }

    public Result withValidationPassed(boolean value) {
        setValidationPassed(value);
        return this;
    }


    /**
     * <p>Java class for anonymous complex type.
     * 
     * <p>The following schema fragment specifies the expected content contained within this class.
     * 
     * <pre>
     * &lt;complexType>
     *   &lt;complexContent>
     *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
     *       &lt;sequence>
     *         &lt;element name="ErrorMessage" type="{http://www.w3.org/2001/XMLSchema}string"/>
     *         &lt;element name="ViolatingElement" type="{http://www.w3.org/2001/XMLSchema}string"/>
     *       &lt;/sequence>
     *     &lt;/restriction>
     *   &lt;/complexContent>
     * &lt;/complexType>
     * </pre>
     * 
     * 
     */
    @XmlAccessorType(XmlAccessType.FIELD)
    @XmlType(name = "", propOrder = {
        "errorMessage",
        "violatingElement"
    })
    public static class Error
        implements Serializable, Equals, HashCode, ToString
    {

        @XmlElement(name = "ErrorMessage", required = true)
        protected String errorMessage;
        @XmlElement(name = "ViolatingElement", required = true)
        protected String violatingElement;

        /**
         * Gets the value of the errorMessage property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getErrorMessage() {
            return errorMessage;
        }

        /**
         * Sets the value of the errorMessage property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setErrorMessage(String value) {
            this.errorMessage = value;
        }

        /**
         * Gets the value of the violatingElement property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getViolatingElement() {
            return violatingElement;
        }

        /**
         * Sets the value of the violatingElement property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setViolatingElement(String value) {
            this.violatingElement = value;
        }

        public String toString() {
            final ToStringStrategy strategy = JAXBToStringStrategy.INSTANCE;
            final StringBuilder buffer = new StringBuilder();
            append(null, buffer, strategy);
            return buffer.toString();
        }

        public StringBuilder append(ObjectLocator locator, StringBuilder buffer, ToStringStrategy strategy) {
            strategy.appendStart(locator, this, buffer);
            appendFields(locator, buffer, strategy);
            strategy.appendEnd(locator, this, buffer);
            return buffer;
        }

        public StringBuilder appendFields(ObjectLocator locator, StringBuilder buffer, ToStringStrategy strategy) {
            {
                String theErrorMessage;
                theErrorMessage = this.getErrorMessage();
                strategy.appendField(locator, this, "errorMessage", buffer, theErrorMessage);
            }
            {
                String theViolatingElement;
                theViolatingElement = this.getViolatingElement();
                strategy.appendField(locator, this, "violatingElement", buffer, theViolatingElement);
            }
            return buffer;
        }

        public int hashCode(ObjectLocator locator, HashCodeStrategy strategy) {
            int currentHashCode = 1;
            {
                String theErrorMessage;
                theErrorMessage = this.getErrorMessage();
                currentHashCode = strategy.hashCode(LocatorUtils.property(locator, "errorMessage", theErrorMessage), currentHashCode, theErrorMessage);
            }
            {
                String theViolatingElement;
                theViolatingElement = this.getViolatingElement();
                currentHashCode = strategy.hashCode(LocatorUtils.property(locator, "violatingElement", theViolatingElement), currentHashCode, theViolatingElement);
            }
            return currentHashCode;
        }

        public int hashCode() {
            final HashCodeStrategy strategy = JAXBHashCodeStrategy.INSTANCE;
            return this.hashCode(null, strategy);
        }

        public boolean equals(ObjectLocator thisLocator, ObjectLocator thatLocator, Object object, EqualsStrategy strategy) {
            if (!(object instanceof Result.Error)) {
                return false;
            }
            if (this == object) {
                return true;
            }
            final Result.Error that = ((Result.Error) object);
            {
                String lhsErrorMessage;
                lhsErrorMessage = this.getErrorMessage();
                String rhsErrorMessage;
                rhsErrorMessage = that.getErrorMessage();
                if (!strategy.equals(LocatorUtils.property(thisLocator, "errorMessage", lhsErrorMessage), LocatorUtils.property(thatLocator, "errorMessage", rhsErrorMessage), lhsErrorMessage, rhsErrorMessage)) {
                    return false;
                }
            }
            {
                String lhsViolatingElement;
                lhsViolatingElement = this.getViolatingElement();
                String rhsViolatingElement;
                rhsViolatingElement = that.getViolatingElement();
                if (!strategy.equals(LocatorUtils.property(thisLocator, "violatingElement", lhsViolatingElement), LocatorUtils.property(thatLocator, "violatingElement", rhsViolatingElement), lhsViolatingElement, rhsViolatingElement)) {
                    return false;
                }
            }
            return true;
        }

        public boolean equals(Object object) {
            final EqualsStrategy strategy = JAXBEqualsStrategy.INSTANCE;
            return equals(null, null, object, strategy);
        }

        public Result.Error withErrorMessage(String value) {
            setErrorMessage(value);
            return this;
        }

        public Result.Error withViolatingElement(String value) {
            setViolatingElement(value);
            return this;
        }

    }


    /**
     * <p>Java class for anonymous complex type.
     * 
     * <p>The following schema fragment specifies the expected content contained within this class.
     * 
     * <pre>
     * &lt;complexType>
     *   &lt;simpleContent>
     *     &lt;extension base="&lt;http://www.w3.org/2001/XMLSchema>string">
     *       &lt;attribute name="prefix" use="required" type="{http://www.w3.org/2001/XMLSchema}anySimpleType" />
     *       &lt;attribute name="uri" use="required" type="{http://www.w3.org/2001/XMLSchema}anySimpleType" />
     *     &lt;/extension>
     *   &lt;/simpleContent>
     * &lt;/complexType>
     * </pre>
     * 
     * 
     */
    @XmlAccessorType(XmlAccessType.FIELD)
    @XmlType(name = "", propOrder = {
        "value"
    })
    public static class Namespace
        implements Serializable, Equals, HashCode, ToString
    {

        @XmlValue
        protected String value;
        @XmlAttribute(name = "prefix", namespace = "http://validation.erpel.at", required = true)
        @XmlSchemaType(name = "anySimpleType")
        protected String prefix;
        @XmlAttribute(name = "uri", namespace = "http://validation.erpel.at", required = true)
        @XmlSchemaType(name = "anySimpleType")
        protected String uri;

        /**
         * Gets the value of the value property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getValue() {
            return value;
        }

        /**
         * Sets the value of the value property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setValue(String value) {
            this.value = value;
        }

        /**
         * Gets the value of the prefix property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getPrefix() {
            return prefix;
        }

        /**
         * Sets the value of the prefix property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setPrefix(String value) {
            this.prefix = value;
        }

        /**
         * Gets the value of the uri property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getUri() {
            return uri;
        }

        /**
         * Sets the value of the uri property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setUri(String value) {
            this.uri = value;
        }

        public String toString() {
            final ToStringStrategy strategy = JAXBToStringStrategy.INSTANCE;
            final StringBuilder buffer = new StringBuilder();
            append(null, buffer, strategy);
            return buffer.toString();
        }

        public StringBuilder append(ObjectLocator locator, StringBuilder buffer, ToStringStrategy strategy) {
            strategy.appendStart(locator, this, buffer);
            appendFields(locator, buffer, strategy);
            strategy.appendEnd(locator, this, buffer);
            return buffer;
        }

        public StringBuilder appendFields(ObjectLocator locator, StringBuilder buffer, ToStringStrategy strategy) {
            {
                String theValue;
                theValue = this.getValue();
                strategy.appendField(locator, this, "value", buffer, theValue);
            }
            {
                String thePrefix;
                thePrefix = this.getPrefix();
                strategy.appendField(locator, this, "prefix", buffer, thePrefix);
            }
            {
                String theUri;
                theUri = this.getUri();
                strategy.appendField(locator, this, "uri", buffer, theUri);
            }
            return buffer;
        }

        public int hashCode(ObjectLocator locator, HashCodeStrategy strategy) {
            int currentHashCode = 1;
            {
                String theValue;
                theValue = this.getValue();
                currentHashCode = strategy.hashCode(LocatorUtils.property(locator, "value", theValue), currentHashCode, theValue);
            }
            {
                String thePrefix;
                thePrefix = this.getPrefix();
                currentHashCode = strategy.hashCode(LocatorUtils.property(locator, "prefix", thePrefix), currentHashCode, thePrefix);
            }
            {
                String theUri;
                theUri = this.getUri();
                currentHashCode = strategy.hashCode(LocatorUtils.property(locator, "uri", theUri), currentHashCode, theUri);
            }
            return currentHashCode;
        }

        public int hashCode() {
            final HashCodeStrategy strategy = JAXBHashCodeStrategy.INSTANCE;
            return this.hashCode(null, strategy);
        }

        public boolean equals(ObjectLocator thisLocator, ObjectLocator thatLocator, Object object, EqualsStrategy strategy) {
            if (!(object instanceof Result.Namespace)) {
                return false;
            }
            if (this == object) {
                return true;
            }
            final Result.Namespace that = ((Result.Namespace) object);
            {
                String lhsValue;
                lhsValue = this.getValue();
                String rhsValue;
                rhsValue = that.getValue();
                if (!strategy.equals(LocatorUtils.property(thisLocator, "value", lhsValue), LocatorUtils.property(thatLocator, "value", rhsValue), lhsValue, rhsValue)) {
                    return false;
                }
            }
            {
                String lhsPrefix;
                lhsPrefix = this.getPrefix();
                String rhsPrefix;
                rhsPrefix = that.getPrefix();
                if (!strategy.equals(LocatorUtils.property(thisLocator, "prefix", lhsPrefix), LocatorUtils.property(thatLocator, "prefix", rhsPrefix), lhsPrefix, rhsPrefix)) {
                    return false;
                }
            }
            {
                String lhsUri;
                lhsUri = this.getUri();
                String rhsUri;
                rhsUri = that.getUri();
                if (!strategy.equals(LocatorUtils.property(thisLocator, "uri", lhsUri), LocatorUtils.property(thatLocator, "uri", rhsUri), lhsUri, rhsUri)) {
                    return false;
                }
            }
            return true;
        }

        public boolean equals(Object object) {
            final EqualsStrategy strategy = JAXBEqualsStrategy.INSTANCE;
            return equals(null, null, object, strategy);
        }

        public Result.Namespace withValue(String value) {
            setValue(value);
            return this;
        }

        public Result.Namespace withPrefix(String value) {
            setPrefix(value);
            return this;
        }

        public Result.Namespace withUri(String value) {
            setUri(value);
            return this;
        }

    }

}
