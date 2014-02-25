<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:eb="http://www.ebinterface.at/schema/4p1/" xmlns:dsig="http://www.w3.org/2000/09/xmldsig#">
	<!-- 
		XSLT for ebInterface 4.1
		For more information on ebInvoice see http://www.ebinterface.at/
		
		Last update:	19.02.2013
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
				<link rel="stylesheet" href="../css/bootstrap.min.css"/>
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
					<div class="row">
						<div class="col-md-12">
							<h3>Rechnungsdetails</h3>
							<xsl:apply-templates select="/eb:Invoice/eb:Details"/>
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
	<!-- ==================== Delivery (ROOT level) ==================== -->
	<xsl:template match="/eb:Invoice/eb:Delivery">
		<span class="label label-primary">Lieferdetails</span><br/>		
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
	<!-- ==================== Date ==================== -->		
	<xsl:template match="eb:Date">
		Lieferdatum: 		
		<xsl:call-template name="prettyPrintDateFunction">
			<xsl:with-param name="dateString" select="."/>
		</xsl:call-template>
		<br/>
	</xsl:template>
	<!-- ==================== DeliveryID ==================== -->	
	<xsl:template match="eb:DeliveryID">
		Liefer-ID: <xsl:value-of select="."/>
		<br/>
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
						<th>Gesamtpreis</th>
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
	<!-- =========================================================== -->
	<!-- ==================== Details helper templates ==================== -->
	<!-- =========================================================== -->

	<!-- ==================== AdditionalInformation(LineItem level)  ==================== -->	
    <xsl:template match="eb:AdditionalInformation">
		<br/>
		<strong>Weitere Artikeldetails:</strong><br/>
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
	<!-- ==================== Alternative Quantity (LineItem level)  ==================== -->	
	<xsl:template match="eb:AlternativeQuantity">		
		<li>Alternative Menge: <xsl:value-of select="."/>&#160;<xsl:value-of select="@eb:Unit"/></li>
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
		<li>Kisten/Container: <xsl:value-of select="."/></li>
	</xsl:template>		
	<!-- ==================== Charge number (LineItem level) ==================== -->	
	<xsl:template match="eb:ChargeNumber">
		<li>Chargennummer: <xsl:value-of select="."/></li>
	</xsl:template>	
	<!-- ==================== Classification (LineItem level) ==================== -->	
	<xsl:template match="eb:Classification">
		<li><xsl:value-of select="@eb:ClassificationSchema"/>: <xsl:value-of select="."/></li>
	</xsl:template>		
	<!-- ==================== Color (LineItem level) ==================== -->	
	<xsl:template match="eb:Color">
		<li>Farbe: <xsl:value-of select="."/></li>
	</xsl:template>		
	<!-- ==================== Delivery (LineItem level)  ==================== -->
	<xsl:template match="eb:ListLineItem/eb:Delivery">
		<span class="label label-primary">Lieferadresse für diesen Artikel:</span><br/>
		<xsl:apply-templates select="node()"/>		
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
	<!-- ==================== HeaderDescription (LineItem level)  ==================== -->
	<xsl:template match="eb:HeaderDescription">
		<xsl:value-of select="."/>
		<br/>
		<br/>
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
	<!-- ==================== Quantity (LineItem level) ==================== -->
	<xsl:template match="eb:Quantity">
		<xsl:call-template name="prettyPrintNumberFunction">
			<xsl:with-param name="number" select="."/>
		</xsl:call-template>&#160;<xsl:value-of select="@eb:Unit"/>
	</xsl:template>	
	<!-- ==================== Reduction & Surcharge (LineItem level) ==================== -->
	<xsl:template match="eb:ReductionAndSurchargeListLineItemDetails/eb:OtherVATableTaxListLineItem">
		<strong>Weitere Steuern, die nicht der USt unterliegen</strong><br/>
		Basisbetrag: <xsl:value-of select="eb:BaseAmount"/>		
		<xsl:if test="eb:Percentage">
			<br/>Prozent: <xsl:value-of select="eb:Percentage"/>%
		</xsl:if>
		<xsl:if test="eb:Amount">
			<br/>Betrag: <xsl:value-of select="eb:Amount"/>
		</xsl:if>
		<xsl:if test="eb:Comment">
			<br/>Kommentar: <xsl:value-of select="eb:Comment"/>
		</xsl:if>		
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
		<br/>Basisbetrag: <xsl:value-of select="eb:BaseAmount"/>
		<xsl:if test="eb:Percentage">
			<br/>Prozent: <xsl:value-of select="eb:Percentage"/>%
		</xsl:if>
		<xsl:if test="eb:Amount">
			<br/>Betrag: <xsl:value-of select="eb:Amount"/>
		</xsl:if>
		<xsl:if test="eb:Comment">
			<br/>Kommentar: <xsl:value-of select="eb:Comment"/>
		</xsl:if>
	</xsl:template>	
	<!-- ==================== Serial number (LineItem level) ==================== -->	
	<xsl:template match="eb:SerialNumber">
		<li>Seriennummer: <xsl:value-of select="."/></li>
	</xsl:template>
	<!-- ==================== Size (LineItem level) ==================== -->	
	<xsl:template match="eb:Size">
		<li>Größe: <xsl:value-of select="."/></li>
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
	<!-- ==================== Weight (LineItem level) ==================== -->
	<xsl:template match="eb:Weight">
		<li>
		Gewicht: 
		<xsl:call-template name="prettyPrintNumberFunction">
			<xsl:with-param name="number" select="."/>
		</xsl:call-template>&#160;<xsl:value-of select="@eb:Unit"/>
		</li>
	</xsl:template>		
	<!-- =========================================================== -->
	<!-- ==================== End of details helper ======================== -->
	<!-- =========================================================== -->
	<!-- ==================== Description ==================== -->
	<xsl:template match="/eb:Description">
		Hinweise zur Lieferung: <xsl:value-of select="."/>
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
	<!-- ==================== AccountingArea ==================== -->		
	<xsl:template match="eb:AccountingArea">
		Buchungskreis: <xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<!-- ==================== BillersInvoiceRecipientID ==================== -->	
	<xsl:template match="eb:BillersInvoiceRecipientID">
		ID beim Rechnungsssteller: <xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<!-- ==================== SubOrganizationID ==================== -->	
	<xsl:template match="eb:SubOrganizationID">
		Interne Referenz:<xsl:value-of select="."/>
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
	<!-- ==================== Presentation Details ==================== -->
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
	<!-- ==================== VAT Number ==================== -->
	<xsl:template match="//eb:VATIdentificationNumber">
	    UID Nummer: 
		<xsl:choose>
			<xsl:when test=".">
				<xsl:value-of select="."/>
				<br/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- ==================== VAT Rate ==================== -->	
	<xsl:template match="//eb:VATRate">
		<xsl:value-of select="."/>%
	</xsl:template>
	<!-- ==================== Custom function ==================== -->
	<!-- ==================== Pretty print date ==================== -->
	<xsl:template name="prettyPrintDateFunction">
		<xsl:param name="dateString" select="."/>
		<xsl:value-of select="concat(substring(string($dateString), 9,2),'.',substring(string($dateString), 6,2), '.', substring(string($dateString), 1,4))"/>
	</xsl:template>
	<!-- -->
	<!-- ==================== Pretty print number ==================== -->
	<xsl:template name="prettyPrintNumberFunction">
		<xsl:param name="number" select="."/>
		<xsl:value-of select="format-number($number,'#,###0.00')"/>
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
