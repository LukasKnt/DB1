-- Aufgabe 3
CREATE INDEX idx_hoeren_matrnr ON hoeren (MatrNr);
CREATE INDEX idx_hoeren_vorlnr ON hoeren (VorlNr);
CREATE INDEX idx_studenten_name ON Studenten (Name);

EXPLAIN ANALYSE
SELECT DISTINCT s.Name
FROM Studenten s
JOIN hoeren h1 ON s.MatrNr = h1.MatrNr
JOIN hoeren h2 ON h1.VorlNr = h2.VorlNr
JOIN Studenten schopenhauer ON h2.MatrNr = schopenhauer.MatrNr
WHERE schopenhauer.Name = 'Schopenhauer' AND s.Name != 'Schopenhauer';