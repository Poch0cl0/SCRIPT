CREATE TRIGGER trg_ValidarEnfrentamiento
ON DETALLE_ENFRENTAMIENTO
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @IdClubLocal INT, @IdClubVisitante INT, @IdTorneo INT, @IdEtapa INT;

    -- obteniene los datos del enfrentamiento insertado o actualizado
    SELECT @IdClubLocal = IdClubLocal,
           @IdClubVisitante = IdClubVisitante,
           @IdTorneo = IdTorneo,
           @IdEtapa = IdEtapa
    FROM inserted;

    -- verifica si ambos clubes están admitidos en el torneo y etapa
    IF NOT EXISTS (
        SELECT 1 
        FROM REPORTE_ADMISION
        WHERE IdClub = @IdClubLocal AND IdTorneo = @IdTorneo AND IdEtapa = @IdEtapa
    ) OR NOT EXISTS (
        SELECT 1 
        FROM REPORTE_ADMISION
        WHERE IdClub = @IdClubVisitante AND IdTorneo = @IdTorneo AND IdEtapa = @IdEtapa
    )
    BEGIN
        THROW 50001, 'Uno o ambos clubes no están admitidos en este torneo y etapa.', 1;
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- verifica que no sea un enfrentamiento entre el mismo club
    IF @IdClubLocal = @IdClubVisitante
    BEGIN
        THROW 50002, 'Un club no puede enfrentarse a sí mismo.', 1;
        ROLLBACK TRANSACTION;
        RETURN;
    END

    -- verifica que no exista ya un enfrentamiento entre estos clubes en la misma fecha
    IF EXISTS (
        SELECT 1
        FROM DETALLE_ENFRENTAMIENTO
        WHERE IdTorneo = @IdTorneo
          AND IdEtapa = @IdEtapa
          AND IdFecha = (SELECT IdFecha FROM inserted)
          AND ((IdClubLocal = @IdClubLocal AND IdClubVisitante = @IdClubVisitante)
               OR (IdClubLocal = @IdClubVisitante AND IdClubVisitante = @IdClubLocal))
          AND IdClubLocal != (SELECT IdClubLocal FROM inserted)  -- Excluir el registro actual en caso de UPDATE
    )
    BEGIN
        THROW 50003, 'Ya existe un enfrentamiento entre estos clubes en la misma fecha.', 1;
        ROLLBACK TRANSACTION;
        RETURN;
    END

    PRINT 'Enfrentamiento validado y registrado correctamente.';
END;