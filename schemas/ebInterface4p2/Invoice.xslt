<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:eb="http://www.ebinterface.at/schema/4p2/" xmlns:dsig="http://www.w3.org/2000/09/xmldsig#">
	<!--
		XSLT for ebInterface 4.2
		For more information on ebInterface see http://www.ebinterface.at/

		Last update:	2015-12-10
		Author: 			Philipp Liegl, Vienna University of Technology
-->
	<xsl:output method="html" encoding="utf-8" indent="yes"/>
	<!-- ==================== ROOT ==================== -->
	<xsl:template match="/">
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
		<html lang="de">
			<head>
				<title>
					<xsl:value-of select="/eb:Invoice/@eb:DocumentTitle"/>
				</title>
				<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css"/>
				<meta name="viewport" content="width=device-width, initial-scale=1"/>
			</head>
			<body>
				<div class="container">
					<div class="row">
						<div class="col-md-12">&#160; </div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<!-- Issuer of invoice -->
							<xsl:apply-templates select="/eb:Invoice/eb:Biller"/>
							<br/>
							<br/>
							<!-- Invoice recipient -->
							<xsl:apply-templates select="/eb:Invoice/eb:InvoiceRecipient"/>
							<br/>
							<br/>
							<!-- Auftragggeber -->
							<xsl:apply-templates select="/eb:Invoice/eb:OrderingParty"/>
						</div>
						<div class="col-md-6">
							<!-- Logo -->
							<xsl:apply-templates select="/eb:Invoice/eb:PresentationDetails/eb:LogoURL"/>
							<!-- Type of document -->
							<h2>
								<xsl:call-template name="getDocumentType">
									<xsl:with-param name="documentType" select="/eb:Invoice/@eb:DocumentType"/>
								</xsl:call-template>
							</h2>
							<!-- Document number -->
							<xsl:apply-templates select="/eb:Invoice/eb:InvoiceNumber"/>
							<!-- Document date -->
							<xsl:apply-templates select="/eb:Invoice/eb:InvoiceDate"/>
							<!-- Document currency -->
							<xsl:apply-templates select="/eb:Invoice/@eb:InvoiceCurrency"/>
							<!-- Optional document title -->
							<xsl:if test="/eb:Invoice/@eb:DocumentTitle">
								<xsl:value-of select="/eb:Invoice/@eb:DocumentTitle"/>
								<br/>
							</xsl:if>
							<!-- Original or copy? -->
							<xsl:if test="/eb:Invoice/@eb:IsDuplicate">
								<span class="label label-danger">Das ist eine Rechnungskopie</span>
								<br/>
							</xsl:if>
							<!-- Cancelled document -->
							<xsl:apply-templates select="/eb:Invoice/eb:CancelledOriginalDocument"/>
							<!-- Related documents -->
							<xsl:if test="/eb:Invoice/eb:RelatedDocument">
								<br/>
								Referenzierte Dokumente:<br/>
								<ul>
									<xsl:apply-templates select="/eb:Invoice/eb:RelatedDocument"/>
								</ul>
							</xsl:if>
							<!-- Delivery details -->
							<xsl:apply-templates select="/eb:Invoice/eb:Delivery"/>
						</div>
					</div>
					<!-- Line item details -->
					<div class="row">
						<div class="col-md-12">
							<h3>Rechnungsdetails</h3>
							<xsl:apply-templates select="/eb:Invoice/eb:Details"/>
						</div>
					</div>
					<!-- Below the line items -->
					<div class="row">
						<div class="col-md-12">
							<!-- Below the line items -->
							<xsl:if test="/eb:Invoice/eb:Details/eb:BelowTheLineItem">
								<h4>Weitere nicht steuerrelevante Beträge</h4>
								<table class="table">
									<thead>
										<tr>
											<th>Beschreibung</th>
											<th>Begründung</th>
											<th>Datum</th>
											<th>
												<p class="text-right">Betrag</p>
											</th>
										</tr>
									</thead>
									<tbody>
										<xsl:apply-templates select="/eb:Invoice/eb:Details/eb:BelowTheLineItem"/>
									</tbody>
								</table>
							</xsl:if>
						</div>
					</div>
					<!-- Reductions and surcharges (ROOT level) -->
					<div class="row">
						<div class="col-md-12">
							<xsl:if test="/eb:Invoice/eb:ReductionAndSurchargeDetails">
								<h4>Auf-/Abschläge</h4>
								<table class="table">
									<thead>
										<tr>
											<th>Art</th>
											<th>
												<p class="text-right">Basisbetrag</p>
											</th>
											<th>
												<p class="text-right">Prozent</p>
											</th>
											<th>
												<p class="text-right">Steuer</p>
											</th>
											<th>
												<p class="text-right">Betrag</p>
											</th>
										</tr>
									</thead>
									<tbody>
										<xsl:apply-templates select="/eb:Invoice/eb:ReductionAndSurchargeDetails/eb:Reduction"/>
										<xsl:apply-templates select="/eb:Invoice/eb:ReductionAndSurchargeDetails/eb:Surcharge"/>
										<xsl:apply-templates select="/eb:Invoice/eb:ReductionAndSurchargeDetails/eb:OtherVATableTax"/>
									</tbody>
								</table>
							</xsl:if>
						</div>
					</div>
					<!-- Steuern -->
					<div class="row">
						<div class="col-md-12">
							<!-- VAT and Other Tax -->
							<xsl:apply-templates select="/eb:Invoice/eb:Tax/eb:VAT"/>
							<!-- Other Tax -->
							<xsl:if test="/eb:Invoice/eb:Tax/eb:OtherTax">
								<!-- Other tax -->
								<h4>Weitere Steuern</h4>
								<table class="table">
									<thead>
										<tr>
											<th>Bezeichnung</th>
											<th>
												<p class="text-right">Betrag</p>
											</th>
										</tr>
									</thead>
									<tbody>
										<xsl:for-each select="/eb:Invoice/eb:Tax/eb:OtherTax">
											<tr>
												<td>
													<xsl:value-of select="eb:Comment"/>
												</td>
												<td>
													<p class="text-right">
														<xsl:call-template name="prettyPrintNumberFunction">
															<xsl:with-param name="number" select="eb:Amount"/>
														</xsl:call-template>
													</p>
												</td>
											</tr>
										</xsl:for-each>
									</tbody>
								</table>
							</xsl:if>
						</div>
					</div>
					<!-- Gesamtbrutto und zahlbarer Betrag -->
					<div class="row">
						<div class="col-md-12">
							<table class="table">
								<tbody>
									<tr>
										<td>
											Gesamt Brutto
										</td>
										<td>
											<p class="text-right">
												<xsl:call-template name="prettyPrintNumberFunction">
													<xsl:with-param name="number" select="eb:Invoice/eb:TotalGrossAmount"/>
												</xsl:call-template>
											</p>
										</td>
									</tr>
									<tr>
										<td>
											<b>Zu zahlender Betrag</b>
										</td>
										<td>
											<p class="text-right"><strong>
												<xsl:call-template name="prettyPrintNumberFunction">
													<xsl:with-param name="number" select="eb:Invoice/eb:PayableAmount"/>
												</xsl:call-template></strong>
											</p>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<!-- Zahlungsmethode -->
					<div class="row">
						<div class="col-md-12">
							<xsl:if test="/eb:Invoice/eb:PaymentMethod">
								<h4>Zahlungsmethode</h4>
								<xsl:apply-templates select="/eb:Invoice/eb:PaymentMethod/eb:Comment"/>
								<xsl:apply-templates select="/eb:Invoice/eb:PaymentMethod/eb:NoPayment"/>
								<xsl:apply-templates select="/eb:Invoice/eb:PaymentMethod/eb:DirectDebit"/>
								<xsl:apply-templates select="/eb:Invoice/eb:PaymentMethod/eb:SEPADirectDebit"/>
								<xsl:apply-templates select="/eb:Invoice/eb:PaymentMethod/eb:UniversalBankTransaction"/>
							</xsl:if>
						</div>
					</div>
					<!-- Zahlungsbedingungen -->
					<div class="row">
						<div class="col-md-12">
							<xsl:if test="/eb:Invoice/eb:PaymentConditions">
								<h4>Zahlungsbedingungen</h4>
								Zahlbar bis:
								<xsl:call-template name="prettyPrintDateFunction">
									<xsl:with-param name="dateString" select="/eb:Invoice/eb:PaymentConditions/eb:DueDate"/>
								</xsl:call-template>
								<!-- Skonto -->
								<xsl:if test="/eb:Invoice/eb:PaymentConditions/eb:Discount">
									<xsl:apply-templates select="/eb:Invoice/eb:PaymentConditions/eb:Discount"/>
								</xsl:if>
								<!-- Minimum payment -->
								<xsl:if test="/eb:Invoice/eb:PaymentConditions/eb:MinimumPayment">
									<br/>Mindestens zu zahlender Betrag:
														<xsl:call-template name="prettyPrintNumberFunction">
										<xsl:with-param name="number" select="/eb:Invoice/eb:PaymentConditions/eb:MinimumPayment"/>
									</xsl:call-template>
								</xsl:if>
								<!-- Comment -->
								<xsl:if test="/eb:Invoice/eb:PaymentConditions/eb:Comment">
									<br/>Kommentar: <xsl:apply-templates select="/eb:Invoice/eb:PaymentConditions/eb:Comment"/>
								</xsl:if>
							</xsl:if>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">
							<xsl:if test="/eb:Invoice/eb:Comment">
								<h4>Kommentar zur Rechnung</h4>
								<xsl:value-of select="/eb:Invoice/eb:Comment"/>
							</xsl:if>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">
							&#160;
						</div>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
	<!--
========================================
	 Templates for sub-elements
========================================
-->

	<!-- ==================== AccountingArea ==================== -->
	<xsl:template match="eb:AccountingArea">
		Buchungskreis: <xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<!-- ==================== AdditionalInformation(LineItem level)  ==================== -->
	<xsl:template match="eb:AdditionalInformation">
		<br/>
		<strong>Weitere Artikeldetails:</strong>
		<br/>
		<ul>
			<xsl:apply-templates select="eb:SerialNumber"/>
			<xsl:apply-templates select="eb:ChargeNumber"/>
			<xsl:apply-templates select="eb:Classification"/>
			<xsl:apply-templates select="eb:AlternativeQuantity"/>
			<xsl:apply-templates select="eb:Size"/>
			<xsl:apply-templates select="eb:Weight"/>
			<xsl:apply-templates select="eb:Boxes"/>
			<xsl:apply-templates select="eb:Color"/>
		</ul>
	</xsl:template>
<!-- ==================== Address ==================== -->
	<xsl:template match="//eb:Address">
		<xsl:value-of select="eb:Salutation"/>
		<br/>
		<xsl:value-of select="eb:Name"/>
		<br/>
		<xsl:value-of select="eb:Street"/>
		<br/>
		<xsl:apply-templates select="eb:POBox"/>
		<xsl:apply-templates select="eb:Town"/>
		<xsl:value-of select="eb:Country"/>
		<br/>
		<xsl:apply-templates select="eb:Phone"/>
		<xsl:apply-templates select="eb:Email"/>
		<xsl:apply-templates select="eb:Contact"/>
		<xsl:apply-templates select="eb:AddressExtension"/>
		<xsl:apply-templates select="eb:AddressIdentifier"/>
	</xsl:template>
	<xsl:template match="eb:AddressExtension">
		<xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<xsl:template match="eb:Contact">
		Ansprechperson: <xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<xsl:template match="eb:POBox">
		<xsl:text>Postfach: </xsl:text>
		<xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<xsl:template match="eb:Town">
		<xsl:value-of select="following::eb:ZIP"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<xsl:template match="eb:ZIP"/>
	<xsl:template match="eb:Phone">
		<xsl:text>Tel: </xsl:text>
		<xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<xsl:template match="eb:Email">
		<xsl:text>E-Mail: </xsl:text>
		<xsl:element name="a">
			<xsl:attribute name="href">mailto:<xsl:value-of select="."/></xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:element>
		<br/>
	</xsl:template>
	<!-- ==================== Address Identifier ==================== -->
	<xsl:template match="//eb:AddressIdentifier">
		<xsl:choose>
			<xsl:when test=".">
				<!-- Print a German expression for ProprietaryAddressID -->
				<xsl:choose>
					<xsl:when test="@eb:AddressIdentifierType = 'ProprietaryAddressID'">
					Propietäre ID</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@eb:AddressIdentifierType"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:text>: </xsl:text>
				<xsl:value-of select="."/>
				<br/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- ==================== Alternative Quantity (LineItem level)  ==================== -->
	<xsl:template match="eb:AlternativeQuantity">
		<li>Alternative Menge: <xsl:value-of select="."/>&#160;<xsl:value-of select="@eb:Unit"/>
		</li>
	</xsl:template>
	<!-- ==================== ArticleNumber(LineItem level)  ==================== -->
	<xsl:template match="eb:ArticleNumber">
		<xsl:choose>
			<xsl:when test=".">
				<xsl:choose>
					<xsl:when test="@eb:ArticleNumberType='InvoiceRecipientsArticleNumber'">
							ArtikelNr. d. Rechnungsempfängers
						</xsl:when>
					<xsl:when test="@eb:ArticleNumberType='BillersArticleNumber'">
							ArtikelNr. d. Rechnungsstellers</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@eb:ArticleNumberType"/>
					</xsl:otherwise>
				</xsl:choose>:
				<xsl:value-of select="."/>
				<br/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- ==================== Below the line items ==================== -->
	<xsl:template match="/eb:Invoice/eb:Details/eb:BelowTheLineItem">
		<tr>
			<td>
				<xsl:value-of select="eb:Description"/>
			</td>
			<td>
				<xsl:value-of select="eb:Reason"/>
			</td>
			<td>
				<xsl:call-template name="prettyPrintDateFunction">
					<xsl:with-param name="dateString" select="eb:Reason/@eb:Date"/>
				</xsl:call-template>
			</td>
			<td>
				<p class="text-right">
					<xsl:call-template name="prettyPrintNumberFunction">
						<xsl:with-param name="number" select="eb:LineItemAmount"/>
					</xsl:call-template>
				</p>
			</td>
		</tr>
	</xsl:template>
	<!-- ==================== Beneficiary account ==================== -->
	<xsl:template match="eb:BeneficiaryAccount">
		<br/>
		<strong>Konto</strong>
		<br/>
		Name der Bank: <xsl:value-of select="eb:BankName"/>
		<br/>
		Bankleitzahl: <xsl:value-of select="eb:BankCode"/>
		<br/>
		BIC: <xsl:value-of select="eb:BIC"/>
		<br/>
		Kontonummer: <xsl:value-of select="eb:BankAccountNr"/>
		<br/>
		IBAN: <xsl:value-of select="eb:IBAN"/>
		<br/>
		Kontoinhaber: <xsl:value-of select="eb:BankAccountOwner"/>
		<br/>
	</xsl:template>
	<!-- ==================== Biller ==================== -->
	<xsl:template match="/eb:Invoice/eb:Biller">
		<span class="label label-primary">Rechnungssteller</span>
		<br/>
		<xsl:apply-templates select="eb:Address"/>
		<br/>
		<xsl:apply-templates select="eb:InvoiceRecipientsBillerID"/>
		<xsl:apply-templates select="eb:VATIdentificationNumber"/>
		<xsl:apply-templates select="eb:FurtherIdentification"/>
		<xsl:apply-templates select="eb:OrderReference"/>
	</xsl:template>
	<xsl:template match="eb:InvoiceRecipientsBillerID">
		ID beim Rechnungsempfänger: <xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<!-- ==================== BillersInvoiceRecipientID ==================== -->
	<xsl:template match="eb:BillersInvoiceRecipientID">
		ID beim Rechnungsssteller: <xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<!-- ==================== BillersOrderReference (LineItem level)  ==================== -->
	<xsl:template match="eb:BillersOrderReference">
		<li>
		Vom Rechnungssteller vergebene Referenz auf die zugrundeliegende Bestellung:
		<xsl:value-of select="eb:OrderID"/>
			<xsl:if test="eb:ReferenceDate">
			vom
			<xsl:call-template name="prettyPrintDateFunction">
					<xsl:with-param name="dateString" select="eb:ReferenceDate"/>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="eb:Description">
			(<xsl:value-of select="eb:Description"/>),
		</xsl:if>
			<xsl:if test="eb:OrderPositionNumber">
			Relevante Positionsnummer in der Bestellung: <xsl:value-of select="eb:OrderPositionNumber"/>
			</xsl:if>
		</li>
	</xsl:template>
	<!-- ==================== Boxes (LineItem level) ==================== -->
	<xsl:template match="eb:Boxes">
		<li>Kisten/Container: <xsl:value-of select="."/>
		</li>
	</xsl:template>
	<!-- ==================== Cancelled Orginal Document ==================== -->
	<xsl:template match="/eb:Invoice/eb:CancelledOriginalDocument">
		<br/>
		Storno für für fehlerhafte
        <xsl:call-template name="getDocumentType">
			<xsl:with-param name="documentType" select="../@eb:DocumentType"/>
		</xsl:call-template>
		Nr.
		<xsl:value-of select="eb:InvoiceNumber"/>
		vom
		<xsl:call-template name="prettyPrintDateFunction">
			<xsl:with-param name="dateString" select="eb:InvoiceDate"/>
		</xsl:call-template>
		(<xsl:value-of select="eb:Comment"/>)
		<br/>
	</xsl:template>
	<!-- ==================== Charge number (LineItem level) ==================== -->
	<xsl:template match="eb:ChargeNumber">
		<li>Chargennummer: <xsl:value-of select="."/>
		</li>
	</xsl:template>
	<!-- ==================== Classification (LineItem level) ==================== -->
	<xsl:template match="eb:Classification">
		<li>
			<xsl:value-of select="@eb:ClassificationSchema"/>: <xsl:value-of select="."/>
		</li>
	</xsl:template>
	<!-- ==================== Color (LineItem level) ==================== -->
	<xsl:template match="eb:Color">
		<li>Farbe: <xsl:value-of select="."/>
		</li>
	</xsl:template>
	<!-- ==================== Comment ==================== -->
	<xsl:template match="eb:PaymentMethod/eb:Comment">
		<xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<!-- ==================== Date ==================== -->
	<xsl:template match="eb:Date">
		Lieferdatum:
		<xsl:call-template name="prettyPrintDateFunction">
			<xsl:with-param name="dateString" select="."/>
		</xsl:call-template>
		<br/>
	</xsl:template>
	<!-- ==================== Delivery (ROOT level) ==================== -->
	<xsl:template match="/eb:Invoice/eb:Delivery">
		<span class="label label-primary">Lieferdetails</span>
		<br/>
		<xsl:apply-templates select="node()"/>
	</xsl:template>
	<!-- ==================== Delivery  ==================== -->
	<xsl:template match="eb:Delivery">
		<br/>
		<xsl:apply-templates select="eb:Address"/>
		<br/>
		<xsl:apply-templates select="eb:DeliveryID"/>
		<xsl:apply-templates select="eb:Date"/>
		<xsl:apply-templates select="eb:Period"/>
		<xsl:apply-templates select="eb:Description"/>
	</xsl:template>
	<!-- ==================== Delivery (LineItem level)  ==================== -->
	<xsl:template match="eb:ListLineItem/eb:Delivery">
		<span class="label label-primary">Lieferadresse für diesen Artikel:</span>
		<br/>
		<xsl:apply-templates select="node()"/>
	</xsl:template>
		<!-- ==================== DeliveryID ==================== -->
	<xsl:template match="eb:DeliveryID">
		Liefer-ID: <xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<!-- ==================== Description ==================== -->
	<xsl:template match="/eb:Description">
		Hinweise zur Lieferung: <xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<!-- ==================== Details ==================== -->
	<xsl:template match="/eb:Invoice/eb:Details">
		<!-- Header description per ItemList -->
		<xsl:apply-templates select="eb:HeaderDescription"/>
		<!-- Iterate over the different item lists -->
		<xsl:for-each select="eb:ItemList">
			<h4>Verrechnete Positionen</h4>
			<xsl:apply-templates select="eb:HeaderDescription"/>
			<table class="table table-condensed">
				<thead>
					<tr>
						<th>Pos-Nr.</th>
						<th>Bezeichnung</th>
						<th>Artikelnr.</th>
						<th>USt.</th>
						<th>Menge</th>
						<th>Einzelpreis</th>
						<th>Auf-/Abschläge</th>
						<th>
							<p class="text-right">Gesamtpreis</p>
						</th>
					</tr>
				</thead>
				<tbody>
					<xsl:for-each select="eb:ListLineItem">
						<tr>
							<td>
								<!-- Position number -->
								<xsl:choose>
									<xsl:when test="eb:PositionNumber">
										<xsl:value-of select="eb:PositionNumber"/>
									</xsl:when>
									<xsl:otherwise>
										<!-- If no position number is present, we take the current iterator value -->
										<xsl:value-of select="position()"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td>
								<!-- Description -->
								<xsl:value-of select="eb:Description"/>
							</td>
							<td>
								<!-- Article number-->
								<xsl:apply-templates select="eb:ArticleNumber"/>
							</td>
							<td>
								<!-- Ust (either TaxExemption or VATRate)-->
								<xsl:apply-templates select="eb:TaxExemption"/>
								<xsl:apply-templates select="eb:VATRate"/>
							</td>
							<td>
								<!-- Quantity-->
								<xsl:apply-templates select="eb:Quantity"/>
							</td>
							<td>
								<!-- Unit price-->
								<xsl:apply-templates select="eb:UnitPrice"/>
							</td>
							<td>
								<!-- Reductions/Surcharges-->
								<xsl:apply-templates select="eb:ReductionAndSurchargeListLineItemDetails"/>
							</td>
							<td>
								<!-- Line item total-->
								<p class="text-right">
									<xsl:apply-templates select="eb:LineItemAmount"/>
								</p>
							</td>
						</tr>
						<!-- Second row for the other article details -->
						<tr>
							<td colspan="4">
								<strong>Zusätzliche Informationen zum Artikel:</strong>
								<br/>
								<ul>
									<!-- Hint if article is discountable or not -->
									<xsl:apply-templates select="eb:DiscountFlag"/>
									<!-- Biller's order reference -->
									<xsl:apply-templates select="eb:BillersOrderReference"/>
									<!--Invoice recipient's order reference -->
									<xsl:apply-templates select="eb:InvoiceRecipientsOrderReference"/>
								</ul>
								<!-- Additional information -->
								<xsl:apply-templates select="eb:AdditionalInformation"/>
							</td>
							<td colspan="3">
								<!-- Delivery address for this article -->
								<xsl:apply-templates select="eb:Delivery"/>
							</td>
							<td>&#160;</td>
						</tr>
					</xsl:for-each>
				</tbody>
			</table>
			<xsl:apply-templates select="eb:FooterDescription"/>
		</xsl:for-each>
		<!-- Footer description per ItemList -->
		<xsl:apply-templates select="eb:FooterDescription"/>
	</xsl:template>
	<!-- ==================== DirectDebit ==================== -->
	<xsl:template match="eb:DirectDebit">
		<br/>Keine Zahlung notwendig. Betrag wird direkt von Ihrem Konto abgebucht.<br/>
	</xsl:template>
	<!-- ==================== Discount ==================== -->
	<xsl:template match="eb:PaymentConditions/eb:Discount">
		<br/>
		<strong>Skonto</strong>:<br/>
		Skonto gewährt bis:
		<xsl:call-template name="prettyPrintDateFunction">
			<xsl:with-param name="dateString" select="eb:PaymentDate"/>
		</xsl:call-template>
		<br/>
		Basisbetrag:
		<xsl:call-template name="prettyPrintNumberFunction">
			<xsl:with-param name="number" select="eb:BaseAmount"/>
		</xsl:call-template>
		<br/>
		Skonto-Prozentsatz: <xsl:call-template name="prettyPrintNumberFunction">
			<xsl:with-param name="number" select="eb:Percentage"/>
		</xsl:call-template>%<br/>
		Betrag: <xsl:call-template name="prettyPrintNumberFunction">
			<xsl:with-param name="number" select="eb:Amount"/>
		</xsl:call-template>
		<br/>
	</xsl:template>
	<!-- ==================== Discount flag (LineItem level)  ==================== -->
	<xsl:template match="eb:DiscountFlag">
		<li>
			<xsl:choose>
				<xsl:when test="eb:DiscountFlag = true()">
			Artikel ist skontofähig
		</xsl:when>
				<xsl:otherwise>
			Artikel ist nicht skontofähig
		</xsl:otherwise>
			</xsl:choose>
			<br/>
		</li>
	</xsl:template>
	<!-- ==================== FooterDescription (LineItem level)  ==================== -->
	<xsl:template match="eb:FooterDescription">
		<xsl:value-of select="."/>
		<br/>
		<br/>
	</xsl:template>
	<!-- ==================== Further identification ==================== -->
	<xsl:template match="//eb:FurtherIdentification">
		<xsl:choose>
			<xsl:when test=".">
				<xsl:value-of select="@eb:IdentificationType"/>
				<xsl:text>: </xsl:text>
				<xsl:value-of select="."/>
				<br/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- ==================== HeaderDescription (LineItem level)  ==================== -->
	<xsl:template match="eb:HeaderDescription">
		<xsl:value-of select="."/>
		<br/>
		<br/>
	</xsl:template>
	<!-- ==================== Invoice currency ==================== -->
	<xsl:template match="/eb:Invoice/@eb:InvoiceCurrency">
	   Alle Beträge in: <xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<!-- ==================== Invoice date ==================== -->
	<xsl:template match="/eb:Invoice/eb:InvoiceDate">
		Datum:
		<xsl:call-template name="prettyPrintDateFunction">
			<xsl:with-param name="dateString" select="."/>
		</xsl:call-template>
		<br/>
	</xsl:template>
	<!-- ==================== Invoice number ==================== -->
	<xsl:template match="/eb:Invoice/eb:InvoiceNumber">
		Nr.: <xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<!-- ==================== InvoiceRecipient ==================== -->
	<xsl:template match="/eb:Invoice/eb:InvoiceRecipient">
		<span class="label label-primary">Rechnungsempfänger</span>
		<br/>
		<xsl:apply-templates select="eb:Address"/>
		<br/>
		<xsl:apply-templates select="eb:BillersInvoiceRecipientID"/>
		<xsl:apply-templates select="eb:AccountingArea"/>
		<xsl:apply-templates select="eb:SubOrganizationID"/>
		<xsl:apply-templates select="eb:VATIdentificationNumber"/>
		<xsl:apply-templates select="eb:FurtherIdentification"/>
		<xsl:apply-templates select="eb:OrderReference"/>
	</xsl:template>
	<!-- ==================== InvoiceRecipientsOrderReference (LineItem level)  ==================== -->
	<xsl:template match="eb:InvoiceRecipientsOrderReference">
		<li>
		Vom Rechnungsempfänger vergebene Referenz auf die zugrundeliegende Bestellung:
		<xsl:value-of select="eb:OrderID"/>
			<xsl:if test="eb:ReferenceDate">
			vom
			<xsl:call-template name="prettyPrintDateFunction">
					<xsl:with-param name="dateString" select="eb:ReferenceDate"/>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="eb:Description">
			(<xsl:value-of select="eb:Description"/>),
		</xsl:if>
			<xsl:if test="eb:OrderPositionNumber">
			Relevante Positionsnummer in der Bestellung: <xsl:value-of select="eb:OrderPositionNumber"/>
			</xsl:if>
		</li>
	</xsl:template>
	<!-- ==================== LineItemAmount (LineItem level)  ==================== -->
	<xsl:template match="eb:LineItemAmount">
		<xsl:call-template name="prettyPrintNumberFunction">
			<xsl:with-param name="number" select="."/>
		</xsl:call-template>
	</xsl:template>
	<!-- ==================== Logo URL ==================== -->
	<xsl:template match="/eb:PresentationDetails/eb:LogoURL">
		<xsl:choose>
			<xsl:when test="preceding::eb:URL">
				<xsl:element name="a">
					<xsl:attribute name="href"><xsl:value-of select="preceding::eb:URL"/></xsl:attribute>
					<xsl:element name="img">
						<xsl:attribute name="src"><xsl:value-of select="."/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="."/></xsl:attribute>
					</xsl:element>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:element name="img">
					<xsl:attribute name="src"><xsl:value-of select="."/></xsl:attribute>
					<xsl:attribute name="alt"><xsl:value-of select="."/></xsl:attribute>
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ==================== NoPayment  ==================== -->
	<xsl:template match="eb:NoPayment">
		<br/>Keine Zahlung notwendig.<br/>
	</xsl:template>
	<!-- ==================== Ordering party ==================== -->
	<xsl:template match="//eb:OrderingParty">
		<span class="label label-primary">Auftraggeber</span>
		<br/>
		<xsl:apply-templates select="eb:Address"/>
		<br/>
		<xsl:apply-templates select="eb:BillersOrderingPartyID"/>
		<xsl:apply-templates select="eb:VATIdentificationNumber"/>
		<xsl:apply-templates select="eb:FurtherIdentification"/>
		<xsl:apply-templates select="eb:OrderReference"/>
	</xsl:template>
	<xsl:template match="eb:BillersOrderingPartyID">
		ID beim Besteller: <xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<!-- ==================== Order reference ==================== -->
	<xsl:template match="//eb:OrderReference">
		Bestellreferenz:
		<xsl:value-of select="eb:OrderID"/>
		<xsl:if test="eb:ReferenceDate">
			vom
			<xsl:call-template name="prettyPrintDateFunction">
				<xsl:with-param name="dateString" select="eb:ReferenceDate"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="eb:Description">
			(<xsl:value-of select="eb:Description"/>)
		</xsl:if>
		<br/>
	</xsl:template>
	<!-- ==================== OtherTax (LineItem level) ==================== -->
	<xsl:template match="eb:VAT/eb:OtherTax	">
		<tr>
			<td>
				<xsl:value-of select="eb:Comment"/>
			</td>
			<td>
				<xsl:call-template name="prettyPrintNumberFunction">
					<xsl:with-param name="number" select="eb:Amount"/>
				</xsl:call-template>
			</td>
		</tr>
	</xsl:template>
	<!-- ==================== OtherVATableTax ==================== -->
	<xsl:template match="eb:OtherVATableTax">
		<tr>
			<td>
				Sonstige Steuer, die nicht mehr der USt unterliegt <br/>
				TaxID: <xsl:value-of select="eb:TaxID"/>
				<xsl:if test="eb:Comment">
					(<xsl:value-of select="eb:Comment"/>)
				</xsl:if>
			</td>
			<td>
				<p class="text-right">
					<xsl:call-template name="prettyPrintNumberFunction">
						<xsl:with-param name="number" select="eb:BaseAmount"/>
					</xsl:call-template>
				</p>
			</td>
			<td>
				<p class="text-right">
					<xsl:call-template name="prettyPrintNumberFunction">
						<xsl:with-param name="number" select="eb:Percentage"/>
					</xsl:call-template>%
				</p>
			</td>
			<td>
				<p class="text-right">
					<xsl:call-template name="prettyPrintNumberFunction">
						<xsl:with-param name="number" select="eb:VATRate"/>
					</xsl:call-template>%
				</p>
			</td>
			<td>
				<p class="text-right">
					<xsl:call-template name="prettyPrintNumberFunction">
						<xsl:with-param name="number" select="eb:Amount"/>
					</xsl:call-template>
				</p>
			</td>
		</tr>
	</xsl:template>
	<!-- ==================== Period ==================== -->
	<xsl:template match="eb:Period">
		Lieferzeit zwischen
		<xsl:call-template name="prettyPrintDateFunction">
			<xsl:with-param name="dateString" select="eb:FromDate"/>
		</xsl:call-template>
		und
		<xsl:call-template name="prettyPrintDateFunction">
			<xsl:with-param name="dateString" select="eb:ToDate"/>
		</xsl:call-template>
	</xsl:template>
	<!-- ==================== Quantity (LineItem level) ==================== -->
	<xsl:template match="eb:Quantity">
		<xsl:call-template name="prettyPrintNumberFunction">
			<xsl:with-param name="number" select="."/>
		</xsl:call-template>&#160;<xsl:value-of select="@eb:Unit"/>
	</xsl:template>
	<!-- ==================== Reduction & Surcharge (LineItem level) ==================== -->
	<xsl:template match="eb:ReductionAndSurchargeListLineItemDetails/eb:OtherVATableTaxListLineItem">
		<br/>
		<strong>Weitere Steuern, die nicht der USt unterliegen:</strong>
		<br/>
		Basisbetrag:
		           <xsl:call-template name="prettyPrintNumberFunction">
			<xsl:with-param name="number" select="eb:BaseAmount"/>
		</xsl:call-template>
		<xsl:if test="eb:Percentage">
			<br/>Prozent:
			        <xsl:call-template name="prettyPrintNumberFunction">
				<xsl:with-param name="number" select="eb:Percentage"/>
			</xsl:call-template>%
		</xsl:if>
		<xsl:if test="eb:Amount">
			<br/>Betrag:
			       <xsl:call-template name="prettyPrintNumberFunction">
				<xsl:with-param name="number" select="eb:Amount"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="eb:Comment">
			<br/>Kommentar: <xsl:value-of select="eb:Comment"/>
		</xsl:if>
	</xsl:template>
	<!-- ==================== Reductions and Surcharges ==================== -->
	<xsl:template match="eb:Reduction | eb:Surcharge">
		<tr>
			<td>
				<xsl:choose>
					<xsl:when test="name() = 'Reduction'">
					Abschlag
				</xsl:when>
					<xsl:otherwise>
				    Aufschlag
				</xsl:otherwise>
				</xsl:choose>
			</td>
			<td>
				<p class="text-right">
					<xsl:call-template name="prettyPrintNumberFunction">
						<xsl:with-param name="number" select="eb:BaseAmount"/>
					</xsl:call-template>
				</p>
			</td>
			<td>
				<p class="text-right">
					<xsl:call-template name="prettyPrintNumberFunction">
						<xsl:with-param name="number" select="eb:Percentage"/>
					</xsl:call-template>%
				</p>
			</td>
			<td>
				<p class="text-right">
					<xsl:call-template name="prettyPrintNumberFunction">
						<xsl:with-param name="number" select="eb:VATRate"/>
					</xsl:call-template>%
				</p>
			</td>
			<td>
				<p class="text-right">
					<xsl:call-template name="prettyPrintNumberFunction">
						<xsl:with-param name="number" select="eb:Amount"/>
					</xsl:call-template>
				</p>
			</td>
		</tr>
	</xsl:template>
	<!-- ==================== Reduction and surcharge (LineItem level) ==================== -->
	<xsl:template match="eb:ReductionAndSurchargeListLineItemDetails/eb:ReductionListLineItem | eb:ReductionAndSurchargeListLineItemDetails/eb:SurchargeListLineItem">
		<strong>
			<xsl:choose>
				<xsl:when test="name() = 'ReductionListLineItem'">
					Abschlag:
				</xsl:when>
				<xsl:otherwise>
				    Aufschlag:
				</xsl:otherwise>
			</xsl:choose>
		</strong>
		<br/>Basisbetrag:
							<xsl:call-template name="prettyPrintNumberFunction">
			<xsl:with-param name="number" select="eb:BaseAmount"/>
		</xsl:call-template>
		<xsl:if test="eb:Percentage">
			<br/>Prozent: 					<xsl:call-template name="prettyPrintNumberFunction">
				<xsl:with-param name="number" select="eb:Percentage"/>
			</xsl:call-template>%
		</xsl:if>
		<xsl:if test="eb:Amount">
			<br/>Betrag: 					<xsl:call-template name="prettyPrintNumberFunction">
				<xsl:with-param name="number" select="eb:Amount"/>
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="eb:Comment">
			<br/>Kommentar: <xsl:value-of select="eb:Comment"/>
		</xsl:if>
	</xsl:template>
	<!-- ==================== Related document ==================== -->
	<xsl:template match="//eb:RelatedDocument">
		<li>
			<xsl:call-template name="getDocumentType">
				<xsl:with-param name="documentType" select="eb:DocumentType"/>
			</xsl:call-template>
		Nr.
		<xsl:value-of select="eb:InvoiceNumber"/>
		vom
			<xsl:call-template name="prettyPrintDateFunction">
				<xsl:with-param name="dateString" select="eb:InvoiceDate"/>
			</xsl:call-template>
	    (<xsl:value-of select="eb:Comment"/>)
		</li>
	</xsl:template>
	<!-- ==================== SEPA Direct Debit ==================== -->
	<xsl:template match="eb:SEPADirectDebit">
		<br/>
		<strong>SEPA Direktüberweisung</strong>
		<br/>
		Typ: <xsl:value-of select="eb:Type"/>
		<br/>
		BIC: <xsl:value-of select="eb:BIC"/>
		<br/>
		IBAN: <xsl:value-of select="eb:IBAN"/>
		<br/>
		Kontoinhaber: <xsl:value-of select="eb:BankAccountOwner"/>
		<br/>
		Creditor ID: <xsl:value-of select="eb:CreditorID"/>
		<br/>
		Mandatsreferenz: <xsl:value-of select="eb:MandateReference"/>
		<br/>
		Abbuchungsdatum:
			<xsl:call-template name="prettyPrintDateFunction">
			<xsl:with-param name="dateString" select="eb:DebitCollectionDate"/>
		</xsl:call-template>
		<br/>
	</xsl:template>
	<!-- ==================== Serial number (LineItem level) ==================== -->
	<xsl:template match="eb:SerialNumber">
		<li>Seriennummer: <xsl:value-of select="."/>
		</li>
	</xsl:template>
	<!-- ==================== Size (LineItem level) ==================== -->
	<xsl:template match="eb:Size">
		<li>Größe: <xsl:value-of select="."/>
		</li>
	</xsl:template>
	<!-- ==================== SubOrganizationID ==================== -->
	<xsl:template match="eb:SubOrganizationID">
		Interne Referenz:<xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<!-- ====================Tax  (LineItem level) ==================== -->
	<xsl:template match="eb:Tax/eb:VAT">
		<h4>USt.</h4>
		<table class="table">
			<thead>
				<tr>
					<th>
						<p class="text-right">Basisbetrag</p>
					</th>
					<th>
						<p class="text-right">Steuersatz</p>
					</th>
					<th>
						<p class="text-right">Betrag</p>
					</th>
				</tr>
			</thead>
			<tbody>
				<xsl:apply-templates select="eb:VATItem"/>
			</tbody>
		</table>
	</xsl:template>
	<!-- ====================Tax exemption (LineItem level) ==================== -->
	<xsl:template match="eb:TaxExemption">
		<xsl:value-of select="."/>
	</xsl:template>
	<!-- ==================== Unit price (LineItem level) ==================== -->
	<xsl:template match="eb:UnitPrice">
		<xsl:call-template name="prettyPrintNumberFunction">
			<xsl:with-param name="dateString" select="."/>
		</xsl:call-template>&#160;<br/>(bezogen auf
		<xsl:value-of select="@eb:BaseQuantity"/>
		<xsl:choose>
			<xsl:when test="@eb:BaseQuantity = 1">
				Einheit</xsl:when>
			<xsl:otherwise>
				Einheiten
			</xsl:otherwise>
		</xsl:choose>)
	</xsl:template>
	<!-- ==================== Universal Bank Transaction ==================== -->
	<xsl:template match="eb:UniversalBankTransaction">
		<br/>
		<strong>Banküberweisung</strong>
		<br/>
		<xsl:if test="@ConsolidatorPayable">
			Zahlung durch Consolidator möglich. <br/>
		</xsl:if>
		<!-- Beneficiary accounts -->
		<xsl:apply-templates select="eb:BeneficiaryAccount"/>
		<!-- Payment reference -->
		<xsl:if test="eb:PaymentReference">
			<br/>Bei der Überweisung bitte die folgende Referenz angeben: <xsl:value-of select="eb:PaymentReference"/>
			<br/>
		</xsl:if>
	</xsl:template>
	<!-- ==================== VATIdentificationNumber ==================== -->
	<xsl:template match="//eb:VATIdentificationNumber">
	    UID Nummer:
		<xsl:choose>
			<xsl:when test=".">
				<xsl:value-of select="."/>
				<br/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- ==================== VATItem ==================== -->
	<xsl:template match="eb:VAT/eb:VATItem">
		<tr>
			<td>
				<p class="text-right">
					<xsl:call-template name="prettyPrintNumberFunction">
						<xsl:with-param name="number" select="eb:TaxedAmount"/>
					</xsl:call-template>
				</p>
			</td>
			<td>
				<!-- Tax Exemption -->
				<p class="text-right">
					<xsl:choose>
						<xsl:when test="eb:TaxExemption">
							<xsl:value-of select="eb:TaxExemption"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="prettyPrintNumberFunction">
								<xsl:with-param name="number" select="eb:VATRate"/>
							</xsl:call-template>%
					</xsl:otherwise>
					</xsl:choose>
				</p>
			</td>
			<td>
				<p class="text-right">
					<xsl:call-template name="prettyPrintNumberFunction">
						<xsl:with-param name="number" select="eb:Amount"/>
					</xsl:call-template>
				</p>
			</td>
		</tr>
	</xsl:template>
	<!-- ==================== VAT Rate ==================== -->
	<xsl:template match="//eb:VATRate">
		<xsl:call-template name="prettyPrintNumberFunction">
			<xsl:with-param name="number" select="."/>
		</xsl:call-template>%
	</xsl:template>
	<!-- ==================== Weight (LineItem level) ==================== -->
	<xsl:template match="eb:Weight">
		<li>
		Gewicht:
		<xsl:call-template name="prettyPrintNumberFunction">
				<xsl:with-param name="number" select="."/>
			</xsl:call-template>&#160;<xsl:value-of select="@eb:Unit"/>
		</li>
	</xsl:template>


	<!-- ==================== Custom function ==================== -->
	<!-- ==================== Pretty print date ==================== -->
	<xsl:template name="prettyPrintDateFunction">
		<xsl:param name="dateString" select="."/>
		<xsl:value-of select="concat(substring(string($dateString), 9,2),'.',substring(string($dateString), 6,2), '.', substring(string($dateString), 1,4))"/>
	</xsl:template>
	<!-- -->
	<!-- ==================== Pretty print number ==================== -->
	<xsl:decimal-format name="european" decimal-separator="," grouping-separator="."/>
	<xsl:template name="prettyPrintNumberFunction">
		<xsl:param name="number" select="."/>
		<xsl:value-of select="format-number($number,'###.##0,00', 'european')"/>
	</xsl:template>
	<!-- ====================Get document type ==================== -->
	<xsl:template name="getDocumentType">
		<xsl:param name="documentType" select="."/>
		<xsl:choose>
			<xsl:when test="$documentType='Invoice'">
				<xsl:text>Rechnung</xsl:text>
			</xsl:when>
			<xsl:when test="$documentType='FinalSettlement'">
				<xsl:text>Endabrechnung</xsl:text>
			</xsl:when>
			<xsl:when test="$documentType='InvoiceForAdvancePayment'">
				<xsl:text>Vorauszahlung</xsl:text>
			</xsl:when>
			<xsl:when test="$documentType='InvoiceForPartialDelivery'">
				<xsl:text>Rechnung f&#252;r Teillieferung</xsl:text>
			</xsl:when>
			<xsl:when test="$documentType='SubsequentCredit'">
				<xsl:text>Nachentlastung</xsl:text>
			</xsl:when>
			<xsl:when test="$documentType='CreditMemo'">
				<xsl:text>Gutschrift</xsl:text>
			</xsl:when>
			<xsl:when test="$documentType='SubsequentDebit'">
				<xsl:text>Nachbelastung</xsl:text>
			</xsl:when>
			<xsl:when test="$documentType='SelfBilling'">
				<xsl:text>Gutschriftverfahren</xsl:text>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
