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
    <tr class="ufhead">
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
      <td><xsl:value-of select="r:root/r:Personnels/r:Personnel[@id=r:Responsable]/r:Nom"/></td>
      <td><xsl:value-of select="sum(r:UEs/r:UE/r:HeuresCM)"/></td>
      <td><xsl:value-of select="sum(r:UEs/r:UE/r:HeuresTD)"/></td>
      <td><xsl:value-of select="sum(r:UEs/r:UE/r:HeuresTP)"/></td>
      <td><xsl:value-of select="sum(r:UEs/r:UE/r:HeuresCM) + sum(r:UEs/r:UE/r:HeuresTD) + sum(r:UEs/r:UE/r:HeuresTP)"/></td>
      <td></td>
      <td></td>
      <td></td>
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

      <xsl:element name="tr"><xsl:attribute name="id"><xsl:value-of select="@code"/></xsl:attribute>  <!-- TODO Le @code n'est pas récupéré ici need help -->
        <td class="ufcontent"></td>
        <td class="ufcontent"><xsl:value-of select="r:Intitulé"/></td>
        <td class="ufcontent"><xsl:value-of select="r:ECTS"/></td>
        <xsl:choose>
          <xsl:when test="r:Hétérogène='true'">
            <td class="ufcontent">Hétérogène</td>
          </xsl:when>
          <xsl:otherwise>
            <td class="ufcontent">Homogène</td>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="r:ParCompétences='true'">
            <td class="ufcontent">Par compétences</td>
          </xsl:when>
          <xsl:otherwise>
            <td class="ufcontent">Par Notes</td>
          </xsl:otherwise>
        </xsl:choose>
        <!-- <td><xsl:value-of select="r:root/r:Personnels/r:Personnel[@id=r:Responsable]/r:Nom"/></td> -->
        <td class="ufcontent"><xsl:value-of select="r:Responsable"/></td>
        <td class="ufcontent"><xsl:value-of select="r:HeuresCM"/></td>
        <td class="ufcontent"><xsl:value-of select="r:HeuresTD"/></td>
        <td class="ufcontent"><xsl:value-of select="r:HeuresTP"/></td>
        <td class="ufcontent"><xsl:value-of select="r:HeuresCM + r:HeuresTD + r:HeuresTP"/></td>
        <!-- <td rowspan="{$countEpreuves}"><xsl:value-of select="r:Coefficient"/></td> -->
        <td class="ufcontent"><xsl:value-of select="r:Coefficient"/></td>
        <!-- <td><xsl:value-of select="r:Épreuves/r:Épreuve/@code"/></td>
        <td><xsl:value-of select="r:Épreuves/r:Épreuve/r:Intitulé"/></td>
        <td><xsl:value-of select="r:Épreuves/r:Épreuve/r:Coefficient"/></td> -->
      <!-- </tr> -->
        <td class="ufcontent">
            <ul>
              <xsl:for-each select="r:Épreuves/r:Épreuve">
                <li><xsl:value-of select="@code"/></li>
              </xsl:for-each>
            </ul>
        </td>
        <td class="ufcontent">
            <ul>
              <xsl:for-each select="r:Épreuves/r:Épreuve">
                <li><xsl:value-of select="r:Intitulé"/></li>
              </xsl:for-each>
            </ul>
        </td>
        <td class="ufcontent">
            <ul>
              <xsl:for-each select="r:Épreuves/r:Épreuve">
                <li><xsl:value-of select="r:Coefficient"/></li>
              </xsl:for-each>
            </ul>
        </td>
      </xsl:element>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="/">
    <html>
      <head>
        <title>Maquette S<xsl:value-of select="r:root/r:Maquette/r:Semestre"/> de la <xsl:value-of select="r:root/r:Maquette/r:Promo"/></title>
        <style>
          table, th, td {
              border: 1px solid black;
              border-collapse: collapse;
          }
          th, td {
              padding: 5px;
              text-align: left;
          }
          th.tablehead{
            background-color:rgb(220,220,220);
          }
          tr.ufhead{
            border: 1px solid black;
            font-weight:bold;
            background-color:rgb(100,240,100);
          }
          /*tr.ufhead:hover{
            border: 3px solid black;
            background-color:rgb(100,240,100);*/
          }
          td.ufcontent{
            display: none;
            background-color:rgb(240,240,240);
          }
        </style>
      </head>
      <body>
        <h2> Maquette S<xsl:value-of select="r:root/r:Maquette/r:Semestre"/> de la <xsl:value-of select="r:root/r:Maquette/r:Promo"/> </h2>
        <!-- <p></p> -->
        <table id="maquette" style="width:100%">
          <tr>
            <th class="tablehead">Type d'UF</th>
            <th class="tablehead" colspan="2">UF</th>
            <th class="tablehead">ECTS</th>
            <th class="tablehead">Répartition des UEs</th>
            <th class="tablehead">Notation</th>
            <th class="tablehead">Responsable</th>
            <th class="tablehead">Heures de CM</th>
            <th class="tablehead">Heures de TD</th>
            <th class="tablehead">Heures de TP</th>
            <th class="tablehead">Total d'heures</th>
            <th class="tablehead">Coefficient</th>
            <th class="tablehead" colspan="3">Epreuves</th>
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
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

        <script>
        $(function() {

            function setDisplayRows(rows, display, idUfMaster) {
                rows.each(function(index, row) {
                    if(row.getAttribute("data-idufmaster") == idUfMaster) { // Si la ligne correspond à la bonne tête, on l'affiche
                        if(display == true) {
                            row.style.display = "table-row";
                        } else {
                            row.style.display = "none";
                        }
                    }
                })
            }

            // Le display:none de la classe .ufcontent ne semble pas marcher, on va cacher manuellement les lignes voulues une fois la page chargée
            $("tr.ufcontent").css("display", "none");

            $("tr.ufhead").click(function(event) {
                var idUfMaster = $(this).attr("id"); // On récupère l'identifiant qu'on a mis dans la ligne de tête
                var rows = $("tr.ufcontent"); // On récupère toutes les lignes ayant la classe .ufcontent
                var currentDisplay = $(this).data("expanded");
                console.log(idUfMaster)
                console.log(currentDisplay)
                setDisplayRows(rows, !currentDisplay, idUfMaster);
                $(this).data("expanded", !currentDisplay);
            });
        });
        </script>
      </body>

    </html>
  </xsl:template>
</xsl:stylesheet>
