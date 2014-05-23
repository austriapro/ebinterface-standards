package at.ebinterface.validation.validator;

/**
 * Enumeration of currently supported ebInterface versions
 *
 * @author pl
 */
public enum EbInterfaceVersion {


    E3P0("http://www.ebinterface.at/schema/3p0/", "ebInterface 3.0"),
    E3P02("http://www.ebinterface.at/schema/3p02/", "ebInterface 3.02"),
    E4P0("http://www.ebinterface.at/schema/4p0/", "ebInterface 4.0"),
    E4P1("http://www.ebinterface.at/schema/4p1/", "ebInterface 4.1");

    private final String namespace;
    private final String caption;
    private boolean signed;
    private String signatureNamespacePrefix;


    private EbInterfaceVersion(final String s, final String caption) {
        this.namespace = s;
        this.caption = caption;
    }


    public String getNamespace() {
        return namespace;
    }


    public boolean isSigned() {
        return signed;
    }


    public void setSigned(final boolean signed) {
        this.signed = signed;
    }


    public String getSignatureNamespacePrefix() {
        return signatureNamespacePrefix;
    }


    public void setSignatureNamespacePrefix(final String signatureNamespacePrefix) {
        this.signatureNamespacePrefix = signatureNamespacePrefix;
    }

    public String getCaption() {
        return caption;
    }


}
