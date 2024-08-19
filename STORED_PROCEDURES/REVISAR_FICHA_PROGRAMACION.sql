CREATE PROCEDURE REVISAR_FICHA_PROGRAMACION
    @IdTorneo INT = 1,
	@IdEtapa INT = 1,
	@IdFecha INT = 1,
	@IdUsuario INT = 1
AS
BEGIN
	SELECT 
		DE.FechaEnfrentamiento AS FECHA,
		DE.HoraEnfrentamiento AS HORA,
		E.NombreEstadio AS ESTADIO,
		E.UbicaciónEstadio AS UBICACION,
		DP.NombreDelegadoPartido + DP.ApellidoDelegadoPartido AS DELEGADO_PARTIDO,
		CV.NombreClub AS CLUB_VISITANTE,
		CL.NombreClub AS CLUB_LOCAL
	FROM DETALLE_ENFRENTAMIENTO DE
		INNER JOIN CLUB CL ON DE.IdClubLocal = CL.IdClub
		INNER JOIN CLUB CV ON DE.IdClubVisitante = CV.IdClub
		INNER JOIN ESTADIO E ON DE.IdEstadio = E.IdEstadio
		INNER JOIN DELEGADO_PARTIDO DP ON DE.CodigoIdentificacion = DP.CodigoIdentificacion AND DE.IdTipoIdenticacion = DP.IdTipoIdenticacion
		INNER JOIN E_ARBITRAJE_ARBITRO EAA ON DE.IdEquipoArbitraje = EAA.IdEquipoArbitraje
	WHERE
		DE.IdEtapa = @IdEtapa AND DE.IdTorneo = @IdTorneo AND DE.IdFecha = @IdFecha

	INSERT INTO OPERACION_FICHAPROGRAMACION(IdEtapa, IdTorneo, IdFecha, IdUsuario, FechaEmisión)
    VALUES (@IdEtapa, @IdTorneo, @IdFecha, @IdUsuario, GETDATE());
END;