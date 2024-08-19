
CREATE TRIGGER trg_InsteadOfDeleteJugador
ON JUGADOR
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM CONTRATO C WHERE C.CodigoIdentificacion = (SELECT CodigoIdentificacion FROM DELETED))
    BEGIN
        RAISERROR ('No se puede eliminar un jugador con un contrato vigente.', 16, 1);
    END
    ELSE
    BEGIN
        DELETE FROM JUGADOR WHERE CodigoIdentificacion IN (SELECT CodigoIdentificacion FROM DELETED);
    END
END;


