<?xml version="1.0" encoding="ISO-8859-1"?>
<?altova_samplexml XSL Output.xml?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0" xmlns:svrl="http://purl.oclc.org/dsdl/svrl" xmlns:exsl="http://xml.apache.org/xalan"
	extension-element-prefixes="exsl" xmlns:v="http://validation.erpel.at">
	<xsl:output method="xml" indent="yes" />
	<!-- <Result> <Error> <ErrorMessage></ErrorMessage> <ViolatingElement></ViolatingElement> 
		</Error> </Result> -->
	<xsl:template match="/svrl:schematron-output">
		<xsl:element name="v:Result" namespace="http://validation.erpel.at">
			<!-- This code snippet puts the namespaces in the root element. however, 
				since the namespaces are not used when JAXB marshalls/unmarshalls the XML 
				fragment the namespaces are removed. Currently, there is no possibility the 
				keep those namespaces. Thus we put them in "explicit own" elements --><!-- <xsl:for-each select="svrl:ns-prefix-in-attribute-values"> <xsl:variable 
				name="dummy"> <xsl:element name="{@prefix }:e" namespace="{ @uri }" /> </xsl:variable> 
				<xsl:copy-of select="exsl:nodeset($dummy)/*/namespace::*" /> </xsl:for-each> -->
			<xsl:choose>
				<xsl:when test="count(svrl:failed-assert)>0">
					<xsl:attribute name="v:validationPassed">false</xsl:attribute>
					<xsl:for-each select="svrl:ns-prefix-in-attribute-values">
						<xsl:element name="v:Namespace">
							<xsl:attribute name="v:prefix"><xsl:value-of
								select="@prefix" /></xsl:attribute>
							<xsl:attribute name="v:uri"><xsl:value-of
								select="@uri" /></xsl:attribute>
						</xsl:element>
					</xsl:for-each>

					<xsl:apply-templates select="svrl:failed-assert" />

				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="v:validationPassed">true</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
	<xsl:template match="/svrl:schematron-output/svrl:failed-assert">
		<xsl:element name="v:Error">
			<xsl:apply-templates select="svrl:text" />
			<xsl:element name="v:ViolatingElement">
				<xsl:value-of select="preceding-sibling::svrl:fired-rule[1]/@context" />
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="/svrl:schematron-output/svrl:failed-assert/svrl:text">
		<xsl:element name="v:ErrorMessage">
			<xsl:value-of select="." />
		</xsl:element>
	</xsl:template>
	<xsl:template match="node()">
		<xsl:copy />
	</xsl:template>



</xsl:stylesheet>