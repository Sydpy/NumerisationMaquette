<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" encoding="utf-8" indent="yes"/>
	<xsl:strip-space elements="*"/>

	<xsl:param name="departements" select="document('../xml/departements.xml')"/>
	<xsl:param name="grandsDomaines" select="document('../xml/grandsDomaines.xml')"/>

	<xsl:template match="/">

		<root>

			<xsl:copy-of select="$departements/*"/>
			<xsl:copy-of select="$grandsDomaines/*"/>

		</root>

	</xsl:template>

</xsl:stylesheet>

