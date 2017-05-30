# ebInterface 5p0 wishlist (ph)

* Die Unterstützung von EN 16931 (CEN/TC 434) muss enthalten sein


## Technisches
  * Im Invoice.xsd core schema sollte `attributeFormDefault="unqualified"` gesetzt werden anstatt `attributeFormDefault="qualified"` - dann kann auch der Default-XML-Namespace ("") für ebInterface-Dokumente verwendet werden
    * Vorteil: es können ebInterface-Dateien ohne Präfix verwendet werden
    * Nachteil: es ändert sich was
  * Das Extension-Konzept sollte überdacht werden. Derzeit braucht man immer 4 XSDs (eb, extensions, SV und xmldsig) - evtl. können die Plugin-Anforderungen der SV in die reguläre Version (über Furtheridentification etc.) integriert werden und das Plugin-Konzept gekübelt werden.
    * Derzeit werden folgende Felder von der SV-Extension hinzugefügt:
      * `Biller/BillersContractPartnerNumber` (DigitExact6Type)
        * könnte in `FurtherIdentification` umgewandelt werden
      * `ListLineItem/BeneficiarySocialInsuranceNumber` (DigitExact10Type)
        `ListLineItem/BeneficiarySocialInsuranceNumber` müsste direkt bzw. als neues generisches "FurtherIdentification" auf Positionsebene definiert werden
    * Vorteile: 
      * Einfachere Struktur
      * keine Sonderbehandlung für bestimmte Branchen
    * Nachteile:
      * Existierende Implementierungen müssten angepasst werden  


## Entfernen alter Dinge
  * Signatur-Element entfernen. Dieses könnte in einen Envelope bzw. auf Transportschicht verschoben werden (AS2, AS4, etc). Da es keine Signaturverpflichtung für e-Rechnungen gibt muss das Element auch nicht mehr vorhanden sein.
    * Vorteil: keine Abhängigkeit zu externem XML Schema
    * Nachteil: es wird ein Envelope oder ein entsprechendes Protokoll vorausgesetzt wenn die elektronische Signatur notwendig ist
  * Die `PresentationDetails` sollten gelöscht werden, da es der Trennung zwischen Daten und Präsentation wiederspricht (oder in eine Extension herausgezogen werden wenn unbedingt notwendig)
    * Vorteile: kleineres XML-Schema
    * Nachteile: keine


## Inhaltliche Erweiterungen
  * In DirectDebit könnte analog zu SEPADirectDebit auch ein `DebitCollectionDate` aufgenommen werden
    * Vorteil: Vereinheitlichung; Annäherung an die Norm
  * Es sollte eine neue Extension für Workflow-Eigenschaften geben
    * P. Helger: sehe ich nicht so - ist keine Eigenschaft der Rechnung sondern der Übertragung - gehört ins TRansportprotokoll oder den Enveloper
  * Es sollte ein Feld für Verpackungseinheiten geben (z.B. in den `AdditionalInformation`). Das muss allerdings mit dem Element `BaseQuantity` aligned werden.
  * Evtl. sollte ein "Prepaid-Amount" unterstützt werden (ein Betrag der bereits bezahlt, und steuerlich abgehandelt ist - Anzahlung)
    * Vorteil: strukturierte Abhandlung dieser Information 


## Änderungen existierender Dinge    
  * Im derzeitigen `Address`-Typ sollten 0-n Email-Adressen zulässig sein statt bisher 0-1
  * Das `AdditionalInformation`-Element soll durch eine generische Schlüssel-Wert-Paar-Lösung ersetzt werden
    * Siehe Vorschlag auf den Folien des AK vom 29.11.2016
    * Das `Classification`-Element muss aber explizit beibehalten werden
    * Vorteile: Alignment mit der Norm; Wegfall der sehr selektiv vorhandenen Felder (Size, Weight, Boxes, Color)
  * Eventuell kann über eine Trennung von Person und Adresse nachgedacht werden (derzeit alles in `Address` drin)
    * Nicht jede Person hat eine Adresse
    * Nicht jede Adresse hat eine Person
    * Vorteile:
      * Es kann verschiedene Adressen zu einer Person geben
      * Es kann verschiedene Personen zu einer Adresse geben
    * Nachteil: relative große strukturelle Änderung  
