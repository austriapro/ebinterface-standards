package at.ebinterface.validation.validator;

/**
 * Enumeration of currently supported ebInterface versions
 * @author pl
 *
 */
public enum EbInterfaceVersion {


  E3P0("http://www.ebinterface.at/schema/3p0/"), E3P02("http://www.ebinterface.at/schema/3p02/"), E4P0("http://www.ebinterface.at/schema/4p0/");

  private final String namespace;
  private boolean signed;
  private String signatureNamespacePrefix;


  private EbInterfaceVersion(final String s) {
    this.namespace = s;
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
}
