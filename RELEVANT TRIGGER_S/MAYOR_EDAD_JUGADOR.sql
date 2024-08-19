CREATE TRIGGER trg_check_edad
ON JUGADOR
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @FechaNacimiento DATE;
    DECLARE @Edad INT;

    SELECT @FechaNacimiento = FechaNacimiento FROM inserted;

    SET @Edad = DATEDIFF(YEAR, @FechaNacimiento, GETDATE());

    IF @Edad < 18
    BEGIN
        RAISERROR('El jugador debe tener al menos 18 años.', 16, 1);
    END
    ELSE
    BEGIN
        INSERT INTO jugadores(NombreJugador, ApellidoJugador, FechaNacimiento, NacionalidadJugador, CodigoIdentificacion, IdTipoIdenticacion)
        SELECT NombreJugador, ApellidoJugador, FechaNacimiento, NacionalidadJugador, CodigoIdentificacion, IdTipoIdenticacion FROM inserted;
    END
END;
