-- Aufgabe 1: DDL-Ausdrücke zum Anlegen des Schemas

CREATE TABLE Studenten (
    MatrNr INTEGER PRIMARY KEY, -- PrimaryKey: genaue Identifikation eines Studenten
    Name VARCHAR(100) NOT NULL,
    Semester INTEGER CHECK (Semester > 0)
);

CREATE TABLE Professoren (
    PersNr INTEGER PRIMARY KEY, -- PrimaryKey: genaue Identifikation eines Professors
    Name VARCHAR(100) NOT NULL,
    Raum VARCHAR(10),
    VVorl INTEGER NOT NULL
);

CREATE TABLE Vorlesungen (
    VorlNr INTEGER PRIMARY KEY, -- PrimaryKey: genaue Identifikation einer Vorlesung
    Titel VARCHAR(100) NOT NULL,
    SWS INTEGER CHECK (SWS > 0),
    gelesenVon INTEGER NOT NULL,
    FOREIGN KEY (gelesenVon) REFERENCES Professoren(PersNr) -- Fremdschluessel: eine Vorlesung referenziert genau einen Professoer (derjenige der die Vorlesung haelt)
);

CREATE TABLE Assistenten (
    PersNr INTEGER PRIMARY KEY, -- PrimaryKey: genaue Identifikation eines Assistenten
    Name VARCHAR(100) NOT NULL,
    Fachgebiet VARCHAR(100),
    Boss INTEGER NOT NULL,
    FOREIGN KEY (Boss) REFERENCES Professoren(PersNr) -- Fremdschluessel: ein Assistent gehoert immer zu genau einem Professor (der Professor ist der Boss des Assistenten)
);

CREATE TABLE hoeren ( -- Tabellendefinition: Dies erstellt eine neue Tabelle namens "hoeren", die die Beziehung zwischen Studenten und Vorlesungen darstellt.
    MatrNr INTEGER, -- Spalten: Die Tabelle hat zwei Spalten: MatrNr (Matrikelnummer des Studenten) und VorlNr (Vorlesungsnummer).
    VorlNr INTEGER,
	--Primaerschluessel: Dies definiert einen zusammengesetzten Primaerschluessel aus beiden Spalten. Das bedeutet:
						-- Jede Kombination aus MatrNr und VorlNr ist einzigartig.
						-- Ein Student kann eine bestimmte Vorlesung nur einmal hoeren.
						-- Dies ermöglicht eine genaue Identifikation jedes Datensatzes.
    PRIMARY KEY (MatrNr, VorlNr),
	-- Fremdschluessel: Diese Fremdschluessel stellen referentielle Integritaet sicher:
			-- MatrNr muss in der Tabelle Studenten existieren.
			-- VorlNr muss in der Tabelle Vorlesungen existieren.
			-- Dies verhindert, dass nicht existierende Studenten oder Vorlesungen eingetragen werden.
    FOREIGN KEY (MatrNr) REFERENCES Studenten(MatrNr), -- Fremdschluessel: eine MatrNr gehoert immer zu genau einem Studenten
    FOREIGN KEY (VorlNr) REFERENCES Vorlesungen(VorlNr) -- Fremdschluessel: eine VorlNr gehoert immer zu genau einer Vorlesung
);

CREATE TABLE voraussetzen (
    Vorgaenger INTEGER,
    Nachfolger INTEGER,
    PRIMARY KEY (Vorgaenger, Nachfolger), -- PrimaryKey:
    FOREIGN KEY (Vorgaenger) REFERENCES Vorlesungen(VorlNr), -- Fremdschluessel:
    FOREIGN KEY (Nachfolger) REFERENCES Vorlesungen(VorlNr) -- Fremdschluessel:
);

CREATE TABLE pruefen (
    MatrNr INTEGER,
    VorlNr INTEGER,
    PersNr INTEGER,
    Note NUMERIC(2,1) CHECK (Note BETWEEN 1.0 AND 5.0), -- Note muss zwischen 1.0 und 5.0 liegen
    PRIMARY KEY (MatrNr, VorlNr), -- PrimaryKey:
    FOREIGN KEY (MatrNr) REFERENCES Studenten(MatrNr), -- Fremdschluessel:
    FOREIGN KEY (VorlNr) REFERENCES Vorlesungen(VorlNr), -- Fremdschluessel:
    FOREIGN KEY (PersNr) REFERENCES Professoren(PersNr) -- Fremdschluessel:
);

-- Aufgabe 2: Einfügen von Beispieldaten und SQL-Anfragen

-- Einfügen von Beispieldaten (hier nur einige Beispiele)
INSERT INTO Studenten VALUES (24002, 'Xenokrates', 18);
INSERT INTO Studenten VALUES (25403, 'Jonas', 12);
INSERT INTO Studenten VALUES (26120, 'Fichte', 10);
INSERT INTO Studenten VALUES (27550, 'Schopenhauer', 6);

INSERT INTO Professoren VALUES (2125, 'Sokrates', '226', 5041);
INSERT INTO Professoren VALUES (2126, 'Russel', '232', 5043);
INSERT INTO Professoren VALUES (2127, 'Kopernikus', '310', 5041);

INSERT INTO Vorlesungen VALUES (5041, 'Ethik', 4, 2125);
INSERT INTO Vorlesungen VALUES (5043, 'Erkenntnistheorie', 3, 2126);
INSERT INTO Vorlesungen VALUES (5049, 'Mäeutik', 2, 2125);

INSERT INTO hoeren VALUES (26120, 5041);
INSERT INTO hoeren VALUES (27550, 5041);
INSERT INTO hoeren VALUES (27550, 5049);

-- SQL-Anfragen

-- 1. Studenten, die Ethik hören
SELECT MatrNr FROM hoeren WHERE VorlNr = (SELECT VorlNr FROM Vorlesungen WHERE Titel = 'Ethik');

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
HAVING COUNT(*) = (
    SELECT MAX(AssistentenAnzahl)
    FROM (
        SELECT COUNT(*) AS AssistentenAnzahl
        FROM Assistenten
        GROUP BY Boss
    ) AS Counts
);

-- 7. Studenten, die alle Vorlesungen hören
SELECT s.Name
FROM Studenten s
WHERE NOT EXISTS (
    SELECT VorlNr
    FROM Vorlesungen
    EXCEPT
    SELECT VorlNr
    FROM hoeren
    WHERE MatrNr = s.MatrNr
);

-- 8. Anzahl der Prüfungen mit Note 1 oder 2
SELECT COUNT(*) AS AnzahlGutePruefungen
FROM pruefen
WHERE Note <= 2.0;

-- 9. Übersicht der Studierenden mit Durchschnittsnote und Varianz
SELECT s.MatrNr, s.Name, 
       AVG(p.Note) AS Durchschnittsnote,
       VAR_POP(p.Note) AS Varianz
FROM Studenten s
LEFT JOIN pruefen p ON s.MatrNr = p.MatrNr
GROUP BY s.MatrNr, s.Name;

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

-- 11. Vorlesungen und ihre direkten und indirekten Voraussetzungen
WITH RECURSIVE VoraussetzungenRekursiv AS (
    SELECT Vorgaenger, Nachfolger
    FROM voraussetzen
    UNION
    SELECT v.Vorgaenger, vr.Nachfolger
    FROM voraussetzen v
    JOIN VoraussetzungenRekursiv vr ON v.Nachfolger = vr.Vorgaenger
)
SELECT DISTINCT Nachfolger, Vorgaenger
FROM VoraussetzungenRekursiv
ORDER BY Nachfolger, Vorgaenger;

-- Aufgabe 3: Performanzverbesserung durch Index

-- Beispiel für eine Anfrage, die von einem Index profitieren könnte
EXPLAIN ANALYZE
SELECT s.Name, v.Titel
FROM Studenten s
JOIN hoeren h ON s.MatrNr = h.MatrNr
JOIN Vorlesungen v ON h.VorlNr = v.VorlNr
WHERE v.SWS > 2;

-- Erstellen eines Index
CREATE INDEX idx_vorlesungen_sws ON Vorlesungen(SWS);

-- Erneute Ausführung der Anfrage mit Index
EXPLAIN ANALYZE
SELECT s.Name, v.Titel
FROM Studenten s
JOIN hoeren h ON s.MatrNr = h.MatrNr
JOIN Vorlesungen v ON h.VorlNr = v.VorlNr
WHERE v.SWS > 2;