

Insert into JEDI.FORMATTYPE
   (IDFORMATTYPE, DESCRIPTION, MIMETYPE, TRANSFORMERCLASSNAME)
 Values
   (1, 'PDF', 'application/pdf', 'it.senato.jedi.transform.impl.PDFTransformer');
Insert into JEDI.FORMATTYPE
   (IDFORMATTYPE, DESCRIPTION, MIMETYPE, TRANSFORMERCLASSNAME)
 Values
   (2, 'RTF', 'application/msword', 'it.senato.jedi.transform.impl.RTFTransformer');
Insert into JEDI.FORMATTYPE
   (IDFORMATTYPE, DESCRIPTION, MIMETYPE, TRANSFORMERCLASSNAME)
 Values
   (3, 'Excel', 'application/vnd.ms-excel', 'it.senato.jedi.transform.impl.ExcelTransformer');
Insert into JEDI.FORMATTYPE
   (IDFORMATTYPE, DESCRIPTION, MIMETYPE, TRANSFORMERCLASSNAME)
 Values
   (4, 'Text', 'application/txt', 'it.senato.jedi.transform.impl.TextTransformer');
Insert into JEDI.FORMATTYPE
   (IDFORMATTYPE, DESCRIPTION, MIMETYPE, TRANSFORMERCLASSNAME)
 Values
   (5, 'XML', 'application/xml', 'it.senato.jedi.transform.impl.XSLTransformer');
Insert into JEDI.FORMATTYPE
   (IDFORMATTYPE, DESCRIPTION, MIMETYPE, TRANSFORMERCLASSNAME)
 Values
   (6, 'HTML', 'text/html', 'it.senato.jedi.transform.impl.XSLTransformer');
COMMIT;


Insert into JEDI.PARAMETERTYPE
   (IDPARAMETERTYPE, DESCRIPTION, CLASSNAME)
 Values
   (1, 'Integer', 'java.lang.Integer');
Insert into JEDI.PARAMETERTYPE
   (IDPARAMETERTYPE, DESCRIPTION, CLASSNAME)
 Values
   (2, 'String', 'java.lang.String');
Insert into JEDI.PARAMETERTYPE
   (IDPARAMETERTYPE, DESCRIPTION, CLASSNAME)
 Values
   (3, 'Date', 'java.sql.Date');
Insert into JEDI.PARAMETERTYPE
   (IDPARAMETERTYPE, DESCRIPTION, CLASSNAME)
 Values
   (4, 'Double', 'java.lang.Double');
Insert into JEDI.PARAMETERTYPE
   (IDPARAMETERTYPE, DESCRIPTION, CLASSNAME)
 Values
   (5, 'Boolean', 'java.lang.Boolean');
Insert into JEDI.PARAMETERTYPE
   (IDPARAMETERTYPE, DESCRIPTION, CLASSNAME)
 Values
   (6, 'Long', 'java.lang.Long');
COMMIT;


Insert into JEDI.REUSABLETRANSFORMER
   (IDREUSABLETRANSFORMER, DESCRIPTION, TRANSFORMER, LASTUSER, TIMEST)
 Values
   (1, 'Identical Transformer', '<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="node()|@*">
      <xsl:copy>
        <xsl:apply-templates select="node()|@*"/>
      </xsl:copy>
    </xsl:template>
</xsl:stylesheet>', 'AP', TO_DATE('07/01/2013 12:42:59', 'MM/DD/YYYY HH24:MI:SS'));
Insert into JEDI.REUSABLETRANSFORMER
   (IDREUSABLETRANSFORMER, DESCRIPTION, TRANSFORMER, LASTUSER, TIMEST)
 Values
   (2, 'Excel Reusable Transformer', '<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
    <xsl:element name="sheet">
      <xsl:attribute name="name">Data</xsl:attribute>

			<row>
        <xsl:for-each select="./*[1]/*[1]/*">
          <string-cell>
              <xsl:attribute name="index" >
                <xsl:value-of select="count(preceding-sibling::*)"/>
              </xsl:attribute>
              <xsl:attribute name="value" >
                <xsl:value-of select="name()"/>
              </xsl:attribute>
            <font name="Calibri" size="11" italic="false" bold="true" bkColor="49"></font>
            <border top="true" bottom="true" right="true" left="false"></border>
          </string-cell>
        </xsl:for-each>
      </row>
      
      <xsl:apply-templates select="//Row"/>

    </xsl:element>

	</xsl:template>

	<xsl:template match="Row">
			<row>
        <xsl:for-each select="./*">
          <xsl:variable name="index" select="count(preceding-sibling::*)"/>
          <xsl:choose>
            <xsl:when test="//*[1]/*[$index+1]/@type=''Integer''">
              <integer-cell>
                  <xsl:attribute name="index" >
                    <xsl:value-of select="$index"/>
                  </xsl:attribute>
                  <xsl:attribute name="value" >
                    <xsl:value-of select="text()"/>
                  </xsl:attribute>
                <font name="Calibri" size="11" italic="false"></font>
                <border top="true" bottom="true" right="true" left="false"></border>
              </integer-cell>
            </xsl:when>
            <xsl:when test="//*[1]/*[$index+1]/@type=''Double''">
              <double-cell>
                  <xsl:attribute name="index" >
                    <xsl:value-of select="$index"/>
                  </xsl:attribute>
                  <xsl:attribute name="value" >
                    <xsl:value-of select="text()"/>
                  </xsl:attribute>
                <font name="Calibri" size="11" italic="false" format="#,##0.00"></font>
                <border top="true" bottom="true" right="true" left="false"></border>
              </double-cell>
            </xsl:when>
            <xsl:when test="//*[1]/*[$index+1]/@type=''Date''">
              <date-cell>
                  <xsl:attribute name="index" >
                    <xsl:value-of select="$index"/>
                  </xsl:attribute>
                  <xsl:attribute name="value" >
                    <xsl:value-of select="text()"/>
                  </xsl:attribute>
                <font name="Calibri" size="11" italic="false" format="dd/mm/yyyy" alignment="center"></font>
                <border top="true" bottom="true" right="true" left="false"></border>
              </date-cell>
            </xsl:when>
            <xsl:otherwise>
              <string-cell>
                  <xsl:attribute name="index" >
                    <xsl:value-of select="$index"/>
                  </xsl:attribute>
                  <xsl:attribute name="value" >
                    <xsl:value-of select="text()"/>
                  </xsl:attribute>
                <font name="Calibri" size="11" italic="false"></font>
                <border top="true" bottom="true" right="true" left="false"></border>
              </string-cell>
            </xsl:otherwise>
          </xsl:choose>  
          
        </xsl:for-each>
			</row>
	</xsl:template>
</xsl:stylesheet>', 'Alberto', TO_DATE('07/02/2013 13:54:25', 'MM/DD/YYYY HH24:MI:SS'));
COMMIT;


Insert into JEDI.XMLSOURCETYPE
   (IDXMLSOURCETYPE, DESCRIPTION, READERCLASSNAME, TYPECLASS)
 Values
   (4, 'SQL Query', 'it.senato.jedi.ejb.xmlsource.impl.XMLJDBCSQLQuery', 4);
Insert into JEDI.XMLSOURCETYPE
   (IDXMLSOURCETYPE, DESCRIPTION, READERCLASSNAME, TYPECLASS)
 Values
   (5, 'Oracle Result Set from procedure', 'it.senato.jedi.ejb.xmlsource.impl.XMLOracleResultSetStoredProcedure', 1);
Insert into JEDI.XMLSOURCETYPE
   (IDXMLSOURCETYPE, DESCRIPTION, READERCLASSNAME, TYPECLASS)
 Values
   (1, 'Oracle XMLTYPE from procedure', 'it.senato.jedi.ejb.xmlsource.impl.XMLOracleStoredProcedure', 1);
Insert into JEDI.XMLSOURCETYPE
   (IDXMLSOURCETYPE, DESCRIPTION, READERCLASSNAME, TYPECLASS)
 Values
   (2, 'Jedi XML Document', 'it.senato.jedi.ejb.xmlsource.impl.JEDIXMLDocumentReader', 2);
Insert into JEDI.XMLSOURCETYPE
   (IDXMLSOURCETYPE, DESCRIPTION, READERCLASSNAME, TYPECLASS)
 Values
   (3, 'URL', 'it.senato.jedi.ejb.xmlsource.impl.UrlXMLDocumentReader', 3);
COMMIT;
