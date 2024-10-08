-- RESTRICCIONES ARBITRO --
ALTER TABLE ARBITRO
ADD CONSTRAINT CHK_NombreArbitro_Length_ARBITRO CHECK (LEN(NombreArbitro) >= 3 AND LEN(NombreArbitro) <= 50);

ALTER TABLE ARBITRO
ADD CONSTRAINT CHK_IdTipoArbitro_Range_ARBITRO CHECK (IdTipoArbitro BETWEEN 1 AND 5);

ALTER TABLE ARBITRO
ADD CONSTRAINT CHK_IdTipoIdenticacion_Range_ARBITRO CHECK (IdTipoIdenticacion BETWEEN 0 AND 10);