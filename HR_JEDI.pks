CREATE OR REPLACE PACKAGE HR.HR_JEDI IS

	TYPE GenericCursor IS REF CURSOR;

    FUNCTION formatDecimal(pDecimal         IN NUMBER
    ,                      pDecimalDigits   IN NUMBER default 2
    ,                      pShowThouSep     IN NUMBER default 1 
    ) RETURN VARCHAR2; 

    /**
        Converts a cursor into an xmltype.
    **/
	FUNCTION convertData(p_input IN SYS_REFCURSOR
	,                    p_setName IN VARCHAR2
	,                    p_rowName IN VARCHAR2) return xmltype;

	FUNCTION EmployeesSelect(pSurname             IN VARCHAR2
			 ) RETURN GenericCursor;

    FUNCTION EmployeesSelectXML(pSurname          IN VARCHAR2
             ) RETURN XMLTYPE;

    FUNCTION EmployeesSelectSQLX(pSurname          IN VARCHAR2
             ) RETURN XMLTYPE;
    
END;
/

GRANT EXECUTE ON HR.HR_JEDI TO JEDI
/
