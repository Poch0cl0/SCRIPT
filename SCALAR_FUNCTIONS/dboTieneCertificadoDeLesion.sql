
CREATE FUNCTION dbo.TieneCertificadoDeLesion
(
    @CodigoIdentificacion varchar(20),
    @IdTipoIdenticacion int
)
RETURNS varchar(50)
AS
BEGIN
    DECLARE @Resultado varchar(50);
    
    IF EXISTS (
        SELECT 1
        FROM CERTIFICADO_LESION cl
        INNER JOIN CERTIFICADO_MEDICO cm
        ON cl.IdCertificadoMedico = cm.IdCertificadoMedico
        WHERE cl.CodigoIdentificacion = @CodigoIdentificacion
        AND cl.IdTipoIdenticacion = @IdTipoIdenticacion
    )
    BEGIN
        SET @Resultado = 'Sí tiene certificado de lesión';
    END
    ELSE
    BEGIN
        SET @Resultado = 'No tiene certificado de lesión';
    END

    RETURN @Resultado;
END;
GO

SELECT dbo.TieneCertificadoDeLesion('99999999', 1) AS Resultado;