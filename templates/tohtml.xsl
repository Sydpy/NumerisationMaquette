<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" exclude-result-prefixes="xsl"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:m="maquette"
  xmlns:p="personnels">

  <xsl:output method="html" encoding="UTF-8" indent="yes" />

  <xsl:variable name="countUFObligatoire">
    <xsl:value-of select="count(root/root/m:Maquette/m:UFs/m:UFObligatoire) + count(root/root/m:Maquette/m:UFs/m:UFObligatoire/m:UEs/m:UE) + 1"/>
  </xsl:variable>

  <xsl:variable name="countUFChoix">
    <xsl:value-of select="count(root/root/m:Maquette/m:UFs/m:UFChoix) + count(root/root/m:Maquette/m:UFs/m:UFChoix/m:UEs/m:UE) + 1"/>
  </xsl:variable>

  <xsl:template name="ufcontent">
    <tr>
      <td><xsl:value-of select="@code"/></td>
      <td><xsl:value-of select="m:Intitulé"/></td>
      <td><xsl:value-of select="m:ECTS"/></td>
      <xsl:choose>
        <xsl:when test="m:Hétérogène='true'">
          <td>Hétérogène</td>
        </xsl:when>
        <xsl:otherwise>
          <td>Homogène</td>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:choose>
        <xsl:when test="m:ParCompétences='true'">
          <td>Par compétences</td>
        </xsl:when>
        <xsl:otherwise>
          <td>Par Notes</td>
        </xsl:otherwise>
      </xsl:choose>
      <!-- <td><xsl:value-of select="root/root/p:Personnels/p:Personnel[@id=$Resp]/p:Nom"/></td> -->
      <td><xsl:value-of select="m:Responsable"/></td>
      <td><xsl:value-of select="sum(m:UEs/m:UE/m:HeuresCM)"/></td>
      <td><xsl:value-of select="sum(m:UEs/m:UE/m:HeuresTD)"/></td>
      <td><xsl:value-of select="sum(m:UEs/m:UE/m:HeuresTP)"/></td>
      <td><xsl:value-of select="sum(m:UEs/m:UE/m:HeuresCM) + sum(m:UEs/m:UE/m:HeuresTD) + sum(m:UEs/m:UE/m:HeuresTP)"/></td>
    </tr>
    <xsl:for-each select="m:UEs/m:UE">
      <!-- <xsl:variable name="countEpreuves">
        <xsl:choose>
          <xsl:when test="count(m:Épreuves/m:Épreuve)=0">
            <xsl:value-of select="count(m:Épreuves/m:Épreuve)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="count(m:Épreuves/m:Épreuve)"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable> -->
      <tr>
        <td></td>
        <td><xsl:value-of select="m:Intitulé"/></td>
        <td><xsl:value-of select="m:ECTS"/></td>
        <xsl:choose>
          <xsl:when test="m:Hétérogène='true'">
            <td>Hétérogène</td>
          </xsl:when>
          <xsl:otherwise>
            <td>Homogène</td>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="m:ParCompétences='true'">
            <td>Par compétences</td>
          </xsl:when>
          <xsl:otherwise>
            <td>Par Notes</td>
          </xsl:otherwise>
        </xsl:choose>
        <!-- <td><xsl:value-of select="root/root/p:Personnels/p:Personnel[@id=$Resp]/p:Nom"/></td> -->
        <td><xsl:value-of select="m:Responsable"/></td>
        <td><xsl:value-of select="m:HeuresCM"/></td>
        <td><xsl:value-of select="m:HeuresTD"/></td>
        <td><xsl:value-of select="m:HeuresTP"/></td>
        <td><xsl:value-of select="m:HeuresCM + m:HeuresTD + m:HeuresTP"/></td>
        <!-- <td rowspan="{$countEpreuves}"><xsl:value-of select="m:Coefficient"/></td> -->
        <td><xsl:value-of select="m:Coefficient"/></td>
        <td><xsl:value-of select="m:Épreuves/m:Épreuve/@code"/></td>
        <td><xsl:value-of select="m:Épreuves/m:Épreuve/m:Intitulé"/></td>
        <td><xsl:value-of select="m:Épreuves/m:Épreuve/m:Coefficient"/></td>
      </tr>
      <!-- <xsl:for-each select="m:Épreuves/m:Épreuve">
        <tr>
          <td><xsl:value-of select="@code"/></td>
          <td><xsl:value-of select="m:Intitulé"/></td>
          <td><xsl:value-of select="m:Coefficient"/></td>
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
        <h2> Maquette S<xsl:value-of select="root/root/m:Maquette/m:Semestre"/> de la <xsl:value-of select="root/root/m:Maquette/m:Promo"/> </h2>
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
          <xsl:for-each select="root/root/m:Maquette/m:UFs/m:UFObligatoire">
            <!-- <xsl:variable name = "Resp" select="m:Responsable" /> -->
            <xsl:call-template name="ufcontent"/>
          </xsl:for-each>
          <tr>
            <th rowspan="{$countUFChoix}">UF au choix (<xsl:value-of select="root/root/m:Maquette/m:NbUFAChoisir"/> à choisir)</th>
          </tr>
          <xsl:for-each select="root/root/m:Maquette/m:UFs/m:UFChoix">
            <xsl:call-template name="ufcontent"/>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
