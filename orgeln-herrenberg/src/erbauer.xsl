<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

  <xsl:output method="html"
       doctype-public="-//W3C//DTD HTML 4.01//EN"
       doctype-system="http://www.w3.org/TR/html4/strict.dtd"/>

  <xsl:template match="/">
    <html>
      <head>
        <meta http-equiv="content-language" content="de"/>
        <title>Orgeln in Herrenberg / Orgelbauer</title>
        <meta name="keywords" lang="de" content="Orgeln,Dispositionen,Herrenberg"/>
        <meta name="keywords" lang="en" content="pipe organs,specifications,stoplists,Herrenberg"/>
        <meta name="description" lang="de" content="Hier finden Sie Dispositionen von Orgeln in und um Herrenberg."/>
        <meta name="description" lang="en" content="Descriptions of pipe organs near Herrenberg, Germany."/>
        <meta name="author" content="Marcus Stollsteimer"/>

        <link rel="shortcut icon" href="../orgicon.ico"/>
        <link rel="stylesheet" type="text/css" href="../format.css"/>
        <link rel="start" href="../index.html" title="Startseite"/>
      </head>
      <body>

        <ul class="nav">
        <li><a name="top"></a><span class="hidden"><a href="#skip">Navigation überspringen</a> | </span>
        <a href="../index.html">Home</a></li>
        <li><a href="orte.html">Orte</a></li>
        <li><a href="erbauer.html">Orgelbauer</a></li>
        <li><a href="../links.html">Links</a></li>
        </ul>
        <div><a name="skip"></a></div>

        <h2>Dispositionen nach Erbauer geordnet</h2>

        <xsl:for-each select="Orgeldatenbank">
          <ul>
            <xsl:for-each select="Orgel">
              <xsl:sort select="Orgelbauer/@sortkey"/>
              <xsl:apply-templates select="." mode="Erbauer"/>
            </xsl:for-each>
          </ul>
        </xsl:for-each>

        <div class="centered">[<a href="#top">nach oben</a>]</div>

        <hr/>
        <address>
          Marcus Stollsteimer <a href="mailto:sto.mar@web.de">&lt;sto.mar@web.de&gt;</a>
        </address>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="Orgel">
    <li><a><xsl:attribute name="href">
    <xsl:value-of select="@id"/>.html</xsl:attribute>
    <xsl:value-of select="Standort/Ort"/>
      <xsl:if test="Standort/Name != ''">
        (<xsl:value-of select="Standort/Name"/>)
        </xsl:if></a></li>
  </xsl:template>

  <xsl:template match="Orgel" mode="Erbauer">
    <li><xsl:value-of select="Orgelbauer/Name"/>
      (<a><xsl:attribute name="href">
         <xsl:value-of select="@id"/>.html</xsl:attribute>
          <xsl:value-of select="Standort/Ort"/>
          <xsl:if test="Standort/Name != ''">
            <xsl:text>, </xsl:text><xsl:value-of select="Standort/Name"/>
          </xsl:if></a>)</li>
  </xsl:template>

</xsl:stylesheet>
