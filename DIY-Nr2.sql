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

-- 6. Professor(en) mit den meisten Assistenten
SELECT p.Name
FROM Professoren p
JOIN Assistenten a ON p.PersNr = a.Boss
GROUP BY p.PersNr, p.Name
HAVING COUNT(*) = ( -- Vergleicht die Anzahl der Assistenten mit dem größten Wert
    SELECT MAX(AssistentenAnzahl) -- MAX: Größter Wert der Unterabfrage
    FROM ( -- Unterabfrage: gleicher Boss (Professor PersNr) werden zsmgefasst und gezählt
        SELECT COUNT(*) AS AssistentenAnzahl
        FROM Assistenten
        GROUP BY Boss
    ) AS Counts
);

-- 7. Var.1 Studenten, die alle Vorlesungen hören
SELECT s.Name
FROM Studenten s
JOIN hoeren h ON s.MatrNr = h.MatrNr
GROUP BY s.MatrNr, s.Name -- bis hier: Alle Studenten, die Vorlesungen hören
HAVING COUNT(DISTINCT h.VorlNr) = ( -- COUNT(DISTINCT): Zählt die Anzahl der Vorlesungen, die ein Student hört (und dann wird verglichen mit =)
    SELECT COUNT(*) -- Zählt die Gesamtanzahl der Vorlesungen
    FROM Vorlesungen
);

-- 7. Var.2 Studenten, die alle Vorlesungen hören
-- Funktioniet wie Aufgabe 2.3 nur das wir alle existierende Vorlesungen anstatt nur die von Schopenhauer betrachten
SELECT s.Name
FROM Studenten s
WHERE NOT EXISTS ( -- NOT EXISTS: Prüft, ob die Unterabfrage keine Ergebnisse zurückgibt
    SELECT VorlNr -- Alle Vorlesungen, die existieren ...
    FROM Vorlesungen
    EXCEPT -- EXEPT: (... Minus ...)
    SELECT VorlNr -- ... Alle Vorlesungen, die ein Student hört
    FROM hoeren
    WHERE MatrNr = s.MatrNr
);

-- 8. Anzahl der Prüfungen mit Note 1 oder 2
SELECT COUNT(*) AS AnzahlGutePruefungen
FROM pruefen
WHERE Note < 3.0; -- Noten wie 2.7, 2.9, ... sind noch als "gut" zu betrachten

-- 9. Übersicht der Studierenden mit Durchschnittsnote und Varianz
SELECT s.MatrNr, s.Name, 
       AVG(p.Note) AS Durchschnittsnote,
       VAR_POP(p.Note) AS Varianz
FROM Studenten s
LEFT JOIN pruefen p ON s.MatrNr = p.MatrNr
GROUP BY s.MatrNr, s.Name; -- Gruppiert die Ergebnisse nach Studierenden, sodass jede Matrikelnummer und jeder Name nur einmal vorkommen.

-- 10. Namen, die in mindestens zwei verschiedenen Tabellen auftreten
SELECT Name
FROM (
    SELECT Name FROM Studenten
    UNION ALL
    SELECT Name FROM Professoren
    UNION ALL
    SELECT Name FROM Assistenten
) AS AllNames
GROUP BY Name
HAVING COUNT(*) >= 2;