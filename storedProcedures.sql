
DROP PROCEDURE IF EXISTS 
stats_build_crosstable;
/*
The characters for the stored procedure are special for dbVisualizer.
This an example of the usual sintax, changing the delimiter.
    DELIMITER //
    CREATE PROCEDURE GetOfficeByCountry(IN countryName VARCHAR(255))
     BEGIN
     SELECT * 
     FROM offices
     WHERE country = countryName;
     END //
    DELIMITER ;
*/
--/
CREATE PROCEDURE 
stats_build_crosstable
(
IN rowField VARCHAR(1000),
IN toColumnValueField VARCHAR(1000),
IN srcTable VARCHAR(2000),
IN ifValueReturn VARCHAR(1000),
IN ifResultOperation VARCHAR(1000),
IN calcSyntax VARCHAR(100),
IN returnField VARCHAR(100),
IN filter_query VARCHAR(400),
IN groupByFields VARCHAR(1000),
IN orderByFields VARCHAR(1000)
)
BEGIN
	  SET SESSION group_concat_max_len = 1000000;
	  SET @sql = NULL;
	  SET @SUBSQL= CONCAT("SELECT GROUP_CONCAT(SUM_FIELD) into @sql from (SELECT DISTINCT CONCAT('",ifResultOperation,"(IF(", toColumnValueField," = ''',", toColumnValueField, ",''', ",ifValueReturn,",0)) AS ''',", toColumnValueField, ",'''') SUM_FIELD FROM ",srcTable,filter_query," ORDER BY ",toColumnValueField,") A;");
	  /*SELECT @SUBSQL;*/
	  PREPARE stmt FROM @SUBSQL;
	  EXECUTE stmt;
	  DEALLOCATE PREPARE stmt;
	  /*SELECT @sql;*/
	  SET @sql = CONCAT('SELECT ',rowField, @sql,',', calcSyntax,'(',returnField,') as TOTAL ', 'FROM ',srcTable,filter_query,groupByFields,orderByFields);  
	  /*SELECT @sql;*/
	  PREPARE stmt FROM @sql; 
	  EXECUTE stmt;
	  DEALLOCATE PREPARE stmt;
END;
/


call stats__build_crosstable(
'RncName,UARFCNDL,',/*rowField*/
'Causes',/*toColumnValueField*/
'fp_report_el_root_causes',/*srcTable*/
'1',/*ifValueReturn*/
'SUM',/*ifResultOperation*/
'count',/*calcSyntax*/
'*',/*returnField*/
'',/*filter_query*/
' GROUP BY RncName,UARFCNDL',/*groupByFields*/
''/*orderByFields*/);

call stats__build_crosstable(
'RNC,uarfcnDl,',/*rowField*/
'loadSharingGsmThreshold ',/*toColumnValueField*/
'a_cell_pivot',/*srcTable*/
'1',/*ifValueReturn*/
'SUM',/*ifResultOperation*/
'count',/*calcSyntax*/
'*',/*returnField*/
'',/*filter_query*/
' GROUP BY RNC,uarfcnDl',/*groupByFields*/
''/*orderByFields*/);
call stats_build_crosstable(
'RNC,uarfcnDl,',/*rowField*/
'loadSharingGsmThreshold ',/*toColumnValueField*/
'a_cell_pivot',/*srcTable*/
'1',/*ifValueReturn*/
'SUM',/*ifResultOperation*/
'count',/*calcSyntax*/
'*',/*returnField*/
'',/*filter_query*/
' GROUP BY RNC,uarfcnDl',/*groupByFields*/
''/*orderByFields*/);
