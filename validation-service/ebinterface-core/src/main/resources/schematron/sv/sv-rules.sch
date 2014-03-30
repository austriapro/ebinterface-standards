<iso:schema    
  xmlns="http://purl.oclc.org/dsdl/schematron"  
  xmlns:iso="http://purl.oclc.org/dsdl/schematron" 
  xmlns:dp="http://www.dpawson.co.uk/ns#"
  queryBinding='xslt2'
  schemaVersion='ISO19757-3'>                  
  <iso:title>ebInterface 4.0 rules for SV specific extensions</iso:title>
  <iso:ns prefix='dp' uri='http://www.dpawson.co.uk/ns#'/> 
  <iso:ns prefix="n1" uri="http://www.ebinterface.at/schema/4p0/"/>
  <iso:ns uri="http://www.w3.org/2000/09/xmldsig#" prefix="dsig"/>
  <iso:ns uri="http://www.ebinterface.at/schema/4p0/extensions/ext" prefix="ext"/>
  <iso:ns uri="http://www.ebinterface.at/schema/4p0/extensions/sv" prefix="sv"/>
  <iso:ns uri="http://www.altova.com/samplexml/other-namespace" prefix="other"/>
    
 
	<!-- Rule 1: If a BillersContractPartnernNumber is present, make sure that the BillersContractPartnerNumber follows the rules defined by SV

		 Vertragspartnernummer (VPNR) 6 Stellen numerisch davon 5 Stellen Laufnummer und 1 Stelle Prüfziffer

                    Vertragspartnernummer:	7		4		1		2		5
                                                         x		x		x		x		x
                              Faktorenreihe	     3		7		5		1		6
                                            __________________________________
                                                        21   28	    5	    2	   30

		                    Summe = 86 : 11 = 7, Rest 9 = Prüfziffer

	Die Prüfziffer ist der Rst aus der Summer der Produkte geteilt durch 11.

XPath Expression:
((substring(/n1:Invoice/n1:Biller/ext:BillerExtension/sv:BillerExtension/sv:BillersContractPartnerNumber,1,1)*3 + substring(/n1:Invoice/n1:Biller/ext:BillerExtension/sv:BillerExtension/sv:BillersContractPartnerNumber,2,1)*7 + substring(/n1:Invoice/n1:Biller/ext:BillerExtension/sv:BillerExtension/sv:BillersContractPartnerNumber,3,1)*5 + substring(/n1:Invoice/n1:Biller/ext:BillerExtension/sv:BillerExtension/sv:BillersContractPartnerNumber,4,1) + substring(/n1:Invoice/n1:Biller/ext:BillerExtension/sv:BillerExtension/sv:BillersContractPartnerNumber,5,1)*6) mod 11) = substring(/n1:Invoice/n1:Biller/ext:BillerExtension/sv:BillerExtension/sv:BillersContractPartnerNumber,6,1)
    -->
  	<iso:pattern>
		<iso:rule context="/n1:Invoice/n1:Biller/ext:BillerExtension/sv:BillerExtension/sv:BillersContractPartnerNumber">
			<iso:assert test="((number(substring(/n1:Invoice/n1:Biller/ext:BillerExtension/sv:BillerExtension/sv:BillersContractPartnerNumber,1,1))*3 + number(substring(/n1:Invoice/n1:Biller/ext:BillerExtension/sv:BillerExtension/sv:BillersContractPartnerNumber,2,1))*7 + number(substring(/n1:Invoice/n1:Biller/ext:BillerExtension/sv:BillerExtension/sv:BillersContractPartnerNumber,3,1))*5 + number(substring(/n1:Invoice/n1:Biller/ext:BillerExtension/sv:BillerExtension/sv:BillersContractPartnerNumber,4,1)) + number(substring(/n1:Invoice/n1:Biller/ext:BillerExtension/sv:BillerExtension/sv:BillersContractPartnerNumber,5,1))*6) mod 11) = number(substring(/n1:Invoice/n1:Biller/ext:BillerExtension/sv:BillerExtension/sv:BillersContractPartnerNumber,6,1))">
			  BillersContractPartnerNumber found. The BillersContractPartnerNumber does not comply with the necessary rules for BillersContractPartnerNumber. 			
			</iso:assert>
		</iso:rule>
	</iso:pattern>	


	<!-- Rule 2: If a SVNR number is present, make sure that it follows the rules for a SVNR 

Die Versicherungsnummer ist ein 10-stelliger numerischer Begriff.

LLL	Laufnummer (ohne Rücksicht auf Geschlecht und Jahrhundert von 100 aufwärts)
P	Prüfziffer
TT	Geburtstag
MM	Geburtsmonat
JJ	Geburtsjahr


Die Berechnung der Prüfziffer (P).

Jede Stelle der Versicherungsnummer wird mit einem Faktor multipliziert.

Faktorenreihe
3, 7, 9	=	Laufnummer
5, 8, 4, 2, 1, 6	=	Geburtsdatum

Der Divisionsrest aus der Division der Summe der Produkte durch 11 ergibt die Prüfziffer. Alle Laufnummern, die mit Hilfe der angeführten Berechnung eine Prüfziffer 10 ergeben, werden zur Bildung einer Versicherungsnummer nicht herangezogen.
-->
	<iso:pattern>
		<iso:rule context="/n1:Invoice/n1:Details/n1:ItemList/n1:ListLineItem/ext:ListLineItemExtension/sv:ListLineItemExtension">
			<iso:assert test="if (sv:BeneficiarySocialInsuranceNumber) then ((number(substring(sv:BeneficiarySocialInsuranceNumber, 1,1))*3+number(substring(sv:BeneficiarySocialInsuranceNumber, 2,1))*7+number(substring(sv:BeneficiarySocialInsuranceNumber, 3,1))*9+number(substring(sv:BeneficiarySocialInsuranceNumber, 5,1))*5+number(substring(sv:BeneficiarySocialInsuranceNumber, 6,1))*8+number(substring(sv:BeneficiarySocialInsuranceNumber, 7,1))*4+number(substring(sv:BeneficiarySocialInsuranceNumber, 8,1))*2+number(substring(sv:BeneficiarySocialInsuranceNumber, 9,1))+number(substring(sv:BeneficiarySocialInsuranceNumber, 10,1))*6) mod 11=number(substring(sv:BeneficiarySocialInsuranceNumber, 4,1))) else boolean(1)">
				BeneficiarySocialInsuranceNumber found. The BeneficiarySocialInsuranceNumber does not comply with the necessary rules for a BeneficiarySocialInsuranceNumber.
			</iso:assert>
		</iso:rule>
	</iso:pattern>
	

</iso:schema>

