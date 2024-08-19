CREATE FUNCTION dbo.fn_ContratosActivos()
RETURNS TABLE
AS
RETURN
(
    SELECT IdContrato, FechaInicio, FechaFinal, CodigoIdentificacion, IdTipoIdenticacion, IdClub
    FROM CONTRATO
    WHERE FechaFinal >= GETDATE()
)
