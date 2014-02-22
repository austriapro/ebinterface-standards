<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xdt="http://www.w3.org/2005/xpath-datatypes" xmlns:eb="http://www.ebinterface.at/schema/4p1/" xmlns:dsig="http://www.w3.org/2000/09/xmldsig#">
	<!-- 
		XSLT for ebInterface 4.1
		For more information on ebInvoice see http://www.ebinterface.at/
		
		Last update:	19.02.2013
		Author: 			Philipp Liegl, Vienna University of Technology
-->
	<xsl:variable name="currency">
		<xsl:value-of select="//eb:Invoice/@eb:InvoiceCurrency"/>
	</xsl:variable>
	<xsl:output method="html" encoding="utf-8" indent="yes"/>
	<!-- ==================== ROOT ==================== -->
	<xsl:template match="/">
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
		<html lang="de">
			<head>
				<title>
					<xsl:value-of select="//eb:Invoice/@eb:DocumentTitle"/>
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
							<xsl:apply-templates select="//eb:Biller"/>
							<br/>
							<br/>
							<!-- Invoice recipient -->
							<xsl:apply-templates select="//eb:InvoiceRecipient"/>
						</div>
						<div class="col-md-6">
							<!-- Logo -->
							<xsl:apply-templates select="//eb:PresentationDetails/eb:LogoURL"/>
							<!-- Type of document -->
							<h2>
								<xsl:call-template name="getDocumentType">
									<xsl:with-param name="documentType" select="//eb:Invoice/@eb:DocumentType"/>
								</xsl:call-template>
							</h2>
							<!-- Document number -->
							<xsl:apply-templates select="eb:Invoice/eb:InvoiceNumber"/>
							<!-- Document date -->
							<xsl:apply-templates select="eb:Invoice/eb:InvoiceDate"/>
							<!-- Optional document title -->
							<xsl:if test="eb:Invoice/@eb:DocumentTitle">
								<xsl:value-of select="eb:Invoice/@eb:DocumentTitle"/>
								<br/>
							</xsl:if>
							<!-- Original or copy? -->
							<xsl:if test="eb:Invoice/@eb:IsDuplicate">
								<span class="label label-danger">Das ist eine Rechnungskopie</span>
								<br/>
							</xsl:if>
							<!-- Cancelled document -->
							<xsl:apply-templates select="eb:Invoice/eb:CancelledOriginalDocument"/>
							<!-- Related documents -->
							<xsl:if test="eb:Invoice/eb:RelatedDocument">
								<br/>
								Referenzierte Dokumente:<br/>
								<ul>									
										<xsl:apply-templates select="eb:Invoice/eb:RelatedDocument"/>
								</ul>								
							</xsl:if>							
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
				<xsl:value-of select="@eb:AddressIdentifierType"/>
				<xsl:text>: </xsl:text>
				<xsl:value-of select="."/>
				<br/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- ==================== Biller ==================== -->
	<xsl:template match="//eb:Biller">
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
	<xsl:template match="//eb:Invoice/eb:CancelledOriginalDocument">
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
	<!-- ==================== Invoice date ==================== -->
	<xsl:template match="eb:Invoice/eb:InvoiceDate">
		Datum: 		
		<xsl:call-template name="prettyPrintDateFunction">
			<xsl:with-param name="dateString" select="."/>
		</xsl:call-template>
		<br/>
	</xsl:template>
	<!-- ==================== Invoice number ==================== -->
	<xsl:template match="eb:Invoice/eb:InvoiceNumber">		
		Nr.: <xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<!-- ==================== InvoiceRecipient ==================== -->
	<xsl:template match="//eb:InvoiceRecipient">
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
	<xsl:template match="eb:AccountingArea">
		Buchungskreis: <xsl:value-of select="."/>
		<br/>
	</xsl:template>
	<xsl:template match="eb:BillersInvoiceRecipientID">
		ID beim Rechnungsssteller: <xsl:value-of select="."/>
		<br/>
	</xsl:template>
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
	<!-- ==================== Presentation Details ==================== -->
	<xsl:template match="//eb:PresentationDetails/eb:LogoURL">
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
		<xsl:choose>
			<xsl:when test=".">
				<xsl:text>UID-Nummer: </xsl:text>
				<xsl:value-of select="."/>
				<br/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	<!-- ==================== Custom function ==================== -->
	<!-- ==================== Pretty print date ==================== -->
	<xsl:template name="prettyPrintDateFunction">
		<xsl:param name="dateString" select="."/>
		<xsl:value-of select="concat(substring(string($dateString), 9,2),'.',substring(string($dateString), 6,2), '.', substring(string($dateString), 1,4))"/>
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
