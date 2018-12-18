<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" encoding="utf-8" indent="yes"/>
	<xsl:strip-space elements="*"/>

	<xsl:param name="departements" select="document('../xml/departements.xml')"/>
	<xsl:param name="grandsDomaines" select="document('../xml/grandsDomaines.xml')"/>
	<xsl:param name="personnels" select="document('../xml/personnels.xml')"/>
	<xsl:param name="promos" select="document('../xml/promos.xml')"/>

	<xsl:template match="/">

		<root xmlns="http://mdsi.etudinsa.org/">

			<xsl:copy-of select="$departements/*"/>
			<xsl:copy-of select="$grandsDomaines/*"/>
			<xsl:copy-of select="$personnels/*"/>
			<xsl:copy-of select="$promos/*"/>

			<xsl:copy-of select="*"/>
		</root>

	</xsl:template>

</xsl:stylesheet>

