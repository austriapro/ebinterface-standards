<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
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
  text-align: left;
  text-align:rightt;
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
                            <xsl:if test="//PresentationDetails/LogoURL">
                                <tr>
                                    <td style="padding-bottom:20">
                                        <xsl:apply-templates select="//PresentationDetails/LogoURL"/>
                                    </td>
                                    <td colspan="2">&#160;</td>
                                </tr>
                            </xsl:if>
                            <tr>
                                <!-- ========== InvoiceRecipient ========== -->
                                <td>
                                    <xsl:apply-templates select="//InvoiceRecipient"/>
                                </td>
                                <!-- =============== Biller =============== -->
                                <td colspan="2">
                                    <xsl:apply-templates select="//Biller"/>
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
                                        <xsl:when test="//DocumentTitle">
                                            <xsl:value-of select="//DocumentTitle"/>
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
                            <xsl:apply-templates select="//InvoiceNumber"/>
                            <xsl:apply-templates select="//InvoiceDate"/>
                            <xsl:apply-templates select="//Tax/VAT/TaxID"/>
                        </tbody>
                    </table>
                    <br/>
                    <br/>
                    <!-- =========== Header Comment ======== -->
                    <xsl:if test="//HeaderComment">
                        <table cellpadding="2" cellspacing="0" width="650" border="0">
                            <tbody>
                                <td class="comment">
                                    <xsl:for-each select="//HeaderComment">
                                        <xsl:value-of select="."/>
                                        <br/>
                                    </xsl:for-each>
                                </td>
                            </tbody>
                        </table>
                        <br/>
                    </xsl:if>
                    <!-- ============ Details =============== -->
                    <xsl:if test="//Details">
                        <table cellpadding="2" cellspacing="0" width="650" border="0">
                            <tbody>
                                <xsl:apply-templates select="//Details"/>
                            </tbody>
                        </table>
                        <br/>
                    </xsl:if>
                    <!-- =========== Footer Comment ======== -->
                    <xsl:if test="//FooterComment">
                        <table cellpadding="2" cellspacing="0" width="650" border="0">
                            <tbody>
                                <td class="comment">
                                    <xsl:for-each select="//FooterComment">
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
                            <xsl:apply-templates select="//PaymentConditions"/>
                        </tbody>
                    </table>
                    <br/><br/>
                    <table cellpadding="2" cellspacing="0" width="650" border="0">
                        <tbody>
                            <tr>
                                <td>
                                    <xsl:apply-templates select="//PaymentMethod"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <br/><br/>
                    <br/><br/><br/><br/><br/>
                    <!-- =========== Delivery ======== -->
                    <xsl:if test="//Delivery">
                        <table cellpadding="2" cellspacing="0" width="650" border="0">
                            <tbody>
                                <xsl:apply-templates select="//Delivery"/>
                            </tbody>
                        </table>
                        <br/><br/><br/><br/><br/>
                    </xsl:if>
                    <!-- =========== Supplier ======== -->
                    <xsl:if test="//Supplier">
                        <table cellpadding="2" cellspacing="0" width="650" border="0">
                            <tbody>
                                <xsl:apply-templates select="//Supplier"/>
                            </tbody>
                        </table>
                        <br/><br/><br/><br/><br/>
                    </xsl:if>
                    <!-- =========== Biller ======== -->
                    <table cellpadding="2" cellspacing="0" width="650" border="0">
                        <tbody>
                            <xsl:apply-templates select="//Biller" mode="details"/>
                        </tbody>
                    </table>
                    <br/><br/><br/><br/><br/>
                    <!-- =========== InvoiceRecipient ======== -->
                    <table cellpadding="2" cellspacing="0" width="650" border="0">
                        <tbody>
                            <xsl:apply-templates select="//InvoiceRecipient" mode="details"/>
                        </tbody>
                    </table>
                    <br/><br/><br/><br/><br/>
                </center>
            </body>
        </html>
    </xsl:template>
    <!-- ================ Biller =================== -->
    <xsl:template match="//Biller">
        <xsl:apply-templates select="Address"/>
    </xsl:template>
    <xsl:template match="//Biller" mode="details">
        <tr><td colspan="3"><br/><hr/></td></tr>
        <tr>
            <td class="header" width="280">&#160;</td>
            <td colspan="2" class="header">Angaben zum Rechnungssteller</td>
        </tr>
        <tr><td colspan="3"><hr/><br/></td></tr>
        <tr>
            <td>&#160;</td>
            <td colspan="2">
                <xsl:apply-templates select="Address"/>
                <xsl:if test="ConsolidatorsBillerID">
                    <br/>ConsolidatorsID: <xsl:value-of select="ConsolidatorsBillerID"/><br/>
                </xsl:if>
                <xsl:if test="InvoiceRecipientsBillerID">
                    <br/><xsl:value-of select="InvoiceRecipientsBillerID"/><br/>
                </xsl:if>
            </td>
        </tr>
        <xsl:if test="OrderReference">
            <xsl:call-template name="OrderReference"/>
        </xsl:if>
        <tr><td colspan="3"><br/><hr/><br/></td></tr>
    </xsl:template>
    <!-- ============ InvoiceRecipient ============== -->
    <xsl:template match="//InvoiceRecipient">
        <xsl:apply-templates select="Address"/>
        <br/>
        <xsl:text>(Kundennummer: </xsl:text>
        <xsl:value-of select="BillersInvoiceRecipientID"/>
        <xsl:text>)</xsl:text>
    </xsl:template>
    <xsl:template match="//InvoiceRecipient" mode="details">
        <tr><td colspan="3"><br/><hr/></td></tr>
        <tr>
            <td class="header" width="280">&#160;</td>
            <td colspan="2" class="header">Angaben zum Rechnungsempfänger</td>
        </tr>
        <tr><td colspan="3"><hr/><br/></td></tr>
        <tr>
            <td>&#160;</td>
            <td colspan="2">
                <xsl:apply-templates select="Address"/>
                <xsl:if test="BillersInvoiceRecipientID">
                    <br/>Kundennummer: <xsl:value-of select="BillersInvoiceRecipientID"/><br/>
                </xsl:if>
            </td>
        </tr>
        <xsl:if test="OrderReference">
            <xsl:call-template name="OrderReference"/>
        </xsl:if>
        <tr><td colspan="3"><br/><hr/><br/></td></tr>
    </xsl:template>
    <!-- ================= Logo ================== -->
    <xsl:template match="//PresentationDetails/LogoURL">
        <xsl:choose>
            <xsl:when test="preceding::URL">
                <xsl:element name="a">
                    <xsl:attribute name="href"><xsl:value-of select="preceding::URL"/></xsl:attribute>
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
    <xsl:template match="//InvoiceNumber">
        <tr>
            <td class="nopadding">&#160;</td>
            <td class="nopadding">Rechnungsnummer: </td>
            <td class="nopadding">
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>
    <!-- ================== InvoiceDate =================== -->
    <xsl:template match="//InvoiceDate">
        <tr>
            <td class="nopadding">&#160;</td>
            <td class="nopadding">Rechnungsdatum: </td>
            <td class="nopadding">
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>
    <!-- ===================== Tax ======================= -->
    <xsl:template match="//TaxID">
        <tr>
            <td class="nopadding">&#160;</td>
            <td class="nopadding">UID: </td>
            <td class="nopadding">
                <xsl:value-of select="."/>
            </td>
        </tr>
    </xsl:template>
    <!-- ==================== Address ==================== -->
    <xsl:template match="//Address">
        <xsl:for-each select="child::*">
            <xsl:apply-templates select="."/>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="//Address/Salutation | //Address/Name | //Address/Street |  //Address/Contact | //Address/AddressExtension | //Address/Country">
        <xsl:value-of select="."/>
        <br/>
    </xsl:template>
    <xsl:template match="//Address/POBox">
        <xsl:text>POBox </xsl:text>
        <xsl:value-of select="."/>
        <br/>
    </xsl:template>
    <xsl:template match="//Address/Town">
        <xsl:if test="following::ZIP">
            <xsl:value-of select="following::ZIP"/>
            <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:value-of select="."/>
        <br/>
    </xsl:template>
    <xsl:template match="//Address/ZIP"/>
    <xsl:template match="//Address/Phone">
        <xsl:text>Tel: </xsl:text>
        <xsl:value-of select="."/>
        <br/>
    </xsl:template>
    <xsl:template match="//Address/Email">
        <xsl:text>E-Mail: </xsl:text>
        <xsl:element name="a">
            <xsl:attribute name="href">mailto: <xsl:value-of select="."/></xsl:attribute>
            <xsl:value-of select="."/>
        </xsl:element>
        <br/>
    </xsl:template>
    <!-- ==================== Details ==================== -->
    <xsl:template match="//Details">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="//ItemList">
        <xsl:variable name="count">
            <xsl:value-of select="count(descendant::*[@Currency and parent::*[name(.)='ListLineItem' and count(preceding-sibling::*)=0]]) + count(descendant::*[parent::*[name(.)='ListLineItem' and count(preceding-sibling::*)=0]])"/>        
        </xsl:variable>
        <!-- ===== items ===== -->
        <xsl:apply-templates/>
        <!-- ===== taxes ===== -->
        <xsl:for-each select="//VAT/Item">
            <tr>
                <xsl:element name="td">
                    <xsl:attribute name="colspan"><xsl:value-of select="$count - 2"/></xsl:attribute>
                    <xsl:value-of select="Percentage"/>
                    <xsl:text>% MWSt. (Basisbetrag: </xsl:text>
                    <xsl:value-of select="TaxedAmount/@Currency"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="TaxedAmount"/>
                    <xsl:text>)</xsl:text>
                </xsl:element>
                <td align="right">
                    <xsl:value-of select="Amount//@Currency"/>
                </td>
                <td align="right">
                    <xsl:value-of select="Amount"/>
                </td>
            </tr>
        </xsl:for-each>
        <xsl:for-each select="//Tax/OtherTax">
            <tr>
                <xsl:element name="td">
                    <xsl:attribute name="colspan"><xsl:value-of select="$count - 2"/></xsl:attribute>
                    <xsl:value-of select="Comment"/>
                </xsl:element>
                <td align="right">
                    <xsl:value-of select="Amount//@Currency"/>
                </td>
                <td align="right">
                    <xsl:value-of select="Amount"/>
                </td>
            </tr>
        </xsl:for-each>
        <!-- ===== gross amount ===== -->
        <xsl:for-each select="ListLineItem">
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
                    <td align="right">
                        <xsl:value-of select="//TotalGrossAmount/@Currency"/>
                    </td>
                    <td align="right">
                        <xsl:value-of select="//TotalGrossAmount"/>
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
    <xsl:template match="//ListLineItem">
        <xsl:variable name="count">
            <xsl:choose>
                <xsl:when test="child::*[@Currency]">
                    <xsl:value-of select="count(child::*) + count(child::*[@Currency])"/>
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
        <xsl:if test="@Currency"><th class="normal">Währung</th></xsl:if>
        <xsl:if test="@Usage='Amount'"><th class="normal">Betrag</th></xsl:if>
        <xsl:if test="@Usage='Boxes'"><th class="normal">Colli</th></xsl:if>
        <xsl:if test="@Usage='ChargeNumber'"><th class="normal">Charge#</th></xsl:if>
        <xsl:if test="@Usage='Color'"><th class="normal">Farbe</th></xsl:if>
        <xsl:if test="@Usage='Description' or @Type='Description2'"><th class="normal">Beschreibung</th></xsl:if>
        <xsl:if test="@Usage='DiscountAmount'"><th class="normal">Skontobasisbetrag</th></xsl:if>
        <xsl:if test="@Usage='DiscountRate'"><th class="normal">Skontorate</th></xsl:if>
        <xsl:if test="@Usage='CustomerArticleNumber'"><th class="normal">Kundenartikel#</th></xsl:if>
        <xsl:if test="@Usage='Number'"><th class="normal">Artikel#</th></xsl:if>
        <xsl:if test="@Usage='Quantity' or @Type='Quantity2'"><th class="normal">Menge</th></xsl:if>
        <xsl:if test="@Usage='ReductionRate'"><th class="normal">Rabattrate</th></xsl:if>
        <xsl:if test="@Usage='SerialNumber'"><th class="normal">Serien#</th></xsl:if>
        <xsl:if test="@Usage='Size'"><th class="normal">Größe</th></xsl:if>
        <xsl:if test="@Usage='TaxRate'"><th class="normal">Steuersatz</th></xsl:if>
        <xsl:if test="@Usage='UnitPrice'"><th class="normal">Einzelpreis</th></xsl:if>
        <xsl:if test="@Usage='Weight'"><th class="normal">Gewicht</th></xsl:if>
    </xsl:template>
    <!-- ==================== PaymentConditions ==================== -->
    <xsl:template match="//PaymentConditions">
        <tr><td colspan="3"><br/><hr/></td></tr>
        <tr>
            <td class="header" width="280">&#160;</td>
            <td colspan="2" class="header">Zahlungsbedingungen</td>
        </tr>
        <tr><td colspan="3"><hr/><br/></td></tr>
        <tr>
            <td>&#160;</td>
            <td>Fälligkeitsdatum: </td>
            <td><xsl:value-of select="DueDate"/></td>
        </tr>
        <xsl:if test="MinimumPayment">
            <tr>
                <td>&#160;</td>
                <td>Mindestbertag: </td>
                <td><xsl:value-of select="MinimumPayment"/></td>
            </tr>
        </xsl:if>
        <xsl:if test="Discount">
            <tr><th class="normal" colspan="3">Skonto: </th></tr>
            <tr>
                <td colspan="3">
                <table cellpadding="2" cellspacing="0" width="100%" border="0">
                    <tbody>
                        <tr>
                            <th class="normal">Bis Datum</th>
                            <th class="thright">Reduzierter Betrag</th>
                            <th class="thright">Skontoprozent</th>
                            <th class="thright">Skontobetrag</th>
                        </tr>
                        <xsl:for-each select="Discount">
                            <tr>
                                <td>
                                    <xsl:value-of select="PaymentDate"/>
                                    &#160;
                                </td>
                                <td align="right">
                                    <xsl:value-of select="DiscountedAmount"/>
                                    &#160;
                                </td>
                                <td align="right">
                                    <xsl:value-of select="Percentage"/>
                                    &#160;
                                </td>
                                <td align="right">
                                    <xsl:value-of select="Amount"/>
                                    &#160;
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
                </td>
            </tr>
        </xsl:if>
        <tr><td colspan="3"><br/><hr/><br/></td></tr>
        <xsl:if test="Comment">
            <tr>
                <td colspan="3" class="comment"><xsl:value-of select="Comment"/></td>
            </tr>
        </xsl:if>
    </xsl:template>
    <!-- ==================== PaymentMethod ============== -->
    <xsl:template match="//PaymentMethod">
        <xsl:choose>
            <xsl:when test="@xsi:type='DirectDebitType'">
                Die Bezahlung erfolgt mit Lastschriftverfahren.
                <xsl:if test="Comment">
                    <br/>
                    <xsl:value-of select="Comment"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="@xsi:type='NoPaymentType'">
                Zu dieser Rechnung erfolgt keine Zahlung.
                <xsl:if test="Comment">
                    <br/>
                    <xsl:value-of select="Comment"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="@xsi:type='UniversalBankTransactionType'">
                Zu dieser Rechnung erfolgt eine Banktransaktion.
                <xsl:if test="PaymentReference">
                    <br/>
                    Zahlungsreferenz: <xsl:value-of select="PaymentReference"/>
                </xsl:if>
                <xsl:if test="BeneficiaryAccount">
                    <br/><br/>
                    <table cellpadding="2" cellspacing="0" width="100%" border="0">
                        <tbody>
                            <tr>
                                <xsl:for-each select="BeneficiaryAccount/*">
                                    <th class="normal">
                                        <xsl:apply-templates select="." mode="th"/>
                                    </th>
                                </xsl:for-each>
                            </tr>
                            <tr>
                                <xsl:for-each select="BeneficiaryAccount/*">
                                    <td>
                                        <xsl:apply-templates select="."/>
                                    </td>
                                </xsl:for-each>
                            </tr>
                        </tbody>
                    </table>
                </xsl:if>
                <xsl:if test="Comment">
                    <br/>
                    <xsl:value-of select="Comment"/>
                </xsl:if>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="//BeneficiaryAccount/*">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="//BankName" mode="th">
        Bank
    </xsl:template>
    <xsl:template match="//BankCode" mode="th">
        BLZ
    </xsl:template>
    <xsl:template match="//BIC" mode="th">
        BIC
    </xsl:template>
    <xsl:template match="//BankAccountNr" mode="th">
        Kontonummer
    </xsl:template>
    <xsl:template match="//IBAN" mode="th">
        IBAN
    </xsl:template>
    <xsl:template match="//BankAccountOwner" mode="th">
        Kontoinhaber
    </xsl:template>
    <!-- ==================== Delivery ==================== -->
    <xsl:template match="//Delivery">
        <tr><td colspan="3"><br/><hr/></td></tr>
        <tr>
            <td class="header" width="280">&#160;</td>
            <td colspan="2" class="header">Angaben zur Lieferung</td>
        </tr>
        <tr><td colspan="3"><hr/><br/></td></tr>
        <xsl:for-each select="DeliveryDate | DeliveryPeriod">
            <xsl:choose>
                <xsl:when test="name(.)='DeliveryDate'">
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
                            von <xsl:value-of select="FromDate"/><br/>
                            bis <xsl:value-of select="ToDate"/>
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
                    <xsl:when test="Address">
                        <xsl:apply-templates select="Address"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="//InvoiceRecipient/Address"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>
        </tr>
        <tr><td colspan="3"><hr/><br/></td></tr>
    </xsl:template>
    <!-- ==================== Supplier ==================== -->
    <xsl:template match="//Supplier">
        <tr><td colspan="3"><br/><hr/></td></tr>
        <tr>
            <td class="header" width="280">&#160;</td>
            <td colspan="2" class="header">Angaben zum Lieferanten</td>
        </tr>
        <tr><td colspan="3"><hr/><br/></td></tr>
        <tr>
            <td>&#160;</td>
            <td colspan="2"><xsl:apply-templates select="Address"/></td>
        </tr>
        <xsl:if test="OrderReference">
            <xsl:call-template name="OrderReference"/>
        </xsl:if>
        <tr><td colspan="3"><br/><hr/><br/></td></tr>
    </xsl:template>
    <!-- ==================== OrderReference ================ -->
    <xsl:template name="OrderReference">
            <tr>
                <td colspan="3"><br/><br/>
                    <table cellpadding="2" cellspacing="0" width="100%" border="0">
                        <tbody>
                            <tr>
                                <th class="normal">Bestellreferenz</th>
                                <th class="normal">Datum</th>
                                <th class="normal">Beschreibung</th>
                            </tr>
                            <xsl:for-each select="OrderReference">
                                <tr><xsl:apply-templates/></tr>
                            </xsl:for-each>
                        </tbody>
                    </table>
                </td>
            </tr>
    </xsl:template>
    <xsl:template match="//OrderReference/ID | //OrderReference/ReferenceDate | //OrderReference/Description">
        <td><xsl:value-of select="."/></td>
    </xsl:template>
</xsl:stylesheet>
