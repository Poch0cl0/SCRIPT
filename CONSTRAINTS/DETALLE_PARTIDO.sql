-- RESTRICCIONES DETALLE_ENFRENTAMIENTO --
ALTER TABLE DETALLE_ENFRENTAMIENTO
ADD CONSTRAINT CHK_FechaEnfrentamiento_Range_DETALLE_ENFRENTAMIENTO CHECK (FechaEnfrentamiento >= '1912-01-01');