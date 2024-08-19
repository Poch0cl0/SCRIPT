
ALTER TABLE JUGADOR
ADD
		Constraint D_NombreJugador
			default('NNNNNNNNN') for NombreJugador,
		Constraint D_ApellidoJugador
			default('AAAAAAAAA') for ApellidoJugador,
		Constraint D_FechaNacimiento
			default('0000-00-00T00:00:00') for FechaNacimiento,
		Constraint D_NacionalidadJugador
			default('NSNSNNSSNNSN') for NacionalidadJugador
GO

