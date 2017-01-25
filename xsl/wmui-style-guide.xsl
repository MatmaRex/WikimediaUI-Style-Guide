<?xml version="1.0"?>
<xsl:stylesheet version="2.0"
  xmlns:xhtml="http://www.w3.org/1999/xhtml"
  xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" version="1.0" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" indent="yes"/>

<!-- save the dictionary is a variable, so we can access it later -->
<xsl:variable name="dict" select="/dict" />
<xsl:variable name="page" select="/dict/@page" />

<!-- replace the dictionary document with the real document -->
<xsl:template match="/">
  <xsl:apply-templates select="document( concat('../pages/', $page, '/index.xhtml') )/*"/>
</xsl:template>

<!-- insert translated text into nodes with class="translate" etc. -->
<!-- (there is no simple selector for searching space-separated attribute values) -->
<xsl:template match="//node()[contains(concat(' ', normalize-space(@class), ' '), ' translate ')]">
  <!-- determine the key, and find the translated text for the key -->
  <xsl:variable name="key" select="@id" />
  <xsl:variable name="contents" select="$dict//item[@key=$key]" />
  <!-- copy the node... -->
  <xsl:copy>
    <!-- ...with original attributes... -->
    <xsl:apply-templates select="@*" />
    <!-- ...but replace contents with the translated ones -->
    <xsl:apply-templates select="$contents/node()" />
  </xsl:copy>
</xsl:template>

<!-- the identity template -->
<xsl:template match="@*|node()">
  <xsl:copy>
    <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
</xsl:template>

</xsl:stylesheet>
