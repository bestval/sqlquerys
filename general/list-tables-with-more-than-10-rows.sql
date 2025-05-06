-- =====================================================================
-- Script: list-tables-with-more-than-10-rows.sql
-- Descripción: Lista todas las tablas del esquema actual que contienen
-- más de 10 registros.
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

WHILE (@@FETCH_STATUS = 0)
BEGIN
    SET @query = CONCAT(N'SELECT @count = COUNT(*) FROM [', @tableName, ']')

    exec sp_executesql @query, N'@count int out', @count out

    IF(@count > 10)
    BEGIN
        INSERT INTO #tables (tablename) VALUES (@tableName)
    END

    FETCH NEXT FROM cursorRow INTO @tableName
END

SELECT * FROM #tables ORDER BY tableName

DROP TABLE #tables

CLOSE cursorRow
DEALLOCATE cursorRow
