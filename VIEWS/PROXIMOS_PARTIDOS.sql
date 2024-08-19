
CREATE VIEW VW_PROXIMOS_PARTIDOS AS
SELECT 
    DP.FechaEnfrentamiento,
    DP.HoraEnfrentamiento,
    T.NombreTorneo,
    CL.NombreClub AS ClubLocal,
    cv.NombreClub AS ClubVisitante,
    E.NombreEstadio,
    E.UbicaciónEstadio
FROM DETALLE_ENFRENTAMIENTO DP
JOIN TORNEO T ON DP.IdTorneo = T.IdTorneo
JOIN CLUB CL ON DP.IdClubLocal = CL.IdClub
JOIN CLUB cv ON DP.IdClubVisitante = cv.IdClub
JOIN ESTADIO E ON DP.IdEstadio = E.IdEstadio
WHERE DP.FechaEnfrentamiento >= GETDATE()
GO