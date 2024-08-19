

CREATE FUNCTION dbo.fn_DuracionContrato (
    @IdContrato INT
)
RETURNS INT
AS
BEGIN
    DECLARE @DuracionEnMeses INT;
    SELECT @DuracionEnMeses = DATEDIFF(MONTH, FechaInicio, FechaFinal)
    FROM CONTRATO
    WHERE IdContrato = @IdContrato;

    RETURN @DuracionEnMeses;
END;


