CREATE VIEW VW_FECHAS AS
	SELECT 
		MIN(DE.FechaEnfrentamiento) AS INICIO,
		MAX(DE.FechaEnfrentamiento) AS FINAL,
		T.NombreTorneo AS TORNEO,
		E.NombreEtapa AS ETAPA,
		F.NumeroFecha AS FECHA
	FROM FICHA_PROGRAMACIÓN FP
		INNER JOIN ETAPA E ON FP.IdEtapa = E.IdEtapa
		INNER JOIN TORNEO T ON FP.IdTorneo = T.IdTorneo
		INNER JOIN FECHA F ON FP.IdFecha = F.IdFecha
		INNER JOIN TORNEO_ETAPA TE ON FP.IdEtapa = TE.IdEtapa AND FP.IdTorneo = TE.IdTorneo
		INNER JOIN DETALLE_ENFRENTAMIENTO DE ON DE.IdTorneo = FP.IdTorneo AND DE.IdEtapa = FP.IdEtapa AND DE.IdFecha = FP.IdFecha
	GROUP BY 
		TE.FechaInicio,
		TE.FechaFinal,
		T.NombreTorneo,
		E.NombreEtapa,
		F.NumeroFecha
GO
