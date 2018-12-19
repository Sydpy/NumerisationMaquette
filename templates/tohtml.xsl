<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" exclude-result-prefixes="xsl"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:r="http://mdsi.etudinsa.org/">

  <xsl:output method="html" encoding="UTF-8" indent="yes" />

  <xsl:variable name="countUFObligatoire">
    <xsl:value-of select="count(r:root/r:Maquette/r:UFs/r:UFObligatoire) + count(r:root/r:Maquette/r:UFs/r:UFObligatoire/r:UEs/r:UE) + 1"/>
  </xsl:variable>

  <xsl:variable name="countUFChoix">
    <xsl:value-of select="count(r:root/r:Maquette/r:UFs/r:UFChoix) + count(r:root/r:Maquette/r:UFs/r:UFChoix/r:UEs/r:UE) + 1"/>
  </xsl:variable>

  <xsl:template name="ufcontent">
    <tr>
      <td><xsl:value-of select="@code"/></td>
      <td><xsl:value-of select="r:Intitulé"/></td>
      <td><xsl:value-of select="r:ECTS"/></td>
      <xsl:choose>
        <xsl:when test="r:Hétérogène='true'">
          <td>Hétérogène</td>
        </xsl:when>
        <xsl:otherwise>
          <td>Homogène</td>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="r:ParCompétences='true'">
          <td>Par compétences</td>
        </xsl:when>
        <xsl:otherwise>
          <td>Par Notes</td>
        </xsl:otherwise>
      </xsl:choose>
      <td><xsl:value-of select="r:Responsable"/></td>
      <!-- <td><xsl:value-of select="r:root/r:Personnels/r:Personnel[@id=r:Responsable]/r:Nom"/></td> -->
      <td><xsl:value-of select="sum(r:UEs/r:UE/r:HeuresCM)"/></td>
      <td><xsl:value-of select="sum(r:UEs/r:UE/r:HeuresTD)"/></td>
      <td><xsl:value-of select="sum(r:UEs/r:UE/r:HeuresTP)"/></td>
      <td><xsl:value-of select="sum(r:UEs/r:UE/r:HeuresCM) + sum(r:UEs/r:UE/r:HeuresTD) + sum(r:UEs/r:UE/r:HeuresTP)"/></td>
    </tr>
    <xsl:for-each select="r:UEs/r:UE">
      <!-- <xsl:variable name="countEpreuves">
        <xsl:choose>
          <xsl:when test="count(r:Épreuves/r:Épreuve)=0">
            <xsl:value-of select="count(r:Épreuves/r:Épreuve)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="count(r:Épreuves/r:Épreuve)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable> -->
      <tr>
        <td></td>
        <td><xsl:value-of select="r:Intitulé"/></td>
        <td><xsl:value-of select="r:ECTS"/></td>
        <xsl:choose>
          <xsl:when test="r:Hétérogène='true'">
            <td>Hétérogène</td>
          </xsl:when>
          <xsl:otherwise>
            <td>Homogène</td>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="r:ParCompétences='true'">
            <td>Par compétences</td>
          </xsl:when>
          <xsl:otherwise>
            <td>Par Notes</td>
          </xsl:otherwise>
        </xsl:choose>
        <!-- <td><xsl:value-of select="r:root/r:Personnels/r:Personnel[@id=r:Responsable]/r:Nom"/></td> -->
        <td><xsl:value-of select="r:Responsable"/></td>
        <td><xsl:value-of select="r:HeuresCM"/></td>
        <td><xsl:value-of select="r:HeuresTD"/></td>
        <td><xsl:value-of select="r:HeuresTP"/></td>
        <td><xsl:value-of select="r:HeuresCM + r:HeuresTD + r:HeuresTP"/></td>
        <!-- <td rowspan="{$countEpreuves}"><xsl:value-of select="r:Coefficient"/></td> -->
        <td><xsl:value-of select="r:Coefficient"/></td>
        <td><xsl:value-of select="r:Épreuves/r:Épreuve/@code"/></td>
        <td><xsl:value-of select="r:Épreuves/r:Épreuve/r:Intitulé"/></td>
        <td><xsl:value-of select="r:Épreuves/r:Épreuve/r:Coefficient"/></td>
      </tr>
      <!-- <xsl:for-each select="r:Épreuves/r:Épreuve">
        <tr>
          <td><xsl:value-of select="@code"/></td>
          <td><xsl:value-of select="r:Intitulé"/></td>
          <td><xsl:value-of select="r:Coefficient"/></td>
        </tr>
      </xsl:for-each> -->
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="/">
    <html>
      <head>
        <style>
          table, th, td {
          border: 1px solid black;
          border-collapse: collapse;
          }
          th, td {
          padding: 5px;
          text-align: left;
          }
        </style>
      </head>
      <body>
        <h2> Maquette S<xsl:value-of select="r:root/r:Maquette/r:Semestre"/> de la <xsl:value-of select="r:root/r:Maquette/r:Promo"/> </h2>
        <!-- <p></p> -->
        <table style="width:100%">
          <tr>
            <th>Type d'UF</th>
            <th colspan="2">UF</th>
            <th>ECTS</th>
            <th>Répartition des UEs</th>
            <th>Notation</th>
            <th>Responsable</th>
            <th>Heures de CM</th>
            <th>Heures de TD</th>
            <th>Heures de TP</th>
            <th>Total d'heures</th>
            <th>Coefficient</th>
            <th colspan="3">Epreuves</th>
          </tr>
          <tr>
            <th rowspan="{$countUFObligatoire}">UF obligatoire</th>
            <!-- <th>Intitulé</th>
            <th>Code</th> -->
          </tr>
          <xsl:for-each select="r:root/r:Maquette/r:UFs/r:UFObligatoire">
            <!-- <xsl:variable name = "Resp" select="r:Responsable" /> -->
            <xsl:call-template name="ufcontent"/>
          </xsl:for-each>
          <tr>
            <th rowspan="{$countUFChoix}">UF au choix (<xsl:value-of select="r:root/r:Maquette/r:NbUFAChoisir"/> à choisir)</th>
          </tr>
          <xsl:for-each select="r:root/r:Maquette/r:UFs/r:UFChoix">
            <xsl:call-template name="ufcontent"/>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
