ebInterface 5p0 wishlist
========================

* In DirectDebit könnte analog zu SEPADirectDebit auch ein `DebitCollectionDate` aufgenommen werden
* Im Invoice.xsd core schema sollte `attributeFormDefault="unqualified"` gesetzt werden anstatt `attributeFormDefault="qualified"` - dann kann auch der Default-XML-Namespace ("") für ebInterface-Dokumente verwendet werden
* Die `PresentationDetails` sollten gelöscht werden, da es der Trennung zwischen Daten und Präsentation wiederspricht (oder in eine Extension herausgezogen werden wenn unbedingt notwendig)
* Es sollte eine neue Extension für Workflow-Eigenschaften geben
  * P. Helger: sehe ich nicht so - ist keine Eigenschaft der Rechnung sondern der Übertragung
* Im derzeitigen `Address`-Typ sollten 0-n Email-Adressen zulässig sein statt bisher 0-1
* Es sollte ein Feld für Verpackungseinheiten geben (z.B. in den AdditionalInformation)
* Das `AdditionalInformation`-Element soll durch eine generische Schlüssel-Wert-Paar-Lösung ersetzt werden
  * Siehe Vorschlag auf den Folien des AK vom 29.11.2016
  * Das `Classification`-Element muss aber explizit beibehalten werden
* Eventuell kann über eine Trennung von Person und Adresse nachgedacht werden (derzeit alles in `Address` drin)
  * Nicht jede Person hat eine Adresse
  * Nicht jede Adresse hat eine Person
  * Es kann verschiedene Adressen zu einer Person geben
  * Es kann verschiedene Personen zu einer Adresse geben
* Das Extension-Konzept sollte überdacht werden. Derzeit braucht man immer 4 XSDs (eb, extensions, SV und xmldsig) - evtl. können die Plugin-Anforderungen der SV in die reguläre Version (über Furtheridentification etc.) integriert werden und das Plugin-Konzept gekübelt werden
* Die Unterstützung von EN 16931 (CEN/TC 434) muss enthalten sein
* Evtl. sollte ein "Prepaid-Amount" unterstützt werden (ein Betrag der bereits bezahlt, und steuerlich abgehandelt ist - Anzahlung)
 