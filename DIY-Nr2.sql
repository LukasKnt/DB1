-- Nr.2.1
SELECT hoeren.MatrNr
FROM hoeren
WHERE hoeren.VorlNr = (SELECT Vorlesungen.VorlNr FROM Vorlesungen WHERE Titel = 'Ethik');
/*
Erklärung der Abfrage
    1.  Unterabfrage: (SELECT Vorlesungen.VorlNr FROM Vorlesungen WHERE Titel = 'Ethik')
        Diese Unterabfrage sucht die VorlNr (Primärschlüssel) der Vorlesung mit dem Titel "Ethik" in der Tabelle Vorlesungen.

    2.  Vergleich: WHERE hoeren.VorlNr = (SELECT Vorlesungen.VorlNr FROM Vorlesungen WHERE Titel = 'Ethik')
        Hier vergleichst du den Fremdschlüssel hoeren.VorlNr mit dem Ergebnis der Unterabfrage, also dem Primärschlüssel Vorlesungen.VorlNr.

Beziehungen
    Primärschlüssel: Vorlesungen.VorlNr ist der Primärschlüssel der Tabelle Vorlesungen. Er identifiziert eindeutig jede Vorlesung.
    Fremdschlüssel: hoeren.VorlNr ist ein Fremdschlüssel in der Tabelle hoeren, der auf Vorlesungen.VorlNr verweist. Er stellt sicher, dass jede Vorlesungsnummer in hoeren gültig ist und in der Tabelle Vorlesungen existiert.

Fazit
    Durch den Vergleich eines Fremdschlüssels mit einem Primärschlüssel nutzt du die referenzielle Integrität der Datenbank, um sicherzustellen, dass die Daten konsistent und korrekt sind. Dies ist ein grundlegendes Konzept in relationalen Datenbanken und ermöglicht es dir, Beziehungen zwischen Tabellen effektiv zu nutzen.
*/

-- Nr.2.2
CREATE VIEW SchopenhauerMatrNr AS
SELECT MatrNr
FROM Studenten
WHERE Name = 'Schopenhauer';

CREATE VIEW SchopenhauerVorlNr AS
SELECT VorlNr
FROM hoeren
WHERE MatrNr IN (SELECT MatrNr FROM SchopenhauerMatrNr);

CREATE VIEW StudentenDieAuchVorlesungVonSchopenhauerHoeren AS
SELECT MatrNr
FROM hoeren
WHERE VorlNr IN (SELECT VorlNr FROM SchopenhauerVorlNr);

SELECT Name
FROM Studenten
WHERE MatrNr IN (SELECT MatrNr FROM StudentenDieAuchVorlesungVonSchopenhauerHoeren) AND Name != 'Schopenhauer';

-- 3. Studenten, die alle Vorlesungen von Schopenhauer hören
SELECT s.Name
FROM Studenten s
WHERE NOT EXISTS ( -- NOT EXISTS: Prüft, ob die Unterabfrage keine Ergebnisse zurückgibt
    SELECT VorlNr -- Alle Vorlesungen, die Schopenhauer hört ...
    FROM hoeren h
    JOIN Studenten schopenhauer ON h.MatrNr = schopenhauer.MatrNr
    WHERE schopenhauer.Name = 'Schopenhauer'
    EXCEPT -- EXEPT: (... Minus ...)
    SELECT VorlNr -- ... Alle Vorlesungen, die ein Student hört
    FROM hoeren
    WHERE MatrNr = s.MatrNr
);

-- 4. Vorlesungen mit mindestens zwei Voraussetzungen
SELECT Nachfolger
FROM voraussetzen
GROUP BY Nachfolger
HAVING COUNT(*) >= 2;

-- 5. Vorlesungen und Anzahl der Prüfungen
SELECT v.VorlNr, COUNT(p.MatrNr) AS Anzahl
FROM Vorlesungen v
LEFT JOIN pruefen p ON v.VorlNr = p.VorlNr
GROUP BY v.VorlNr
ORDER BY Anzahl DESC;

-- 5 DIY
SELECT VorlNr, COUNT(MatrNr) AS Anzahl
FROM pruefen
WHERE Note IS NULL
GROUP BY VorlNr
ORDER BY Anzahl DESC;