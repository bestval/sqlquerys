DECLARE @searchValue NVARCHAR(100) = 'X';

IF OBJECT_ID('tempdb..#results') IS NOT NULL
    DROP TABLE #results;

CREATE TABLE #results (
    TableName NVARCHAR(100),
    ColumnName NVARCHAR(100)
);

DECLARE @sql NVARCHAR(MAX) = '';

SELECT @sql = @sql +
    'IF EXISTS (SELECT 1 FROM ' + TABLE_SCHEMA + '.' + TABLE_NAME +
    ' WHERE [' + COLUMN_NAME + '] = @searchValue) ' +
    'INSERT INTO #results (TableName, ColumnName) VALUES (''' + TABLE_NAME + ''', ''' + COLUMN_NAME + '''); '
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbo'
AND DATA_TYPE IN ('nvarchar', 'varchar', 'char', 'nchar');

EXEC sp_executesql @sql, N'@searchValue NVARCHAR(100)', @searchValue;

SELECT * FROM #results;

DROP TABLE #results;
