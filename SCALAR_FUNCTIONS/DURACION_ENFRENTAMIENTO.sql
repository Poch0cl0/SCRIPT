CREATE FUNCTION dbo.fn_CalcularDuracionEnfrentamiento
(
    @FechaInicio DATETIME,
    @FechaFinal DATETIME
)
RETURNS INT
AS
BEGIN
    DECLARE @DuracionMinutos INT;

    SET @DuracionMinutos = DATEDIFF(MINUTE, @FechaInicio, @FechaFinal);

    RETURN @DuracionMinutos;
END
GO
