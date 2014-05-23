package at.ebinterface.validation.validator;

import java.io.Serializable;

/**
 * Represents a Schematron rule
 */
public class Rule implements Serializable {

    private String name;
    private EbInterfaceVersion ebInterfaceVersion;
    private String fileReference;


    public Rule() {
    }

    public Rule(String name, EbInterfaceVersion ebInterfaceVersion, String fileReference) {
        this.name = name;
        this.ebInterfaceVersion = ebInterfaceVersion;
        this.fileReference = fileReference;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public EbInterfaceVersion getEbInterfaceVersion() {
        return ebInterfaceVersion;
    }

    public void setEbInterfaceVersion(EbInterfaceVersion ebInterfaceVersion) {
        this.ebInterfaceVersion = ebInterfaceVersion;
    }

    public String getFileReference() {
        return fileReference;
    }

    public void setFileReference(String fileReference) {
        this.fileReference = fileReference;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof Rule)) {
            return false;
        }

        Rule rule = (Rule) o;

        if (ebInterfaceVersion != rule.ebInterfaceVersion) {
            return false;
        }
        if (fileReference != null ? !fileReference.equals(rule.fileReference) : rule.fileReference != null) {
            return false;
        }
        if (name != null ? !name.equals(rule.name) : rule.name != null) {
            return false;
        }

        return true;
    }

    @Override
    public int hashCode() {
        int result = name != null ? name.hashCode() : 0;
        result = 31 * result + (ebInterfaceVersion != null ? ebInterfaceVersion.hashCode() : 0);
        result = 31 * result + (fileReference != null ? fileReference.hashCode() : 0);
        return result;
    }
}
