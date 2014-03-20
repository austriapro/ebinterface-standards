
package at.ebinterface.validation.rtr.generated;

import javax.xml.ws.WebFault;


/**
 * This class was generated by the JAX-WS RI.
 * JAX-WS RI 2.2.4-b01
 * Generated source version: 2.2
 * 
 */
@WebFault(name = "ErrorResponse", targetNamespace = "http://reference.e-government.gv.at/namespace/verificationservice/20120922#")
public class VerificationFault
    extends Exception
{

    /**
     * Java type that goes as soapenv:Fault detail element.
     * 
     */
    private ErrorResponse faultInfo;

    /**
     * 
     * @param message
     * @param faultInfo
     */
    public VerificationFault(String message, ErrorResponse faultInfo) {
        super(message);
        this.faultInfo = faultInfo;
    }

    /**
     * 
     * @param message
     * @param faultInfo
     * @param cause
     */
    public VerificationFault(String message, ErrorResponse faultInfo, Throwable cause) {
        super(message, cause);
        this.faultInfo = faultInfo;
    }

    /**
     * 
     * @return
     *     returns fault bean: at.ebinterface.validation.rtr.generated.ErrorResponse
     */
    public ErrorResponse getFaultInfo() {
        return faultInfo;
    }

}
