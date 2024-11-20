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

-- 2. Studenten, die mit Schopenhauer eine Vorlesung gehört haben
SELECT DISTINCT s.Name
FROM Studenten s
JOIN hoeren h1 ON s.MatrNr = h1.MatrNr -- jetzt wissen wir welche "namen" welche "Vorlesungen" (VorlNr) hören
JOIN hoeren h2 ON h1.VorlNr = h2.VorlNr -- Alle Studenten, die AKTUELL eine Vorlesung mit Schopenhauer hören
JOIN Studenten schopenhauer ON h2.MatrNr = schopenhauer.MatrNr
WHERE schopenhauer.Name = 'Schopenhauer' AND s.Name != 'Schopenhauer';

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

