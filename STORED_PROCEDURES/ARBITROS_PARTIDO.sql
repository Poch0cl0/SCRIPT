CREATE PROCEDURE REVISAR_FICHA_PROGRAMACION
    @IdTorneo INT = 1,
	@IdEtapa INT = 1,
	@IdFecha INT = 1,
	@ClubVisitante INT = 1,
	@ClubLocal INT = 1
AS
BEGIN
	SELECT 
		A.NombreArbitro AS NOMBRE,
		A.CodigoIdentificacion AS IDENTIFICACION,
		A.IdTipoIdenticacion AS TIPO_IDENTIFICACION,
		A.IdTipoArbitro AS TIPO
	FROM DETALLE_ENFRENTAMIENTO DE
		INNER JOIN E_ARBITRAJE_ARBITRO EAA ON DE.IdEquipoArbitraje = EAA.IdEquipoArbitraje
		INNER JOIN ARBITRO A ON A.IdArbitro = EAA.IdArbitro
	WHERE
		DE.IdEtapa = @IdEtapa AND DE.IdTorneo = @IdTorneo AND DE.IdFecha = @IdFecha AND DE.IdClubLocal = @ClubLocal AND DE.IdClubVisitante = @ClubVisitante
END;