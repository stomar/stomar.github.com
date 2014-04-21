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
        <title>Orgeln in Herrenberg</title>
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

        <xsl:for-each select="Orgeldatenbank">
          <xsl:for-each select="Orgel">
            <xsl:sort select="Standort/Ort"/>
            <xsl:apply-templates select="."/>

            <div class="centered">[<a href="#top">nach oben</a>]</div>

            <hr/>
          </xsl:for-each>
        </xsl:for-each>

        <address>
          Marcus Stollsteimer <a href="mailto:sto.mar@web.de">&lt;sto.mar@web.de&gt;</a>
        </address>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="Orgel">
    <h2>Die Orgel der <xsl:value-of select="Standort/Name"/>
        in <xsl:value-of select="Standort/Ort"/>
    </h2>
    <p><xsl:value-of select="Orgelbauer/Name"/>
         <xsl:if test="Orgelbauer/Ort != ''">
           <xsl:text>, </xsl:text><xsl:value-of select="Orgelbauer/Ort"/>
         </xsl:if>

      <xsl:if test="Orgelbauer/opus != ''">
        <xsl:text>, opus </xsl:text><xsl:value-of select="Orgelbauer/opus"/>
      </xsl:if>

      <xsl:if test="Jahr != ''">
        <xsl:text>, </xsl:text><xsl:value-of select="Jahr"/>
      </xsl:if>
    </p>

    <table cellspacing="20"><tr valign="top">
      <xsl:apply-templates select="Klaviatur"/>
    </tr></table>

    <p>Koppeln: <xsl:value-of select="Koppeln"/></p>

    <xsl:apply-templates select="Bemerkung"/>
  </xsl:template>


  <xsl:template match="Klaviatur">
    <td>
    <table cellspacing="5">
      <tr><th colspan="2" align="left"><xsl:value-of select="Name"/>
        <xsl:if test="Umfang != ''">
          (<xsl:value-of select="Umfang"/>)
        </xsl:if>
      </th></tr>
      <xsl:for-each select="Reg">
        <xsl:apply-templates select="."/>
      </xsl:for-each>
    </table>
    </td>
  </xsl:template>


  <xsl:template match="Reg">
    <tr>
      <td>
        <xsl:choose>
          <xsl:when test="Name = 'Tremulant'">
            <em>Tremulant</em>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="Name"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="Choere != ''">
          <xsl:text> </xsl:text><xsl:value-of select="Choere"/>f.
        </xsl:if>
        <xsl:if test="@Vorabzug != ''">
          <xsl:text> (Vorabzug)</xsl:text>
        </xsl:if>
      </td>
      <td>
        <xsl:if test="Lage != ''">
          <xsl:value-of select="Lage"/>'
        </xsl:if>
      </td>
    </tr>
  </xsl:template>


  <xsl:template match="Bemerkung">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <xsl:template match="A">
    <a><xsl:attribute name="href"><xsl:value-of select="@href"/>
       </xsl:attribute><xsl:value-of select="."/></a>
  </xsl:template>

</xsl:stylesheet>
