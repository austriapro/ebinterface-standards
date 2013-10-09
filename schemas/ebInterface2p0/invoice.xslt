<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:eb="http://www.ebinterface.at/schema/2p0/" xmlns:dsig="http://www.w3.org/2000/09/xmldsig#">
    <xsl:param name="invoiceamount">0</xsl:param>
    <xsl:template match="/">
        <html>
            <head>
                <title>Rechnungsdetails</title>
                <style>
td{
  font-family: Verdana, Arial, Helvetica, sans-serif;
  font-size: 12px;
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
}
.comment{
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
hr{
    border: 1px solid #000000;
}
                </style>
            </head>
            <body>
                <center>
                    <table cellpadding="2" cellspacing="0" width="650" border="0">
                        <tbody>
                            <!-- ========== Logo ========== -->
                            <xsl:if test="//eb:PresentationDetails/eb:LogoURL">
                                <tr>
                                    <td style="padding-bottom:20">
                                        <xsl:apply-templates select="//eb:PresentationDetails/eb:LogoURL"/>
                                    </td>
                                    <td colspan="2" align="right" valign="top"><img src="http://www.ebinterface.at/images/eb_logo_approved.gif" alt="ebInvoice approved"/></td>
                                </tr>
                            </xsl:if>
                            <tr>
                                <!-- ========== InvoiceRecipient ========== -->
                                <td>
                                    <xsl:apply-templates select="//eb:InvoiceRecipient"/>
                                </td>
                                <!-- =============== Biller =============== -->
                                <td colspan="2">
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
                                <td class="header" width="280">&#160;</td>
                                <td colspan="2" class="header">
                                    <xsl:choose>
                                        <xsl:when test="//eb:DocumentTitle">
                                            <xsl:value-of select="//eb:DocumentTitle"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>Rechnung</xsl:text>
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
                        </tbody>
                    </table>
                    <br/>
                    <br/>
                    <!-- =========== Header Comment ======== -->
                    <xsl:if test="//eb:HeaderComment">
                        <table cellpadding="2" cellspacing="0" width="650" border="0">
                            <tbody>
                                <td class="comment">
                                    <xsl:for-each select="//eb:HeaderComment">
                                        <xsl:value-of select="."/>
                                        <br/>
                                    </xsl:for-each>
                                </td>
                            </tbody>
                        </table>
                        <br/>
                    </xsl:if>
                    <!-- ============ Details =============== -->
                    <xsl:if test="//eb:Details">
                        <table cellpadding="2" cellspacing="0" width="650" border="0">
                            <tbody>
                                <xsl:apply-templates select="//eb:Details"/>
                            </tbody>
                        </table>
                        <br/>
                    </xsl:if>
                    <!-- =========== Footer Comment ======== -->
                    <xsl:if test="//eb:FooterComment">
                        <table cellpadding="2" cellspacing="0" width="650" border="0">
                            <tbody>
                                <td class="comment">
                                    <xsl:for-each select="//eb:FooterComment">
                                        <xsl:value-of select="."/>
                                        <br/>
                                    </xsl:for-each>
                                </td>
                            </tbody>
                        </table>
                    </xsl:if>
                    <br/><br/><br/><br/><br/>
                    <!-- =========== PaymentConditions ======== -->
                    <table cellpadding="2" cellspacing="0" width="650" border="0">
                        <tbody>
                            <xsl:apply-templates select="//eb:PaymentConditions"/>
                        </tbody>
                    </table>
                    <br/><br/>
                    <table cellpadding="2" cellspacing="0" width="650" border="0">
                        <tbody>
                            <tr>
                                <td>
                                    <xsl:apply-templates select="//eb:PaymentMethod"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <br/><br/>
                    <br/><br/><br/><br/><br/>
                    <!-- =========== Delivery ======== -->
                    <xsl:if test="//eb:Delivery">
                        <table cellpadding="2" cellspacing="0" width="650" border="0">
                            <tbody>
                                <xsl:apply-templates select="//eb:Delivery"/>
                            </tbody>
                        </table>
                        <br/><br/><br/><br/><br/>
                    </xsl:if>
                    <!-- =========== Supplier ======== -->
                    <xsl:if test="//eb:Supplier">
                        <table cellpadding="2" cellspacing="0" width="650" border="0">
                            <tbody>
                                <xsl:apply-templates select="//eb:Supplier"/>
                            </tbody>
                        </table>
                        <br/><br/><br/><br/><br/>
                    </xsl:if>
                    <!-- =========== Biller ======== -->
                    <table cellpadding="2" cellspacing="0" width="650" border="0">
                        <tbody>
                            <xsl:apply-templates select="//eb:Biller" mode="details"/>
                        </tbody>
                    </table>
                    <br/><br/><br/><br/><br/>
                    <!-- =========== InvoiceRecipient ======== -->
                    <table cellpadding="2" cellspacing="0" width="650" border="0">
                        <tbody>
                            <xsl:apply-templates select="//eb:InvoiceRecipient" mode="details"/>
                        </tbody>
                    </table>
                    <br/><br/><br/><br/><br/>
                </center>
            </body>
        </html>
    </xsl:template>
    <!-- ================ Biller =================== -->
    <xsl:template match="//eb:Biller">
        <xsl:apply-templates select="eb:Address"/>
    </xsl:template>
    <xsl:template match="//eb:Biller" mode="details">
        <tr><td colspan="3"><br/><hr/></td></tr>
        <tr>
            <td class="header" width="280">&#160;</td>
            <td colspan="2" class="header">Angaben zum Rechnungssteller</td>
        </tr>
        <tr><td colspan="3"><hr/><br/></td></tr>
        <tr>
            <td>&#160;</td>
            <td colspan="2">
                <xsl:apply-templates select="eb:Address"/>
                <xsl:if test="eb:VATIdentificationNumber">
                    <br/><xsl:apply-templates select="eb:VATIdentificationNumber"/><br/>
                </xsl:if>
                <xsl:if test="eb:ConsolidatorsBillerID">
                    <br/>ConsolidatorsID: <xsl:value-of select="eb:ConsolidatorsBillerID"/><br/>
                </xsl:if>
                <xsl:if test="eb:InvoiceRecipientsBillerID">
                    InvoiceRecipientsBillerID: <xsl:value-of select="eb:InvoiceRecipientsBillerID"/><br/>
                </xsl:if>
            </td>
        </tr>
        <xsl:if test="eb:OrderReference">
            <xsl:call-template name="eb:OrderReference"/>
        </xsl:if>
        <tr><td colspan="3"><br/><hr/><br/></td></tr>
    </xsl:template>
    <!-- ============ InvoiceRecipient ============== -->
    <xsl:template match="//eb:InvoiceRecipient">
        <xsl:apply-templates select="eb:Address"/>
        <br/>
        <xsl:if test="eb:VATIdentificationNumber">
            <xsl:apply-templates select="eb:VATIdentificationNumber"/><br/>
        </xsl:if>
        <xsl:text>(Kundennummer: </xsl:text>
        <xsl:value-of select="eb:BillersInvoiceRecipientID"/>
        <xsl:text>)</xsl:text>
    </xsl:template>
    <xsl:template match="//eb:InvoiceRecipient" mode="details">
        <tr><td colspan="3"><br/><hr/></td></tr>
        <tr>
            <td class="header" width="280">&#160;</td>
            <td colspan="2" class="header">Angaben zum Rechnungsempfänger</td>
        </tr>
        <tr><td colspan="3"><hr/><br/></td></tr>
        <tr>
            <td>&#160;</td>
            <td colspan="2">
                <xsl:apply-templates select="eb:Address"/>
                <xsl:if test="eb:BillersInvoiceRecipientID">
                    <br/>Kundennummer: <xsl:value-of select="eb:BillersInvoiceRecipientID"/><br/>
                </xsl:if>
            </td>
        </tr>
        <xsl:if test="eb:OrderReference">
            <xsl:call-template name="eb:OrderReference"/>
        </xsl:if>
        <tr><td colspan="3"><br/><hr/><br/></td></tr>
    </xsl:template>
    <!-- ================= Logo ================== -->
    <xsl:template match="//eb:PresentationDetails/eb:LogoURL">
        <xsl:choose>
            <xsl:when test="preceding::eb:URL">
                <xsl:element name="a">
                    <xsl:attribute name="href"><xsl:value-of select="preceding::eb:URL"/></xsl:attribute>
                    <xsl:element name="img">
                        <xsl:attribute name="border">0</xsl:attribute>
                        <xsl:attribute name="src"><xsl:value-of select="."/></xsl:attribute>
                    </xsl:element>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="img">
                    <xsl:attribute name="border">0</xsl:attribute>
                    <xsl:attribute name="src"><xsl:value-of select="."/></xsl:attribute>
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
    <!-- ===================== UID ======================= -->
    <xsl:template match="//eb:VATIdentificationNumber">
        UI: <xsl:value-of select="."/>
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
        <xsl:if test="following::eb:ZIP">
            <xsl:value-of select="following::eb:ZIP"/>
            <xsl:text> </xsl:text>
        </xsl:if>
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
            <xsl:attribute name="href">mailto: <xsl:value-of select="."/></xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
        <br/>
    </xsl:template>
    <!-- ==================== Details ==================== -->
    <xsl:template match="//eb:Details">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="//eb:ItemList">
        <xsl:variable name="count">
            <xsl:value-of select="count(descendant::*[@eb:Currency and parent::*[name(.)='eb:ListLineItem' and count(preceding-sibling::*)=0]]) + count(descendant::*[parent::*[name(.)='eb:ListLineItem' and count(preceding-sibling::*)=0]])"/>        
        </xsl:variable>
        <!-- ===== items ===== -->
        <xsl:apply-templates/>
        <!-- ===== taxes ===== -->
        <xsl:for-each select="//eb:VAT/eb:Item">
            <tr>
                <xsl:element name="td">
                    <xsl:attribute name="colspan"><xsl:value-of select="$count - 2"/></xsl:attribute>
                    <xsl:value-of select="eb:Percentage"/>
                    <xsl:text>% MWSt. (Basisbetrag: </xsl:text>
                    <xsl:value-of select="eb:TaxedAmount"/>
                    <xsl:text>&#160;</xsl:text>
                    <xsl:value-of select="eb:TaxedAmount/@eb:Currency"/>
                    <xsl:text>)</xsl:text>
                </xsl:element>
                <td align="right" colspan="2">
                    <xsl:value-of select="eb:Amount"/>
                    <xsl:text>&#160;</xsl:text>
                    <xsl:value-of select="eb:Amount//@eb:Currency"/>
                    <xsl:text>&#160;</xsl:text>
                </td>
            </tr>
        </xsl:for-each>
        <xsl:for-each select="//eb:Tax/eb:OtherTax">
            <tr>
                <xsl:element name="td">
                    <xsl:attribute name="colspan"><xsl:value-of select="$count - 2"/></xsl:attribute>
                    <xsl:value-of select="eb:Comment"/>
                </xsl:element>
                <td align="right" colspan="2">
                    <xsl:value-of select="eb:Amount"/>
                    <xsl:text>&#160;</xsl:text>
                    <xsl:value-of select="eb:Amount//@eb:Currency"/>
                        <xsl:text>&#160;</xsl:text>
                </td>
            </tr>
        </xsl:for-each>
        <!-- ===== gross amount ===== -->
        <xsl:for-each select="eb:ListLineItem">
            <xsl:sort select="count(child::*)" order="descending"/>
            <xsl:if test="position()=1">
                <tr>
                    <xsl:element name="td">
                        <xsl:attribute name="colspan"><xsl:value-of select="$count"/></xsl:attribute>
                        <hr/>
                    </xsl:element>
                </tr>
                <tr>
                    <xsl:element name="td">
                        <xsl:attribute name="colspan"><xsl:value-of select="$count - 2"/></xsl:attribute>
                        Rechnungsbetrag
                    </xsl:element>
                    <td align="right" colspan="2">
                        <xsl:value-of select="//eb:TotalGrossAmount"/>
                        <xsl:text>&#160;</xsl:text>
                        <xsl:value-of select="//eb:TotalGrossAmount/@eb:Currency"/>
                        <xsl:text>&#160;</xsl:text>
                    </td>
                </tr>
                <tr>
                    <xsl:element name="td">
                        <xsl:attribute name="colspan"><xsl:value-of select="$count"/></xsl:attribute>
                        <hr/>
                    </xsl:element>
                </tr>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="//eb:ListLineItem">
        <xsl:variable name="count">
            <xsl:choose>
                <xsl:when test="child::*[@eb:Currency]">
                    <xsl:value-of select="count(child::*) + count(child::*[@eb:Currency])"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="count(child::*)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:if test="count(preceding-sibling::*)=0">
            <tr>
                <xsl:for-each select="child::*">
                    <xsl:call-template name="header"/>
                </xsl:for-each>
            </tr>
            <tr>
                <xsl:element name="th">
                    <xsl:attribute name="class">normal</xsl:attribute>
                    <xsl:attribute name="colspan"><xsl:value-of select="$count"/></xsl:attribute>
                    <hr/>
                </xsl:element>
            </tr>
        </xsl:if>
        <tr>
            <xsl:for-each select="child::*">
                <xsl:element name="td">
                    <xsl:if test="not(string(number(.))='NaN')">
                        <xsl:attribute name="align">right</xsl:attribute>
                    </xsl:if>
                    <xsl:value-of select="."/>
                    <xsl:if test="@eb:Unit">
                        <xsl:text>&#160;</xsl:text>
                        <xsl:value-of select="@eb:Unit"/>
                        <xsl:text>&#160;</xsl:text>
                    </xsl:if>
                </xsl:element>
            </xsl:for-each>
        </tr>
        <!-- erzeugt eine leere zeile -->
        <xsl:if test="count(following-sibling::*)=0">
            <tr>
                <xsl:for-each select="child::*">
                    <td height="20">&#160;</td>
                </xsl:for-each>
            </tr>        
        </xsl:if>
    </xsl:template>
    <xsl:template name="header">
        <xsl:if test="@eb:Currency"><th class="normal">Währung</th></xsl:if>
        <xsl:if test="@eb:Usage='Amount'"><th class="normal">Betrag</th></xsl:if>
        <xsl:if test="@eb:Usage='Boxes'"><th class="normal">Colli</th></xsl:if>
        <xsl:if test="@eb:Usage='ChargeNumber'"><th class="normal">Charge#</th></xsl:if>
        <xsl:if test="@eb:Usage='Color'"><th class="normal">Farbe</th></xsl:if>
        <xsl:if test="@eb:Usage='Description' or @Type='Description2'"><th class="normal">Beschreibung</th></xsl:if>
        <xsl:if test="@eb:Usage='DiscountAmount'"><th class="normal">Skontobasisbetrag</th></xsl:if>
        <xsl:if test="@eb:Usage='DiscountRate'"><th class="normal">Skontorate</th></xsl:if>
        <xsl:if test="@eb:Usage='CustomerArticleNumber'"><th class="normal">Kundenartikel#</th></xsl:if>
        <xsl:if test="@eb:Usage='Number'"><th class="normal">Artikel#</th></xsl:if>
        <xsl:if test="@eb:Usage='Quantity' or @Type='Quantity2'"><th class="normal">Menge</th></xsl:if>
        <xsl:if test="@eb:Usage='ReductionRate'"><th class="normal">Rabattrate</th></xsl:if>
        <xsl:if test="@eb:Usage='SerialNumber'"><th class="normal">Serien#</th></xsl:if>
        <xsl:if test="@eb:Usage='Size'"><th class="normal">Größe</th></xsl:if>
        <xsl:if test="@eb:Usage='TaxRate'"><th class="normal">Steuersatz</th></xsl:if>
        <xsl:if test="@eb:Usage='UnitPrice'"><th class="normal">Einzelpreis</th></xsl:if>
        <xsl:if test="@eb:Usage='Weight'"><th class="normal">Gewicht</th></xsl:if>
    </xsl:template>
    <!-- ==================== PaymentConditions ==================== -->
    <xsl:template match="//eb:PaymentConditions">
        <tr><td colspan="3"><br/><hr/></td></tr>
        <tr>
            <td class="header" width="280">&#160;</td>
            <td colspan="2" class="header">Zahlungsbedingungen</td>
        </tr>
        <tr><td colspan="3"><hr/><br/></td></tr>
        <tr>
            <td>&#160;</td>
            <td>Fälligkeitsdatum: </td>
            <td><xsl:value-of select="eb:DueDate"/></td>
        </tr>
        <xsl:if test="eb:MinimumPayment">
            <tr>
                <td>&#160;</td>
                <td>Mindestbertag: </td>
                <td><xsl:value-of select="eb:MinimumPayment"/>&#160;<xsl:value-of select="eb:MinimumPayment/@eb:Currency"/>&#160;</td>
            </tr>
        </xsl:if>
        <xsl:if test="eb:Discount">
            <tr><th class="normal" colspan="3">Skonto: </th></tr>
            <tr>
                <td colspan="3">
                <table cellpadding="2" cellspacing="0" width="100%" border="0">
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
                                <td align="right">
                                    <xsl:choose>
                                        <xsl:when test="eb:BaseAmount">
                                            <xsl:value-of select="eb:BaseAmount"/>&#160;
                                            <xsl:value-of select="eb:BaseAmount/@eb:Currency"/>&#160;
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="//eb:TotalGrossAmount"/>&#160;
                                            <xsl:value-of select="//eb:TotalGrossAmount/@eb:Currency"/>&#160;
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </td>
                                <td align="right">
                                    <xsl:value-of select="eb:Percentage"/>% &#160;
                                </td>
                                <td align="right">
                                    <xsl:choose>
                                        <xsl:when test="eb:Amount">
                                            <xsl:value-of select="eb:Amount"/>&#160;
                                            <xsl:value-of select="eb:Amount/@eb:Currency"/>&#160;
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="((//eb:TotalGrossAmount) * (eb:Percentage) ) div (100)"/>&#160;
                                            <xsl:value-of select="//eb:TotalGrossAmount/@eb:Currency"/>&#160;
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
        <tr><td colspan="3"><br/><hr/><br/></td></tr>
        <xsl:if test="eb:Reduction">
            <tr><th class="normal" colspan="3">Rabatt: </th></tr>
            <tr>
                <td colspan="3">
                <table cellpadding="2" cellspacing="0" width="100%" border="0">
                    <tbody>
                        <tr>
                            <th class="thright">Basisbetrag</th>
                            <th class="thright">Rabatt-Prozent</th>
                            <th class="thright">Rabatt-Betrag</th>
                        </tr>
                        <xsl:for-each select="eb:Reduction">
                            <tr>
                                <td align="right">
                                    <xsl:choose>
                                        <xsl:when test="eb:BaseAmount">
                                            <xsl:value-of select="eb:BaseAmount/@eb:Currency"/>&#160;
                                            <xsl:value-of select="eb:BaseAmount"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="//eb:TotalGrossAmount/@eb:Currency"/>&#160;
                                            <xsl:value-of select="//eb:TotalGrossAmount"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </td>
                                <td align="right">
                                    <xsl:value-of select="eb:Percentage"/>% &#160;
                                </td>
                                <td align="right">
                                    <xsl:choose>
                                        <xsl:when test="eb:Amount">
                                            <xsl:value-of select="eb:Amount/@eb:Currency"/>&#160;
                                            <xsl:value-of select="eb:Amount"/>&#160;
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="//eb:TotalGrossAmount/@eb:Currency"/>&#160;
                                            <xsl:value-of select="((//eb:TotalGrossAmount) * (eb:Percentage) ) div (100)"/>
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
        <xsl:if test="eb:Comment">
            <tr>
                <td colspan="3" class="comment"><xsl:value-of select="eb:Comment"/></td>
            </tr>
        </xsl:if>
    </xsl:template>
    <!-- ==================== PaymentMethod ============== -->
    <xsl:template match="//eb:PaymentMethod">
        <xsl:choose>
            <xsl:when test="@xsi:type='eb:DirectDebitType'">
                Die Bezahlung erfolgt mit Lastschriftverfahren.
                <xsl:if test="eb:Comment">
                    <br/>
                    <xsl:value-of select="eb:Comment"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="@xsi:type='eb:NoPaymentType'">
                Zu dieser Rechnung erfolgt keine Zahlung.
                <xsl:if test="eb:Comment">
                    <br/>
                    <xsl:value-of select="eb:Comment"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="@xsi:type='eb:UniversalBankTransactionType'">
                Zu dieser Rechnung erfolgt eine Banktransaktion.
                <xsl:if test="eb:PaymentReference">
                    <br/>
                    Zahlungsreferenz: <xsl:value-of select="eb:PaymentReference"/>
                </xsl:if>
                <xsl:if test="eb:BeneficiaryAccount">
                    <br/><br/>
                    <table cellpadding="2" cellspacing="0" width="100%" border="0">
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
    <xsl:template match="//eb:Delivery">
        <tr><td colspan="3"><br/><hr/></td></tr>
        <tr>
            <td class="header" width="280">&#160;</td>
            <td colspan="2" class="header">Angaben zur Lieferung</td>
        </tr>
        <tr><td colspan="3"><hr/><br/></td></tr>
        <xsl:for-each select="eb:DeliveryDate | eb:DeliveryPeriod">
            <xsl:choose>
                <xsl:when test="name(.)='eb:DeliveryDate'">
                    <tr>
                        <td>&#160;</td>
                        <td>
                            <xsl:value-of select="count(preceding-sibling::*) + 1"/>
                            <xsl:text>. </xsl:text> 
                        Lieferdatum: </td>
                        <td><xsl:value-of select="."/></td>
                    </tr>
                </xsl:when>
                <xsl:otherwise>
                    <tr>
                        <td>&#160;</td>
                        <td>
                            <xsl:value-of select="count(preceding-sibling::*) + 1"/>
                            <xsl:text>. </xsl:text> 
                            Lieferperiode: </td>
                        <td>
                            von <xsl:value-of select="eb:FromDate"/><br/>
                            bis <xsl:value-of select="eb:ToDate"/>
                        </td>
                    </tr>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
        <tr>
            <td colspan="3">&#160;</td>
        </tr>
        <tr>
            <td valign="top" colspan="3">Die Lieferung erfolgt an die folgende Adresse: </td>
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
        <tr><td colspan="3"><hr/><br/></td></tr>
    </xsl:template>
    <!-- ==================== Supplier ==================== -->
    <xsl:template match="//eb:Supplier">
        <tr><td colspan="3"><br/><hr/></td></tr>
        <tr>
            <td class="header" width="280">&#160;</td>
            <td colspan="2" class="header">Angaben zum Lieferanten</td>
        </tr>
        <tr><td colspan="3"><hr/><br/></td></tr>
        <tr>
            <td>&#160;</td>
            <td colspan="2"><xsl:apply-templates select="eb:Address"/></td>
        </tr>
        <xsl:if test="eb:OrderReference">
            <xsl:call-template name="eb:OrderReference"/>
        </xsl:if>
        <tr><td colspan="3"><br/><hr/><br/></td></tr>
    </xsl:template>
    <!-- ==================== OrderReference ================ -->
    <xsl:template name="eb:OrderReference">
            <tr>
                <td colspan="3"><br/><br/>
                    <table cellpadding="2" cellspacing="0" width="100%" border="0">
                        <tbody>
                            <tr>
                                <th class="normal">Bestellreferenz</th>
                                <th class="normal">Datum</th>
                                <th class="normal">Beschreibung</th>
                            </tr>
                            <xsl:for-each select="eb:OrderReference">
                                <tr><xsl:apply-templates/></tr>
                            </xsl:for-each>
                        </tbody>
                    </table>
                </td>
            </tr>
    </xsl:template>
    <xsl:template match="//eb:OrderReference/eb:ID | //eb:OrderReference/eb:ReferenceDate | //eb:OrderReference/eb:Description">
        <td><xsl:value-of select="."/></td>
    </xsl:template>
    <!-- ==================== Digital Signature ================ -->
    <xsl:template match="//dsig:Signature"/>
</xsl:stylesheet>
