use PRESENTACION_FINAL
go

select*from JUGADOR

CREATE FUNCTION fn_calcular_edad(@FechaNacimiento DATE)
RETURNS INT
AS
BEGIN
	RETURN DATEDIFF(YEAR,@FechaNacimiento,GETDATE())-
		CASE WHEN MONTH(GETDATE()) < MONTH(@FechaNacimiento) OR
			(MONTH(GETDATE())) = MONTH(@FechaNacimiento) AND DAY(GETDATE()) < DAY(@FechaNacimiento)
			THEN 1 ELSE 0 END;
END;

SELECT dbo.fn_calcular_edad('1995-03-15') AS Edad;