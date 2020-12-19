CREATE OR REPLACE PACKAGE BODY HR.HR_JEDI
AS

    FUNCTION formatDecimal(pDecimal         IN NUMBER
    ,                      pDecimalDigits   IN NUMBER default 2
    ,                      pShowThouSep     IN NUMBER default 1 
    ) RETURN VARCHAR2
    IS
        decimals           VARCHAR2(100);
        format             VARCHAR2(100) := '999G999G999G990';
    BEGIN
        if pShowThouSep = 0 then
            format := replace(format, 'G', '');
        end if;

        if pDecimalDigits > 0 then
            decimals := rpad('D', pDecimalDigits+1, '9');
        end if;

        RETURN TRIM(TO_CHAR(pDecimal, format || decimals));

    END;


    FUNCTION convertData(p_input IN SYS_REFCURSOR
    ,                    p_setName IN VARCHAR2
    ,                    p_rowName IN VARCHAR2) return xmltype
    IS
        v_handle                 dbms_xmlgen.ctxHandle;
        xml                      XMLTYPE;
    BEGIN
    
        -- If the ref cursor is not empty 
        IF p_input IS NOT NULL THEN
    
            -- Get a handle to the XML document 
            v_handle := dbms_xmlgen.newcontext( p_input );
  
            -- Replace the default ROWSET tag with my own  
            dbms_xmlgen.SetRowSetTag(v_handle, p_setName);

            -- Remove the default ROW level tag with my own
            -- If I passed in text instead of NULL I would just change the element name
            -- I can leave it off altogther and get the default, canonical format  
            dbms_xmlgen.SetRowTag(v_handle, nvl(p_rowName,'row'));

            -- Display null tags for empty columns 
            dbms_xmlgen.SetNullHandling(v_handle, dbms_xmlgen.EMPTY_TAG);
  
            -- Create an XML document out of the ref cursor 
            xml := dbms_xmlgen.getXMLType( v_handle );
        else
            return null;
        END IF;
        close p_input;
        return xml;

    END;


    FUNCTION EmployeesSelect(pSurname             IN VARCHAR2
             ) 
	RETURN GenericCursor
    IS
        mycursor                       GenericCursor;

    BEGIN

        OPEN mycursor
        FOR
			select a.*
			,      a.hire_date as hire_date_time
			from   hr.employees a
			where  lower(last_name) like '%' || lower(pSurname) || '%'
			order by last_name
			,        first_name
			;

        RETURN mycursor;
    END;

    FUNCTION EmployeesSelectXML(pSurname          IN VARCHAR2
             ) RETURN XMLTYPE
	IS
		mycursor                       GenericCursor;
	BEGIN
		mycursor := EmployeesSelect(pSurname);
        return convertData(mycursor, 'Results', 'Row');
	END;			 

    FUNCTION EmployeesSelectSQLX(pSurname          IN VARCHAR2
             ) RETURN XMLTYPE
    IS
            xml XMLTYPE;
            lCount NUMBER;
    BEGIN
        --check if exists some matching record
        SELECT  COUNT(*)
        INTO    lCount
        FROM    hr.employees a
		where   lower(last_name) like '%' || lower(pSurname) || '%'
        ;

        IF lCount = 0 THEN
            RAISE_APPLICATION_ERROR (-20200, '<b>No employee found matching surname ' || pSurname ||  ' </b>');
        END IF;

        SELECT  sys_xmlgen(
					XMLFOREST(
						TO_CHAR(trunc(sysdate), 'DD/MM/YYYY') AS "today"
					,   pSurname "surname"   
					,   (
							SELECT count(*)
							from   hr.employees a
							where  lower(last_name) like '%' || lower(pSurname) || '%'
						) AS "count"
					,   (
							SELECT  xmlAgg(
										XMLELEMENT("employee",
											XMLFOREST(
												FIRST_NAME AS "firstName"
											,   LAST_NAME AS "lastName"
                                            ,   formatDecimal(SALARY) AS "salary"
                                            ,   PHONE_NUMBER AS "phoneNumber"
    										,   to_char(hire_date, 'DD/MM/YYYY') AS "hireDate"
											)
										)
									)
							FROM    (
										select  A.FIRST_NAME
										,       A.LAST_NAME
										,       A.SALARY
										,       A.PHONE_NUMBER
										,       a.hire_date
										from    hr.employees a
										where   lower(last_name) like '%' || lower(pSurname) || '%'
										order by last_name
										,        first_name
										,        1
									) a
						) AS "employees"
					)
				,  xmlformat('root')
				) as xml
        INTO    xml
        FROM    dual;

        RETURN xml;

	END;             

END;
/

GRANT EXECUTE ON HR.HR_JEDI TO JEDI
/
