package at.ebinterface.validation.validator.jaxb;


import javax.xml.bind.annotation.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;


/**
 * If the validationPassed attribute is false,
 * validation failed. In this case Error Elements are present and
 * each
 * Error Element specifies the particular violation.
 * <p/>
 * <p/>
 * <p>Java class for ResultType complex type.
 * <p/>
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <p/>
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
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ResultType", propOrder = {
        "namespaces",
        "errors"
})
@XmlRootElement(name = "Result")
public class Result
        implements Serializable {

    @XmlElement(name = "Namespace")
    protected List<Result.Namespace> namespaces;
    @XmlElement(name = "Error")
    protected List<Result.Error> errors;
    @XmlAttribute(name = "validationPassed", namespace = "http://validation.erpel.at", required = true)
    protected boolean validationPassed;

    /**
     * Gets the value of the namespaces property.
     * <p/>
     * <p/>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the namespaces property.
     * <p/>
     * <p/>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getNamespaces().add(newItem);
     * </pre>
     * <p/>
     * <p/>
     * <p/>
     * Objects of the following type(s) are allowed in the list
     * {@link Result.Namespace }
     */
    public List<Result.Namespace> getNamespaces() {
        if (namespaces == null) {
            namespaces = new ArrayList<Result.Namespace>();
        }
        return this.namespaces;
    }

    /**
     * Gets the value of the errors property.
     * <p/>
     * <p/>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the errors property.
     * <p/>
     * <p/>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getErrors().add(newItem);
     * </pre>
     * <p/>
     * <p/>
     * <p/>
     * Objects of the following type(s) are allowed in the list
     * {@link Result.Error }
     */
    public List<Result.Error> getErrors() {
        if (errors == null) {
            errors = new ArrayList<Result.Error>();
        }
        return this.errors;
    }

    /**
     * Gets the value of the validationPassed property.
     */
    public boolean isValidationPassed() {
        return validationPassed;
    }

    /**
     * Sets the value of the validationPassed property.
     */
    public void setValidationPassed(boolean value) {
        this.validationPassed = value;
    }


    public Result withNamespaces(Result.Namespace... values) {
        if (values != null) {
            for (Result.Namespace value : values) {
                getNamespaces().add(value);
            }
        }
        return this;
    }

    public Result withNamespaces(Collection<Result.Namespace> values) {
        if (values != null) {
            getNamespaces().addAll(values);
        }
        return this;
    }

    public Result withErrors(Result.Error... values) {
        if (values != null) {
            for (Result.Error value : values) {
                getErrors().add(value);
            }
        }
        return this;
    }

    public Result withErrors(Collection<Result.Error> values) {
        if (values != null) {
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
     * <p/>
     * <p>The following schema fragment specifies the expected content contained within this class.
     * <p/>
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
     */
    @XmlAccessorType(XmlAccessType.FIELD)
    @XmlType(name = "", propOrder = {
            "errorMessage",
            "violatingElement"
    })
    public static class Error
            implements Serializable {

        @XmlElement(name = "ErrorMessage", required = true)
        protected String errorMessage;
        @XmlElement(name = "ViolatingElement", required = true)
        protected String violatingElement;

        /**
         * Gets the value of the errorMessage property.
         *
         * @return possible object is
         * {@link String }
         */
        public String getErrorMessage() {
            return errorMessage;
        }

        /**
         * Sets the value of the errorMessage property.
         *
         * @param value allowed object is
         *              {@link String }
         */
        public void setErrorMessage(String value) {
            this.errorMessage = value;
        }

        /**
         * Gets the value of the violatingElement property.
         *
         * @return possible object is
         * {@link String }
         */
        public String getViolatingElement() {
            return violatingElement;
        }

        /**
         * Sets the value of the violatingElement property.
         *
         * @param value allowed object is
         *              {@link String }
         */
        public void setViolatingElement(String value) {
            this.violatingElement = value;
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
     * <p/>
     * <p>The following schema fragment specifies the expected content contained within this class.
     * <p/>
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
     */
    @XmlAccessorType(XmlAccessType.FIELD)
    @XmlType(name = "", propOrder = {
            "value"
    })
    public static class Namespace
            implements Serializable {

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
         * @return possible object is
         * {@link String }
         */
        public String getValue() {
            return value;
        }

        /**
         * Sets the value of the value property.
         *
         * @param value allowed object is
         *              {@link String }
         */
        public void setValue(String value) {
            this.value = value;
        }

        /**
         * Gets the value of the prefix property.
         *
         * @return possible object is
         * {@link String }
         */
        public String getPrefix() {
            return prefix;
        }

        /**
         * Sets the value of the prefix property.
         *
         * @param value allowed object is
         *              {@link String }
         */
        public void setPrefix(String value) {
            this.prefix = value;
        }

        /**
         * Gets the value of the uri property.
         *
         * @return possible object is
         * {@link String }
         */
        public String getUri() {
            return uri;
        }

        /**
         * Sets the value of the uri property.
         *
         * @param value allowed object is
         *              {@link String }
         */
        public void setUri(String value) {
            this.uri = value;
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
