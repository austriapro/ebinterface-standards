ebInterface 5p0 wishlist
========================

* In DirectDebit könnte analog zu SEPADirectDebit auch ein `DebitCollectionDate` aufgenommen werden
* Im Invoice.xsd core schema sollte `attributeFormDefault="unqualified"` gesetzt werden anstatt `attributeFormDefault="qualified"`
* Die `PresentationDetails` sollten in eine Extension herausgezogen werden (oder sogar gelöscht werden)
* Es sollte eine neue Extension für Workflow-Eigenschaften geben
* Im `Address`-Typ sollten 0-n Email-Adressen zulässig sein
* Es sollte ein Feld für Verpackungseinheiten geben (z.B. in den AdditionalInformation)
* Das `AdditionalInformation`-Element soll durch eine generische Schlüssel-Wert-Paar-Lösung ersetzt werden
  * Siehe Vorschlag auf den Folien des AK vom 29.11.2016
  * Das `Classification`-Element muss aber explizit beibehalten werden
* Eventuell kann über eine Trennung von Person und Adresse nachgedacht werden (derzeit alles in `Address` drin)
* Das Extension-Konzept sollte überdacht werden. Derzeit braucht man immer 4 XSDs (eb, extensions, SV und xmldsig)
