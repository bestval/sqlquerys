-- =====================================================================
-- Script: list-tables-with-amount-column-and-rows.sql
-- Descripción: Lista las tablas del esquema actual que tienen más de 10 
-- registros y contienen una columna llamada 'Amount'.
-- Fecha: 2025-04-05
-- Autor: Brian Estevez
-- =====================================================================

DECLARE cursorRow CURSOR FOR
    SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'

DECLARE @tableName nvarchar(100)
DECLARE @query nvarchar(max)

IF OBJECT_ID('tempdb..#tables') IS NOT NULL
    DROP TABLE #tables

CREATE TABLE #tables(tablename varchar(100))

OPEN cursorRow

FETCH NEXT FROM cursorRow INTO @tableName

DECLARE @count INT
DECLARE @columnExists INT -- Variable para verificar la existencia de la columna

WHILE (@@FETCH_STATUS = 0)
BEGIN
    SET @query = N'SELECT @count = COUNT(*) FROM [' + @tableName + '] WHERE ''Amount'' IN (SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @tableName AND COLUMN_NAME = ''Amount'')'

    EXEC sp_executesql @query, N'@count int out, @tableName nvarchar(100)', @count out, @tableName

    IF(@count > 10)
    BEGIN
        -- Verificar si la columna 'Amount' existe en la tabla actual
        SET @query = N'SELECT @columnExists = COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @tableName AND COLUMN_NAME = ''Amount'''

        EXEC sp_executesql @query, N'@columnExists int out, @tableName nvarchar(100)', @columnExists out, @tableName

        IF @columnExists > 0
        BEGIN
            INSERT INTO #tables (tablename) VALUES (@tableName)
        END
    END

    FETCH NEXT FROM cursorRow INTO @tableName
END

SELECT * FROM #tables ORDER BY tableName

DROP TABLE #tables

CLOSE cursorRow
DEALLOCATE cursorRow
