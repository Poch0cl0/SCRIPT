
ALTER TABLE REPRESENTANTE_CLUB
ADD
		Constraint D_NombreRepresentanteClub
			default('NNNNNNNNN') for NombreRepresentanteClub,
		Constraint D_ApellidoRepresentanteClub
			default('AAAAAAAAA') for ApellidoRepresentanteClub
GO