CREATE PROCEDURE REVISAR_REPORTE_ADMISION
    @IdTorneo INT = 1,
	@IdEtapa INT = 1,
	@IdUsuario INT = 1,
	@IdClub INT = 1
AS
BEGIN
	SELECT 
		C.NombreClub AS CLUB,
		J.NombreJugador + ' ' + J.ApellidoJugador AS JUGADOR,
		J.CodigoIdentificacion AS IDENTIFICACION_JUGADOR,
		J.IdTipoIdenticacion AS TIPO_IDENTIFICACION_JUGADOR,
		CM.FechaDeEmision AS FECHA_CERTIFICADO,
		CM.IdEstado AS ESTADO_CERTIFICADO,
		CN.FechaInicio AS INICIO_CONTRATO,
		CN.FechaFinal AS FINAL_CONTRATO,
		CN.IdEstado AS ESTADO_CONTRATO
	FROM DETALLE_SOLICITUD DS
		INNER JOIN CLUB C ON DS.IdClub = C.IdClub
		INNER JOIN JUGADOR J ON J.CodigoIdentificacion = DS.CodigoIdentificacion AND DS.IdTipoIdenticacion = J.IdTipoIdenticacion
		INNER JOIN 	SOLICITUD S ON DS.IdSolicitud = S.IdSolicitud
		INNER JOIN CERTIFICADO_MEDICO CM ON DS.IdCertificadoMedico = CM.IdCertificadoMedico
		INNER JOIN ESTADOS E ON E.IdEstado = CM.IdEstado
		INNER JOIN CONTRATO CN ON CN.CodigoIdentificacion = J.CodigoIdentificacion AND CN.IdTipoIdenticacion = J.IdTipoIdenticacion
		INNER JOIN ESTADOS ES ON CN.IdEstado = ES.IdEstado AND CN.IdEstado = ES.IdEstado
	WHERE
		DS.IdEtapa = @IdEtapa AND DS.IdTorneo = @IdTorneo 

	INSERT INTO OPERACION_REPORTE_ADMISION(IdEtapa, IdTorneo, IdClub, IdUsuario, FechaAdmision)
    VALUES (@IdEtapa, @IdTorneo, @IdClub, @IdUsuario, GETDATE());
END;
GO

