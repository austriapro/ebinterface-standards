<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:eb="http://www.ebinterface.at/schema/4p0/" xmlns:dsig="http://www.w3.org/2000/09/xmldsig#">
	<!-- 
		XSLT for ebInterface 4.0
		For more information on ebInvoice see http://www.ebinterface.at/
		
		Last update:	19.03.2012
		Author: 			Philipp Liegl, Vienna University of Technology
-->
	<xsl:variable name="tableWidth">650</xsl:variable>
	<xsl:variable name="firstColumnWidth">300</xsl:variable>
	<xsl:variable name="currency">
		<xsl:value-of select="//eb:Invoice/@eb:InvoiceCurrency"/>
	</xsl:variable>
	<xsl:output method="html" encoding="utf-8" indent="yes"/>
	<xsl:template match="/">

		
		
		<html>
			<head>
				<title>Rechnungsdetails</title>
				<style type="text/css">
td{
  font-family: Verdana, Arial, Helvetica, sans-serif;
  font-size: 12px;
  vertical-align:top;
}
.nopadding{
  font-family: Verdana, Arial, Helvetica, sans-serif;
  font-size: 12px;
  padding-top: 0;
  padding-bottom: 0;
}
th.normal{
  font-family: Verdana, Arial, Helvetica, sans-serif;
  font-size: 12px;
  text-align: left;
}
th.thright{
  font-family: Verdana, Arial, Helvetica, sans-serif;
  font-size: 12px;
  text-align:right;
}
.header{
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 20px;
	font-weight: bold;
	background: #6699CC;
	text-align: center;
}
.comment{
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 11px;
	text-align: left;
}
.itemListDescriptionTop{
	margin:20px 0 0 0; padding:0;
	text-align:left;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-weight: bold;
	font-size: 11px;
	color: #333;
	width: 650px;
}
.itemListDescriptionBottom{
	margin:0 0 20px 0; padding:0;
	text-align:left;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-weight: bold;
	font-size: 11px;
	color: #333;
	width: 650px;
}
.itemListTable{
	margin:0; padding:0;
	border-bottom: 1px solid #666;
	border-top: 1px solid #666;
	width: 650px;
}
.itemListTable th{
	border-bottom: 1px solid #666;
	text-align:left;
	vertical-align:top;
}
.itemListTable td{
	padding-right: 2px;
}
.itemListTable th.tright, .tright{
	text-align: right;
	vertical-align: right;
	padding-left:4px;
}
p.itemdetails{
	padding:0; margin:0;
	font-size: 11px;
	text-align: left;
}
.sumtable{
	margin:0; padding:0;
	border-top: 1px double #666;
	border-bottom: 1px solid #666;
	width: 650px;
}
.sumtable td, .sumtable th{
	text-align:right;
}
hr{
    border: 1px solid #666;
}
                </style>
			</head>
			<body>
				<div style="text-align:center;">
					<table style="border-collapse:separate; border-spacing:0px; width:{$tableWidth}px; border-width:0px;">
						<tbody>
							<!-- ========== Logo ========== -->
							<tr>
								<td style="padding-bottom:20">
									<xsl:choose>
										<xsl:when test="//eb:PresentationDetails/eb:LogoURL">
											<xsl:apply-templates select="//eb:PresentationDetails/eb:LogoURL"/>
										</xsl:when>
										<xsl:otherwise>
											&#160;
										</xsl:otherwise>
									</xsl:choose>
								</td>
								<td colspan="2" style="text-align:right;vertical-align=top;">
									<img src="http://www.ebinterface.at/images/eb_logo_approved.gif" alt="ebInvoice approved"/>
								</td>
							</tr>
							<tr>
								<!-- ========== InvoiceRecipient ========== -->
								<td>
									<xsl:apply-templates select="//eb:InvoiceRecipient"/>
								</td>
								<!-- =============== Biller =============== -->
								<td>&#160;</td>
								<td>
									<xsl:apply-templates select="//eb:Biller"/>
								</td>
							</tr>
							<!-- =============== Rechnung =============== -->
							<tr>
								<td colspan="3">
									<br/>
									<hr/>
								</td>
							</tr>
							<tr>
								<td colspan="3" class="header">
									<xsl:choose>
										<xsl:when test="//eb:Invoice/@eb:DocumentTitle">
											<xsl:value-of select="//eb:Invoice/@eb:DocumentTitle"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:if test="//eb:Invoice/@eb:DocumentType='Invoice'">
												<xsl:text>Rechnung</xsl:text>
											</xsl:if>
											<xsl:if test="//eb:Invoice/@eb:DocumentType='FinalSettlement'">
												<xsl:text>Endabrechnung</xsl:text>
											</xsl:if>
											<xsl:if test="//eb:Invoice/@eb:DocumentType='InvoiceForAdvancePayment'">
												<xsl:text>Vorauszahlung</xsl:text>
											</xsl:if>
											<xsl:if test="//eb:Invoice/@eb:DocumentType='InvoiceForPartialDelivery'">
												<xsl:text>Rechnung f&#252;r Teillieferung</xsl:text>
											</xsl:if>
											<xsl:if test="//eb:Invoice/@eb:DocumentType='SubsequentCredit'">
												<xsl:text>Nachentlastung</xsl:text>
											</xsl:if>
											<xsl:if test="//eb:Invoice/@eb:DocumentType='CreditMemo'">
												<xsl:text>Gutschrift</xsl:text>
											</xsl:if>
											<xsl:if test="//eb:Invoice/@eb:DocumentType='SubsequentDebit'">
												<xsl:text>Nachbelastung</xsl:text>
											</xsl:if>
											<xsl:if test="//eb:Invoice/@eb:DocumentType='SelfBilling'">
												<xsl:text>Gutschriftverfahren</xsl:text>
											</xsl:if>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
							<tr>
								<td colspan="3">
									<hr/>
									<br/>
								</td>
							</tr>
							<xsl:apply-templates select="//eb:InvoiceNumber"/>
							<xsl:apply-templates select="//eb:InvoiceDate"/>
							<xsl:apply-templates select="//eb:TotalGrossAmount"/>
						</tbody>
					</table>
					<br/>
					<br/>
					<!-- ============ Details =============== -->
					<xsl:if test="//eb:Details">
								<xsl:apply-templates select="/eb:Invoice/eb:Details"/>
					</xsl:if>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<!-- =========== PaymentConditions ======== -->
					<xsl:if test="//eb:PaymentConditions | //eb:PaymentMethod">
						<table style="border-collapse:separate; border-spacing:0px; width:{$tableWidth}px; border-width:0px;">
							<tbody>
								<tr>
									<td colspan="3">
										<br/>
										<hr/>
									</td>
								</tr>
								<tr>
									<td colspan="3" class="header">Zahlungsbedingungen</td>
								</tr>
								<tr>
									<td colspan="3">
										<hr/>
										<br/>
									</td>
								</tr>
								<xsl:if test="//eb:PaymentConditions">
									<xsl:apply-templates select="//eb:PaymentConditions"/>
								</xsl:if>
								<xsl:if test="//eb:PaymentMethod">
									<tr>
										<td colspan="3">
											<xsl:apply-templates select="//eb:PaymentMethod"/>
										</td>
									</tr>
								</xsl:if>
							</tbody>
						</table>
						<br/>
						<br/>
					</xsl:if>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<!-- ============ Taxes =============== -->
					<table style="border-collapse:separate; border-spacing:0px; width:{$tableWidth}px; border-width:0px;">
						<tbody>
							<xsl:apply-templates select="/eb:Invoice/eb:Tax"/>
						</tbody>
					</table>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<!-- =========== Delivery ======== -->
					<xsl:if test="/eb:Invoice/eb:Delivery">
						<table style="border-collapse:separate; border-spacing:0px; width:{$tableWidth}px; border-width:0px;">
							<tbody>
								<xsl:apply-templates select="/eb:Invoice/eb:Delivery"/>
							</tbody>
						</table>
						<br/>
						<br/>
						<br/>
						<br/>
						<br/>
					</xsl:if>
					<!-- =========== Supplier ======== -->
					<xsl:if test="//eb:Supplier">
						<table style="border-collapse:separate; border-spacing:0px; width:{$tableWidth}px; border-width:0px;">
							<tbody>
								<xsl:apply-templates select="//eb:Supplier"/>
							</tbody>
						</table>
						<br/>
						<br/>
						<br/>
						<br/>
						<br/>
					</xsl:if>
					<!-- =========== Biller ======== -->
					<table style="border-collapse:separate; border-spacing:0px; width:{$tableWidth}px; border-width:0px;">
						<tbody>
							<xsl:apply-templates select="//eb:Biller" mode="details"/>
						</tbody>
					</table>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<!-- =========== InvoiceRecipient ======== -->
					<table style="border-collapse:separate; border-spacing:0px; width:{$tableWidth}px; border-width:0px;">
						<tbody>
							<xsl:apply-templates select="//eb:InvoiceRecipient" mode="details"/>
						</tbody>
					</table>
					<br/>
					<br/>
					<br/>
					<br/>
					<br/>
					<!-- =========== OrderingParty ======== -->
					<xsl:if test="//eb:OrderingParty">
						<table style="border-collapse:separate; border-spacing:0px; width:{$tableWidth}px; border-width:0px;">
							<tbody>
								<xsl:apply-templates select="//eb:OrderingParty"/>
							</tbody>
						</table>
						<br/>
						<br/>
						<br/>
						<br/>
						<br/>
					</xsl:if>
					<xsl:if test="/eb:Invoice/eb:Custom">
						<table style="border-collapse:separate; border-spacing:0px; width:{$tableWidth}px; border-width:0px;">
							<tbody>
								<tr>
									<td colspan="3">
										<br/>
										<hr/>
									</td>
								</tr>
								<tr>
									<td colspan="3" class="header">Sonstiges (Custom)</td>
								</tr>
								<tr>
									<td colspan="3">
										<hr/>
										<br/>
									</td>
								</tr>
								<xsl:for-each select="/eb:Invoice/eb:Custom">
									<tr>
										<td colspan="3">
											<pre>
												<xsl:apply-templates/>
											</pre>
										</td>
									</tr>
								</xsl:for-each>
							</tbody>
						</table>
						<br/>
						<br/>
						<br/>
						<br/>
						<br/>
					</xsl:if>
				</div>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="//eb:Custom//*">
		<xsl:value-of select="name(.)"/>: 
		<xsl:choose>
			<xsl:when test="child::*">
				<br/>
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/>
				<br/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ================ Biller =================== -->
	<xsl:template match="//eb:Biller">
		<xsl:apply-templates select="eb:Address"/>
	</xsl:template>
	<xsl:template match="//eb:Biller" mode="details">
		<tr>
			<td colspan="3">
				<br/>
				<hr/>
			</td>
		</tr>
		<tr>
			<td colspan="3" class="header">Angaben zum Rechnungssteller</td>
		</tr>
		<tr>
			<td colspan="3">
				<hr/>
				<br/>
			</td>
		</tr>
		<tr>
			<td style="width:{$firstColumnWidth}px;">&#160;</td>
			<td colspan="2" style="text-align:left;">
				<xsl:apply-templates select="eb:Address"/>
				<br/>
				<xsl:apply-templates select="eb:VATIdentificationNumber"/>
				<br/>
				<xsl:if test="eb:FurtherIdentification">
					<xsl:apply-templates select="eb:FurtherIdentification"/>
					<br/>
				</xsl:if>
				<xsl:if test="eb:ConsolidatorsBillerID">
					<br/>Rechnungssteller ID beim Consolidator: 
                    <xsl:value-of select="eb:ConsolidatorsBillerID"/>
					<br/>
				</xsl:if>
				<xsl:if test="eb:InvoiceRecipientsBillerID">
                    Rechnungssteller ID beim Rechnungsempfänger: 
                    <xsl:value-of select="eb:InvoiceRecipientsBillerID"/>
					<br/>
				</xsl:if>
			</td>
		</tr>
		<xsl:if test="eb:OrderReference">
			<xsl:call-template name="eb:OrderReference"/>
		</xsl:if>
		<tr>
			<td colspan="3">
				<br/>
				<hr/>
				<br/>
			</td>
		</tr>
	</xsl:template>
	<!-- ============ InvoiceRecipient ============== -->
	<xsl:template match="//eb:InvoiceRecipient">
		<xsl:apply-templates select="eb:Address"/>
		<br/>
		<xsl:apply-templates select="eb:VATIdentificationNumber"/>
		<br/>
		<xsl:text>(Kundennummer: </xsl:text>
		<xsl:value-of select="eb:BillersInvoiceRecipientID"/>
		<xsl:text>)</xsl:text>
	</xsl:template>
	<xsl:template match="//eb:InvoiceRecipient" mode="details">
		<tr>
			<td colspan="3">
				<br/>
				<hr/>
			</td>
		</tr>
		<tr>
			<td colspan="3" class="header">Angaben zum Rechnungsempfänger</td>
		</tr>
		<tr>
			<td colspan="3">
				<hr/>
				<br/>
			</td>
		</tr>
		<tr>
			<td style="width:{$firstColumnWidth}px;">&#160;</td>
			<td colspan="2" style="text-align:left;">
				<xsl:apply-templates select="eb:Address"/>
				<br/>
				<xsl:apply-templates select="eb:VATIdentificationNumber"/>
				<br/>
                Kundennummer: <xsl:value-of select="eb:BillersInvoiceRecipientID"/>
				<br/>
			</td>
		</tr>
		<xsl:if test="eb:OrderReference">
			<xsl:call-template name="eb:OrderReference"/>
		</xsl:if>
		<tr>
			<td colspan="3">
				<br/>
				<hr/>
				<br/>
			</td>
		</tr>
	</xsl:template>
	<!-- ============ OrderingParty ============== -->
	<xsl:template match="//eb:OrderingParty">
		<tr>
			<td colspan="3">
				<br/>
				<hr/>
			</td>
		</tr>
		<tr>
			<td colspan="3" class="header">Angaben zum Auftraggeber</td>
		</tr>
		<tr>
			<td colspan="3">
				<hr/>
				<br/>
			</td>
		</tr>
		<tr>
			<td style="width:{$firstColumnWidth}px;">&#160;</td>
			<td colspan="2" style="text-align:left;">
				<xsl:apply-templates select="eb:Address"/>
				<br/>
				<xsl:apply-templates select="eb:VATIdentificationNumber"/>
				<br/>
                Kundennummer: <xsl:value-of select="eb:BillersOrderingPartyID"/>
				<br/>
			</td>
		</tr>
		<xsl:if test="eb:OrderReference">
			<xsl:call-template name="eb:OrderReference"/>
		</xsl:if>
		<tr>
			<td colspan="3">
				<br/>
				<hr/>
				<br/>
			</td>
		</tr>
	</xsl:template>
	<!-- ================= Logo ================== -->
	<xsl:template match="//eb:PresentationDetails/eb:LogoURL">
		<xsl:choose>
			<xsl:when test="preceding::eb:URL">
				<xsl:element name="a">
					<xsl:attribute name="href"><xsl:value-of select="preceding::eb:URL"/></xsl:attribute>
					<xsl:element name="img">
						<xsl:attribute name="style">border:0;</xsl:attribute>
						<xsl:attribute name="src"><xsl:value-of select="."/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="."/></xsl:attribute>
					</xsl:element>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:element name="img">
					<xsl:attribute name="border">0</xsl:attribute>
					<xsl:attribute name="src"><xsl:value-of select="."/></xsl:attribute>
					<xsl:attribute name="alt"><xsl:value-of select="."/></xsl:attribute>
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- ================= InvoiceNumber ================== -->
	<xsl:template match="//eb:InvoiceNumber">
		<tr>
			<td class="nopadding">&#160;</td>
			<td class="nopadding">Rechnungsnummer: </td>
			<td class="nopadding">
				<xsl:value-of select="."/>
			</td>
		</tr>
	</xsl:template>
	<!-- ================== InvoiceDate =================== -->
	<xsl:template match="//eb:InvoiceDate">
		<tr>
			<td class="nopadding">&#160;</td>
			<td class="nopadding">Rechnungsdatum: </td>
			<td class="nopadding">
				<xsl:value-of select="."/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="//eb:TotalGrossAmount">
		<tr>
			<td class="nopadding">&#160;</td>
			<td class="nopadding">
				<b>Rechnungsbruttobetrag: </b>
			</td>
			<td class="nopadding">
				<b>
					<xsl:value-of select="."/>&#160;<xsl:value-of select="$currency"/>
				</b>
			</td>
		</tr>
	</xsl:template>
	<!-- ===================== UID ======================= -->
	<xsl:template match="//eb:VATIdentificationNumber">
        UID: <xsl:value-of select="."/>
	</xsl:template>
	<!-- ================ IdentificationType ================= -->
	<xsl:template match="//eb:FurtherIdentification">
		<xsl:value-of select="@eb:IdentificationType"/>: <xsl:value-of select="."/>
	</xsl:template>
	<!-- ==================== Address ==================== -->
	<xsl:template match="//eb:Address">
		<xsl:for-each select="child::*">
			<xsl:apply-templates select="."/>
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="//eb:Address/eb:Salutation | //eb:Address/eb:Name | //eb:Address/eb:Street |  //eb:Address/eb:Contact | //eb:Address/eb:AddressExtension | //eb:Address/eb:Country">
		<xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<xsl:template match="//eb:Address/eb:POBox">
		<xsl:text>POBox </xsl:text>
		<xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<xsl:template match="//eb:Address/eb:Town">
		<xsl:value-of select="following::eb:ZIP"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<xsl:template match="//eb:Address/eb:ZIP"/>
	<xsl:template match="//eb:Address/eb:Phone">
		<xsl:text>Tel: </xsl:text>
		<xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<xsl:template match="//eb:Address/eb:Email">
		<xsl:text>E-Mail: </xsl:text>
		<xsl:element name="a">
			<xsl:attribute name="href">mailto:<xsl:value-of select="."/></xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:element>
		<br/>
	</xsl:template>
	<!-- ==================== Details ==================== -->
	<xsl:template match="//eb:Details">
		<xsl:if test="eb:HeaderDescription">
			<xsl:apply-templates select="eb:HeaderDescription"/>
		</xsl:if>
		<xsl:for-each select="eb:ItemList">
			<xsl:apply-templates select="eb:HeaderDescription"/>
			<table class="itemListTable" style="border-collapse:separate; border-spacing:0px;">
				<tbody>
					<xsl:for-each select="child::*[name(.)='eb:ListLineItem']">
						<xsl:if test="count(preceding-sibling::*[name()='eb:ListLineItem'])=0">
							<tr>
								<th class="tright">#</th>
								<th>Beschreibung</th>
								<th>
									<xsl:text>Artikelnummer (Rechnungssteller)</xsl:text>
								</th>
								<th class="tright">Menge</th>
								<th class="tright">Einzelpreis (Netto)</th>
								<th class="tright">USt<xsl:if test="@eb:TaxCode"> (<xsl:value-of select="@eb:TaxCode"/>)</xsl:if>
								</th>
								<th class="tright">Netto-Betrag</th>
								<th class="tright">Brutto-Betrag</th>
							</tr>
						</xsl:if>
						<tr>
							<td class="tright">
								<xsl:choose>
									<xsl:when test="eb:PositionNumber">
										<xsl:value-of select="eb:PositionNumber"/>
									</xsl:when>
									<xsl:otherwise>-</xsl:otherwise>
								</xsl:choose>
							</td>
							<td>
								<xsl:value-of select="eb:Description"/>
								<!--	<xsl:call-template name="ListLineItemDetails"/> -->
							</td>
							<td>
								<xsl:choose>
									<xsl:when test="eb:BillersArticleNumber">
										<xsl:value-of select="eb:BillersArticleNumber"/>
									</xsl:when>
									<xsl:otherwise>-</xsl:otherwise>
								</xsl:choose>
							</td>
							<td class="tright">
								<xsl:value-of select="eb:Quantity"/>&#160;<xsl:value-of select="eb:Quantity/@eb:Unit"/>
							</td>
							<td class="tright">
								<xsl:value-of select="eb:UnitPrice"/>&#160;<xsl:value-of select="$currency"/>
							</td>
							<td class="tright">
								<xsl:value-of select="eb:TaxRate"/>%</td>
							<td class="tright">
								<xsl:value-of select="eb:LineItemAmount"/>&#160;<xsl:value-of select="$currency"/>
							</td>
							<td class="tright">
								<xsl:variable name="netto">
									<xsl:value-of select="eb:LineItemAmount"/>
								</xsl:variable>
								<xsl:variable name="tax">
									<xsl:value-of select="eb:TaxRate"/>
								</xsl:variable>
								<xsl:value-of select="format-number($netto + $netto*( $tax div 100),'##.00')"/>&#160;<xsl:value-of select="$currency"/>
							</td>
						</tr>
						<tr>
							<td>&#160;</td>
							<td colspan="7">
								<xsl:call-template name="ListLineItemDetails"/>
							</td>
						</tr>
					</xsl:for-each>
				</tbody>
			</table>
			<xsl:choose>
				<xsl:when test="eb:FooterDescription">
					<xsl:apply-templates select="eb:FooterDescription"/>
				</xsl:when>
				<xsl:otherwise>
					<p class="itemListDescriptionBottom">&#160;</p>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
		<xsl:if test="eb:FooterDescription">
			<xsl:apply-templates select="eb:FooterDescription"/>
		</xsl:if>
	</xsl:template>
	<xsl:template name="ListLineItemDetails">
		<xsl:variable name="details">
			<xsl:choose>
				<xsl:when test="eb:InvoiceRecipientsArticleNumber | eb:DiscountFlag | eb:ReductionRate | eb:Delivery | eb:BillersOrderReference | eb:InvoiceRecipientsOrderReference | eb:AdditionalInformation">true</xsl:when>
				<xsl:otherwise>false</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:if test="$details">
			<p class="itemdetails">
				<xsl:if test="eb:InvoiceRecipientsArticleNumber">
					Artikelnummer (Rechnungsempf&#228;nger): <xsl:value-of select="eb:InvoiceRecipientsArticleNumber"/>
					<br/>
				</xsl:if>
				<xsl:if test="eb:DiscountFlag">
					Skontof&#228;hig: 
					<xsl:variable name="skontoFlag">
						<xsl:value-of select="eb:DiscountFlag"/>
					</xsl:variable>
					<xsl:choose>
						<xsl:when test="$skontoFlag = 'true'">ja</xsl:when>
						<xsl:otherwise>nein</xsl:otherwise>
					</xsl:choose>
					<br/>
				</xsl:if>
				<xsl:if test="eb:ReductionRate">Rabattrate: <xsl:value-of select="eb:ReductionRate"/>
					<br/>
				</xsl:if>
				<xsl:if test="eb:Delivery">
					Angaben zur Lieferung:
					<xsl:apply-templates select="eb:Delivery"/>
				</xsl:if>
				<xsl:if test="eb:BillersOrderReference">
					Bestellreferenz (Rechnungssteller): <xsl:value-of select="eb:BillersOrderReference/eb:OrderID"/>
					<xsl:if test="eb:BillersOrderReference/eb:OrderPositionNumber">
						(Positionsnr.: <xsl:value-of select="eb:BillersOrderReference/eb:OrderPositionNumber"/>)
					</xsl:if>
					<br/>
				</xsl:if>
				<xsl:if test="eb:InvoiceRecipientsOrderReference">
					Bestellreferenz (Rechnungsempfänger): <xsl:value-of select="eb:InvoiceRecipientsOrderReference/eb:OrderID"/>
					<xsl:if test="eb:InvoiceRecipientsOrderReference/eb:OrderPositionNumber">
						(Positionsnr.: <xsl:value-of select="eb:InvoiceRecipientsOrderReference/eb:OrderPositionNumber"/>)
					</xsl:if>
					<br/>
				</xsl:if>
				<xsl:if test="eb:AdditionalInformation">
					<xsl:apply-templates select="eb:AdditionalInformation"/>
				</xsl:if>
				<xsl:if test="eb:Custom">
					Sonstiges (Custom): <xsl:apply-templates select="eb:Custom"/>
				</xsl:if>
			</p>
		</xsl:if>
	</xsl:template>
	<xsl:template match="//eb:Details/eb:HeaderDescription | //eb:Details/eb:FooterDescription">
		<table style="border-collapse:separate; border-spacing:0px; width:{$tableWidth}px; border-width:0px;">
			<tr>
				<td>
					<p class="comment">
						<xsl:value-of select="."/>
					</p>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="//eb:ItemList/eb:HeaderDescription">
		<table style="border-collapse:separate; border-spacing:0px; width:{$tableWidth}px; border-width:0px;">
			<tr>
				<td>
					<p class="itemListDescriptionTop">
						<xsl:value-of select="."/>
					</p>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="//eb:ItemList/eb:FooterDescription">
		<table style="border-collapse:separate; border-spacing:0px; width:{$tableWidth}px; border-width:0px;">
			<tr>
				<td>
					<p class="itemListDescriptionBottom">
						<xsl:value-of select="."/>
					</p>
				</td>
			</tr>
		</table>
	</xsl:template>
	<xsl:template match="//eb:ListLineItem/eb:Delivery">
		<xsl:if test="eb:DeliveryID">
			Liefernummer: <xsl:value-of select="eb:DeliveryID"/>
			<br/>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="eb:Date">
				Lieferdatum: <xsl:value-of select="eb:Date"/>
				<br/>
			</xsl:when>
			<xsl:otherwise>
                Lieferperiode: <xsl:value-of select="eb:Period/eb:FromDate"/> - <xsl:value-of select="eb:Period/eb:ToDate"/>
				<br/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="eb:Address">
			Lieferadresse: <br/>
			<xsl:apply-templates select="eb:Address"/>
		</xsl:if>
	</xsl:template>
	<xsl:template match="eb:AdditionalInformation">
		<xsl:if test="eb:SerialNumber">
			Seriennummer: <xsl:value-of select="eb:SerialNumber"/>
			<br/>
		</xsl:if>
		<xsl:if test="eb:ChargeNumber">
			Chargennummer: <xsl:value-of select="eb:ChargeNumber"/>
			<br/>
		</xsl:if>
		<xsl:if test="eb:Classification">
			Code 
			<xsl:if test="eb:Classification/@eb:ClassificationSchema">
				(<xsl:value-of select="eb:Classification/@eb:ClassificationSchema"/>)
			</xsl:if>: 
			<xsl:value-of select="eb:Classification"/>
			<br/>
		</xsl:if>
		<xsl:if test="eb:AlternativeQuantity">
			alt. Menge 
			<xsl:if test="eb:AlternativeQuantity/@eb:Unit">
				(<xsl:value-of select="eb:AlternativeQuantity/@eb:Unit"/>)</xsl:if>: 
			<xsl:value-of select="eb:AlternativeQuantity"/>
			<br/>
		</xsl:if>
		<xsl:if test="eb:Size">
			Gr&#246;&#223;e: <xsl:value-of select="eb:Size"/>
			<br/>
		</xsl:if>
		<xsl:if test="eb:Weight">
			Gewicht: <xsl:value-of select="eb:Weight"/>
			<br/>
		</xsl:if>
		<xsl:if test="eb:Boxes">
			Kisten / Container: <xsl:value-of select="eb:Boxes"/>
			<br/>
		</xsl:if>
		<xsl:if test="eb:Color">
			Farbe: <xsl:value-of select="eb:Color"/>
			<br/>
		</xsl:if>
	</xsl:template>
	<!-- ==================== Tax ==================== -->
	<xsl:template match="//eb:Tax">
		<tr>
			<td colspan="4">
				<br/>
				<hr/>
			</td>
		</tr>
		<tr>
			<td colspan="4" class="header">Zusammenfassung allfälliger Steuern</td>
		</tr>
		<tr>
			<td colspan="4">
				<hr/>
				<br/>
			</td>
		</tr>
		<tr>
			<th>Steuer</th>
			<th>Basisbetrag</th>
			<th>Steuersatz</th>
			<th>Steuerbetrag</th>
		</tr>
		<xsl:if test="eb:VAT/eb:TaxExemption">
			<tr>
				<td>
					USt-Befreiung <br/>
					<xsl:value-of select="eb:VAT/eb:TaxExemption"/>
				</td>
				<td class="tright">-</td>
				<td class="tright">-</td>
				<td class="tright">-</td>
			</tr>
		</xsl:if>
		<xsl:for-each select="eb:VAT/eb:Item">
			<tr>
				<td>USt</td>
				<td class="tright">
					<xsl:value-of select="eb:TaxedAmount"/>&#160;<xsl:value-of select="$currency"/>
				</td>
				<td class="tright">
					<xsl:value-of select="eb:TaxRate"/>%
					<xsl:if test="eb:TaxRate/@eb:TaxCode">
						<br/>
						(<xsl:value-of select="eb:TaxRate/@eb:TaxCode"/>)
					</xsl:if>
				</td>
				<td class="tright">
					<xsl:value-of select="eb:Amount"/>&#160;<xsl:value-of select="$currency"/>
				</td>
			</tr>
		</xsl:for-each>
		<xsl:for-each select="eb:OtherTax">
			<tr>
				<td>
					<xsl:value-of select="eb:Comment"/>
				</td>
				<td class="tright">-</td>
				<td class="tright">-</td>
				<td class="tright">
					<xsl:value-of select="eb:Amount"/>&#160;<xsl:value-of select="$currency"/>
				</td>
			</tr>
		</xsl:for-each>
	</xsl:template>
	<!-- ==================== PaymentConditions ==================== -->
	<xsl:template match="//eb:PaymentConditions">
		<tr>
			<td style="width:{$firstColumnWidth}px;">&#160;</td>
			<td>Fälligkeitsdatum: </td>
			<td>
				<xsl:value-of select="eb:DueDate"/>
			</td>
		</tr>
		<xsl:if test="eb:MinimumPayment">
			<tr>
				<td>&#160;</td>
				<td>Mindestbertag: </td>
				<td>
					<xsl:value-of select="eb:MinimumPayment"/>&#160;<xsl:value-of select="$currency"/>&#160;</td>
			</tr>
		</xsl:if>
		<xsl:if test="eb:Discount">
			<tr>
				<th class="normal" colspan="3">Skonto: </th>
			</tr>
			<tr>
				<td colspan="3">
					<table style="border-collapse:separate; border-spacing:0px;width:100%; border-width:0px;">
						<tbody>
							<tr>
								<th class="normal">Bis Datum</th>
								<th class="thright">Basisbetrag</th>
								<th class="thright">Skontoprozent</th>
								<th class="thright">Skontobetrag</th>
							</tr>
							<xsl:for-each select="eb:Discount">
								<tr>
									<td>
										<xsl:value-of select="eb:PaymentDate"/>&#160;
                                </td>
									<td style="text-align:right;">
										<xsl:choose>
											<xsl:when test="eb:BaseAmount">
												<xsl:value-of select="eb:BaseAmount"/>&#160;
                                            <xsl:value-of select="$currency"/>&#160;
                                        </xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="//eb:TotalGrossAmount"/>&#160;
                                            <xsl:value-of select="$currency"/>&#160;
                                        </xsl:otherwise>
										</xsl:choose>
									</td>
									<td style="text-align:right;">
										<xsl:value-of select="eb:Percentage"/>% &#160;
                                </td>
									<td style="text-align:right;">
										<xsl:choose>
											<xsl:when test="eb:Amount">
												<xsl:value-of select="eb:Amount"/>&#160;
                                            <xsl:value-of select="$currency"/>&#160;
                                        </xsl:when>
											<xsl:otherwise>
												<xsl:choose>
													<xsl:when test="eb:BaseAmount">
														<xsl:value-of select="format-number(((eb:BaseAmount) * (eb:Percentage) ) div (100),'##.00')"/>&#160;
													<xsl:value-of select="$currency"/>&#160;
												</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="format-number(((//eb:TotalGrossAmount) * (eb:Percentage) ) div (100),'##.00')"/>&#160;
													<xsl:value-of select="$currency"/>&#160;
												</xsl:otherwise>
												</xsl:choose>
											</xsl:otherwise>
										</xsl:choose>
									</td>
								</tr>
							</xsl:for-each>
						</tbody>
					</table>
				</td>
			</tr>
		</xsl:if>
		<tr>
			<td colspan="3">
				<br/>
				<br/>
			</td>
		</tr>
		<xsl:if test="//eb:ReductionDetails">
			<xsl:apply-templates select="//eb:ReductionDetails"/>
		</xsl:if>
		<xsl:if test="eb:Comment">
			<tr>
				<td colspan="3" class="comment">
					<xsl:value-of select="eb:Comment"/>
				</td>
			</tr>
		</xsl:if>
		<tr>
			<td colspan="3">
				<br/>
				<hr/>
				<br/>
			</td>
		</tr>
	</xsl:template>
	<!-- Rabatt -->
	<xsl:template match="//eb:ReductionDetails">
		<tr>
			<th class="normal" colspan="3">Rabatt: </th>
		</tr>
		<tr>
			<td colspan="3">
				<table style="border-collapse:separate; border-spacing:0px;width:100%; border-width:0px;">
					<tbody>
						<tr>
							<th class="thright">Basisbetrag</th>
							<th class="thright">USt</th>
							<th class="thright">Prozentsatz</th>
							<th class="thright">Rabatt-Betrag</th>
						</tr>
						<xsl:for-each select="eb:Reduction">
							<tr>
								<td style="text-align:right;">
									<xsl:value-of select="eb:BaseAmount"/>&#160;
									<xsl:value-of select="$currency"/>
								</td>
								<td style="text-align:right;">
									<xsl:value-of select="eb:TaxRate"/>% &#160;
									<xsl:if test="eb:TaxRate/@eb:TaxCode">
										<br/>(<xsl:value-of select="eb:TaxRate/@eb:TaxCode"/>)
									</xsl:if>
								</td>
								<td style="text-align:right;">
									<xsl:value-of select="eb:Percentage"/>% &#160;
                                </td>
								<td style="text-align:right;">
									<xsl:choose>
										<xsl:when test="eb:Amount">
											<xsl:value-of select="eb:Amount"/>&#160;
                                            <xsl:value-of select="$currency"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="format-number(((eb:BaseAmount) * (eb:Percentage) ) div (100),'##.00')"/>&#160;
                                            <xsl:value-of select="$currency"/>
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
						</xsl:for-each>
					</tbody>
				</table>
			</td>
		</tr>
	</xsl:template>
	<!-- ==================== PaymentMethod ============== -->
	<xsl:template match="//eb:PaymentMethod">
		<xsl:choose>
			<xsl:when test="string(@xsi:type)='eb:DirectDebitType'">
                Die Bezahlung erfolgt mit Lastschriftverfahren.
                <xsl:if test="eb:Comment">
					<br/>
					<xsl:value-of select="eb:Comment"/>
				</xsl:if>
			</xsl:when>
			<xsl:when test="string(@xsi:type)='eb:NoPaymentType'">
                Zu dieser Rechnung erfolgt keine Zahlung.
                <xsl:if test="eb:Comment">
					<br/>
					<xsl:value-of select="eb:Comment"/>
				</xsl:if>
			</xsl:when>
			<xsl:when test="string(@xsi:type)='eb:UniversalBankTransactionType'">
                Zu dieser Rechnung erfolgt eine Banktransaktion.
                <xsl:if test="eb:PaymentReference">
					<br/>
                    Zahlungsreferenz: <xsl:value-of select="eb:PaymentReference"/>
				</xsl:if>
				<xsl:if test="eb:BeneficiaryAccount">
					<br/>
					<br/>
					<table style="border-collapse:separate; border-spacing:0px;width:100%; border-width:0px;">
						<tbody>
							<tr>
								<xsl:for-each select="eb:BeneficiaryAccount/*">
									<th class="normal">
										<xsl:apply-templates select="." mode="th"/>
									</th>
								</xsl:for-each>
							</tr>
							<tr>
								<xsl:for-each select="eb:BeneficiaryAccount/*">
									<td>
										<xsl:apply-templates select="."/>
									</td>
								</xsl:for-each>
							</tr>
						</tbody>
					</table>
				</xsl:if>
				<xsl:if test="eb:Comment">
					<br/>
					<xsl:value-of select="eb:Comment"/>
				</xsl:if>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="//eb:BeneficiaryAccount/*">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="//eb:BankName" mode="th">
        Bank
    </xsl:template>
	<xsl:template match="//eb:BankCode" mode="th">
        BLZ
    </xsl:template>
	<xsl:template match="//eb:BIC" mode="th">
        BIC
    </xsl:template>
	<xsl:template match="//eb:BankAccountNr" mode="th">
        Kontonummer
    </xsl:template>
	<xsl:template match="//eb:IBAN" mode="th">
        IBAN
    </xsl:template>
	<xsl:template match="//eb:BankAccountOwner" mode="th">
        Kontoinhaber
    </xsl:template>
	<!-- ==================== Delivery ==================== -->
	<xsl:template match="/eb:Invoice/eb:Delivery">
		<tr>
			<td colspan="3">
				<br/>
				<hr/>
			</td>
		</tr>
		<tr>
			<td colspan="3" class="header">Angaben zur Lieferung</td>
		</tr>
		<tr>
			<td colspan="3">
				<hr/>
				<br/>
			</td>
		</tr>
		<xsl:if test="eb:DeliveryID">
			<tr>
				<td  style="width:{$firstColumnWidth}px;">&#160;</td>
				<td>Liefernummer: </td>
				<td>
					<xsl:value-of select="eb:DeliveryID"/>
				</td>
			</tr>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="eb:Date">
				<tr>
					<td  style="width:{$firstColumnWidth}px;">&#160;</td>
					<td>Lieferdatum: </td>
					<td>
						<xsl:value-of select="eb:Date"/>
					</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr>
					<td  style="width:{$firstColumnWidth}px;">&#160;</td>
					<td>Lieferperiode: </td>
					<td>
                        von <xsl:value-of select="eb:Period/eb:FromDate"/>
						<br/>
                        bis <xsl:value-of select="eb:Period/eb:ToDate"/>
					</td>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
		<tr>
			<td colspan="3">&#160;</td>
		</tr>
		<tr>
			<td style="vertical-align:top;" colspan="3">Die Lieferung erfolgt an die folgende Adresse: </td>
		</tr>
		<tr>
			<td>&#160;</td>
			<td colspan="2">
				<xsl:choose>
					<xsl:when test="eb:Address">
						<xsl:apply-templates select="eb:Address"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="//eb:InvoiceRecipient/eb:Address"/>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
		<xsl:if test="eb:Description">
			<tr>
				<td colspan="3">&#160;</td>
			</tr>
			<tr>
				<td style="vertical-align:top;"  colspan="3">Zus&#228;tzliche Angaben zur Lieferung: </td>
			</tr>
			<tr>
				<td>&#160;</td>
				<td colspan="2">
					<xsl:value-of select="eb:Description"/>
				</td>
			</tr>
		</xsl:if>
		<tr>
			<td colspan="3">
				<hr/>
				<br/>
			</td>
		</tr>
	</xsl:template>
	<!-- ==================== Supplier ==================== -->
	<xsl:template match="//eb:Supplier">
		<tr>
			<td colspan="3">
				<br/>
				<hr/>
			</td>
		</tr>
		<tr>
			<td class="header"  style="width:280px;">&#160;</td>
			<td colspan="2" class="header">Angaben zum Lieferanten</td>
		</tr>
		<tr>
			<td colspan="3">
				<hr/>
				<br/>
			</td>
		</tr>
		<tr>
			<td>&#160;</td>
			<td colspan="2">
				<xsl:apply-templates select="eb:Address"/>
			</td>
		</tr>
		<xsl:if test="eb:OrderReference">
			<xsl:call-template name="eb:OrderReference"/>
		</xsl:if>
		<tr>
			<td colspan="3">
				<br/>
				<hr/>
				<br/>
			</td>
		</tr>
	</xsl:template>
	<!-- ==================== OrderReference ================ -->
	<xsl:template name="eb:OrderReference">
		<tr>
			<td colspan="3">
				<br/>
				<br/>
				<table style="border-collapse:separate; border-spacing:0px;width:100%; border-width:0px;">
					<tbody>
						<tr>
							<th class="normal">Bestellreferenz</th>
							<th class="normal">Datum</th>
							<th class="normal">Beschreibung</th>
						</tr>
						<tr>
							<xsl:for-each select="eb:OrderReference">
								<xsl:apply-templates/>
							</xsl:for-each>
							<xsl:if test="not(eb:OrderReference/eb:ReferenceDate)">
								<td>
									<xsl:text>-</xsl:text>
								</td>
							</xsl:if>
							<xsl:if test="not(eb:OrderReference/eb:Description)">
								<td>
									<xsl:text>-</xsl:text>
								</td>
							</xsl:if>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="//eb:OrderReference/eb:OrderID | //eb:OrderReference/eb:ReferenceDate | //eb:OrderReference/eb:Description">
		<td>
			<xsl:value-of select="."/>
		</td>
	</xsl:template>
	<!-- ==================== Digital Signature ================ -->
	<xsl:template match="//dsig:Signature"/>
</xsl:stylesheet>
