CREATE FUNCTION dbo.fn_HistorialLesionesJugador
(
    @CodigoIdentificacion VARCHAR(20),
    @IdTipoIdenticacion INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        j.CodigoIdentificacion,
        j.IdTipoIdenticacion,
        cl.IdLesion,
        l.DetalleLesion,
        cm.IdCertificadoMedico,
        cm.FechaDeEmision,
        cm.IdEstado
    FROM
        JUGADOR j
    JOIN
        CERTIFICADO_LESION cl ON j.CodigoIdentificacion = cl.CodigoIdentificacion
                             AND j.IdTipoIdenticacion = cl.IdTipoIdenticacion
    JOIN
        LESION l ON cl.IdLesion = l.IdLesion
    JOIN
        CERTIFICADO_MEDICO cm ON cl.IdCertificadoMedico = cm.IdCertificadoMedico
    WHERE
        j.CodigoIdentificacion = @CodigoIdentificacion
        AND j.IdTipoIdenticacion = @IdTipoIdenticacion
);
GO