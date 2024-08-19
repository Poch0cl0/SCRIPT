
ALTER TABLE USUARIO
	ADD
		Constraint D_NombreUsuario
			default('USER0000') for NombreUsuario
GO
