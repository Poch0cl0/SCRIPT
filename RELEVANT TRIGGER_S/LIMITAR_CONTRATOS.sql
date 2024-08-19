CREATE TRIGGER trg_limitar_contratos_activos
ON CONTRATO
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @IdClub INT, @NumContratosActivos INT;

    SELECT @IdClub = IdClub FROM inserted;

    SELECT @NumContratosActivos = COUNT(*)
    FROM CONTRATO
    WHERE IdClub = @IdClub AND FechaFinal IS NULL;

    IF @NumContratosActivos >= 30
    BEGIN
        RAISERROR('No se pueden registrar más de 30 contratos activos en un club.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END

    INSERT INTO CONTRATO (IdContrato, FechaInicio, FechaFinal, IdEstado, CodigoIdentificacion, IdTipoIdenticacion, IdClub)
    SELECT IdContrato, FechaInicio, FechaFinal, IdEstado, CodigoIdentificacion, IdTipoIdenticacion, IdClub
    FROM inserted;
END
GO