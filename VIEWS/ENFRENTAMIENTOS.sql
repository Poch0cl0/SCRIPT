CREATE VIEW vw_Enfrentamientos AS
SELECT
    DE.FechaEnfrentamiento,
    DE.HoraEnfrentamiento,
    T.NombreTorneo,
    E.NombreEtapa,
    CL.NombreClub AS ClubLocal,
    CV.NombreClub AS ClubVisitante,
    ES.NombreEstadio
FROM 
    DETALLE_ENFRENTAMIENTO DE
    INNER JOIN FICHA_PROGRAMACIÓN FP ON DE.IdEtapa = FP.IdEtapa AND DE.IdTorneo = FP.IdTorneo AND DE.IdFecha = FP.IdFecha
    INNER JOIN TORNEO T ON FP.IdTorneo = T.IdTorneo
    INNER JOIN ETAPA E ON FP.IdEtapa = E.IdEtapa
    INNER JOIN CLUB CL ON DE.IdClubLocal = CL.IdClub
    INNER JOIN CLUB CV ON DE.IdClubVisitante = CV.IdClub
    INNER JOIN ESTADIO ES ON DE.IdEstadio = ES.IdEstadio
GO