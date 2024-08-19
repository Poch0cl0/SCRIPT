CREATE FUNCTION dbo.ObtenerEstadosDeCertificados()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        cl.IdCertificadoMedico,
        j.CodigoIdentificacion,
        j.NombreJugador + ' ' + j.ApellidoJugador AS NombreCompleto,
        em.NombreEstado AS EstadoCertificado
    FROM 
        CERTIFICADO_MEDICO cm
    INNER JOIN 
        CERTIFICADO_LESION cl
        ON cm.IdCertificadoMedico = cl.IdCertificadoMedico
        AND cm.CodigoIdentificacion = cl.CodigoIdentificacion
        AND cm.IdTipoIdenticacion = cl.IdTipoIdenticacion
    INNER JOIN 
        JUGADOR j
        ON cm.CodigoIdentificacion = j.CodigoIdentificacion
        AND cm.IdTipoIdenticacion = j.IdTipoIdenticacion
    INNER JOIN 
        ESTADOS em
        ON cm.IdEstado = em.IdEstado
);
GO

SELECT * FROM dbo.ObtenerEstadosDeCertificados();
GO
