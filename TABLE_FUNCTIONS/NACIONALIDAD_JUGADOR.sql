CREATE FUNCTION fn_jugadores_por_nacionalidad(@NacionalidadJugador NVARCHAR(50))
RETURNS TABLE
AS
RETURN(
	SELECT
		NombreJugador,
		ApellidoJugador,
		FechaNacimiento,
		CodigoIdentificacion,
		NacionalidadJugador
	FROM JUGADOR
	WHERE NacionalidadJugador = @NacionalidadJugador
);


SELECT * FROM fn_jugadores_por_nacionalidad('Peruano') ORDER BY NombreJugador ASC, ApellidoJugador ASC;