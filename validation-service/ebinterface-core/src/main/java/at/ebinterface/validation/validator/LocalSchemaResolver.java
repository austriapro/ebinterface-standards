package at.ebinterface.validation.validator;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.ls.LSInput;
import org.w3c.dom.ls.LSResourceResolver;

import javax.xml.crypto.dsig.XMLSignature;
import java.io.InputStream;
import java.io.Reader;

/**
 * Resolver for local schema definitions
 */
public class LocalSchemaResolver implements LSResourceResolver {

    private final LSResourceResolver parent;

    private static final Logger LOG = LoggerFactory
            .getLogger(LocalSchemaResolver.class);

    public LocalSchemaResolver(LSResourceResolver parent) {
        this.parent = parent;
    }

    @Override
    public LSInput resolveResource(String type, String namespaceURI,
                                   String publicId, String systemId, String baseURI) {
        LSInput input = new LSInputImpl();
        String url = null;

        //Replace specific schema
        if (XMLSignature.XMLNS.equals(namespaceURI)) {
            LOG.debug("Trying to resolve XMLDSIG Schema");
            url = "/schemas/xmldsig-core-schema.xsd";
        }
        //Replace the 4p0 extension schema
        else if ("http://www.ebinterface.at/schema/4p0/extensions/ext".equals(namespaceURI)) {
            LOG.debug("Trying to resolve 4p0 extension Schema");
            url = "/ebinterface/ebInterfaceExtension4p0.xsd";
        }
        //Replace the 4p0 SV extension schema
        else if ("http://www.ebinterface.at/schema/4p0/extensions/sv".equals(namespaceURI)) {
            LOG.debug("Trying to resolve 4p0 SV extension Schema");
            url = "/ebinterface/ext4p0/ebInterfaceExtension_SV.xsd";
        }
        //Replace the 4p1 extension schema
        else if ("http://www.ebinterface.at/schema/4p1/extensions/ext".equals(namespaceURI)) {
            LOG.debug("Trying to resolve 4p1 extension Schema");
            url = "/ebinterface/ebInterfaceExtension4p1.xsd";
        }
        //Replace the 4p1 SV extension schema
        else if ("http://www.ebinterface.at/schema/4p1/extensions/sv".equals(namespaceURI)) {
            LOG.debug("Trying to resolve 4p1 SV extension Schema");
            url = "/ebinterface/ext4p1/ebInterfaceExtension_SV.xsd";
        }

        //Replace with local url
        if (url != null) {
            InputStream is = this.getClass().getResourceAsStream(url);
            if (is != null) {
                LOG.debug("Found Schema at {}", this.getClass().getResource(url).toString());
                input.setByteStream(is);
                return input;
            } else {
                LOG.warn("Schema not found at {}", this.getClass().getResource(url).toString());
            }
        }

        return null;

    }

    class LSInputImpl implements LSInput {

        @Override
        public Reader getCharacterStream() {
            return null;
        }

        @Override
        public void setCharacterStream(Reader characterStream) {
        }

        @Override
        public InputStream getByteStream() {
            InputStream retval = null;
            if (byteStream != null) {
                retval = byteStream;
            }
            return retval;
        }

        @Override
        public void setByteStream(InputStream byteStream) {
            this.byteStream = byteStream;
        }

        @Override
        public String getStringData() {
            return null;
        }

        @Override
        public void setStringData(String stringData) {
        }

        @Override
        public String getSystemId() {
            return systemId;
        }

        @Override
        public void setSystemId(String systemId) {
            this.systemId = systemId;
        }

        @Override
        public String getPublicId() {
            return null;
        }

        @Override
        public void setPublicId(String publicId) {
        }

        @Override
        public String getBaseURI() {
            return null;
        }

        @Override
        public void setBaseURI(String baseURI) {
        }

        @Override
        public String getEncoding() {
            return null;
        }

        @Override
        public void setEncoding(String encoding) {
        }

        @Override
        public boolean getCertifiedText() {
            return false;
        }

        @Override
        public void setCertifiedText(boolean certifiedText) {
        }

        private String systemId = null;
        private InputStream byteStream = null;
    }

}
