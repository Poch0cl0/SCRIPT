CREATE VIEW VW_JUGADORES_POR_CLUB AS
	SELECT 
		c.NombreClub,
		j.NombreJugador,
		j.ApellidoJugador,
		j.NacionalidadJugador,
		con.FechaInicio AS InicioContrato,
		con.FechaFinal AS FinContrato
	FROM CLUB c
	JOIN CONTRATO con ON c.IdClub = con.IdClub
	JOIN JUGADOR j ON con.CodigoIdentificacion = j.CodigoIdentificacion 
		AND con.IdTipoIdenticacion = j.IdTipoIdenticacion
	WHERE con.IdEstado = (SELECT IdEstado FROM ESTADOS WHERE NombreEstado = 'APROBADO');
GO

