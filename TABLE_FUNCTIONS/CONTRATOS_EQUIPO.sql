
CREATE FUNCTION dbo.fn_ContratosPorEquipo(@IdClub INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        C.IdContrato,
        C.CodigoIdentificacion,
        J.NombreJugador,
        C.FechaInicio,
        C.FechaFinal
    FROM 
        CONTRATO C
    INNER JOIN 
        JUGADOR J ON C.CodigoIdentificacion = J.CodigoIdentificacion
    WHERE 
        C.IdClub = @IdClub
);

