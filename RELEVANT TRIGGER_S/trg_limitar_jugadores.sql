CREATE TRIGGER trg_limitar_jugadores
ON JUGADOR_CLUB
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @IdClub INT, @NumExtranjeros INT, @NumJugadores INT;

    SELECT @IdClub = IdClub FROM inserted;

    SELECT @NumExtranjeros = COUNT(*)
    FROM JUGADOR_CLUB JC
    JOIN JUGADOR J ON JC.CodigoIdentificacion = J.CodigoIdentificacion AND JC.IdTipoIdenticacion = J.IdTipoIdenticacion
    WHERE JC.IdClub = @IdClub AND J.IdTipoIdenticacion = 2;

    SELECT @NumJugadores = COUNT(*)
    FROM JUGADOR_CLUB
    WHERE IdClub = @IdClub;

    IF EXISTS (SELECT 1 FROM inserted i JOIN JUGADOR j ON i.CodigoIdentificacion = j.CodigoIdentificacion AND i.IdTipoIdenticacion = j.IdTipoIdenticacion WHERE j.IdTipoIdenticacion = 2)
    BEGIN
        IF @NumExtranjeros >= 6
        BEGIN
            RAISERROR('No se pueden registrar más de 6 jugadores extranjeros en un club.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END
    END

    IF @NumJugadores >= 25
    BEGIN
        RAISERROR('No se pueden registrar más de 25 jugadores en un club.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    INSERT INTO JUGADOR_CLUB (CodigoIdentificacion, IdTipoIdenticacion, IdClub)
    SELECT CodigoIdentificacion, IdTipoIdenticacion, IdClub
    FROM inserted;
END
GO