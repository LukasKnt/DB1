-- Aufgabe 1: DDL-Ausdrücke zum Anlegen des Schemas
CREATE TABLE Studenten (
    MatrNr INTEGER PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Semester INTEGER CHECK (Semester > 0)
);

CREATE TABLE Professoren (
    PersNr INTEGER PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Raum VARCHAR(10),
    VVorl INTEGER NOT NULL
    -- FOREIGN KEY (VVorl) REFERENCES Vorlesungen(VorlNr) -- jeder Professor muss mindestens für eine Vorlesung (VVorl) verantwortlich sein
);

CREATE TABLE Vorlesungen (
    VorlNr INTEGER PRIMARY KEY,
    Titel VARCHAR(100) NOT NULL,
    SWS INTEGER CHECK (SWS > 0),
    gelesenVon INTEGER NOT NULL
    -- FOREIGN KEY (gelesenVon) REFERENCES Professoren(PersNr) -- jede Vorlesung muss einem bestimmten Dozent zugeordnet sein, der selbst Professor an der Hochschule ist.
);

ALTER TABLE Professoren
ADD CONSTRAINT fk_professoren_vv
FOREIGN KEY (VVorl) REFERENCES Vorlesungen(VorlNr);

ALTER TABLE Vorlesungen
ADD CONSTRAINT vorlesungen_gelesenvon_fkey
FOREIGN KEY (gelesenVon) REFERENCES Professoren(PersNr);

CREATE TABLE Assistenten (
    PersNr INTEGER PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Fachgebiet VARCHAR(100),
    Boss INTEGER NOT NULL,
    FOREIGN KEY (Boss) REFERENCES Professoren(PersNr)
);

/*
Beziehungstabelle hoeren (hier einmal genauer beschrieben, alle anderen Beziehungen sind in der Markdown-Datei festgehalten)
Primaerschluessel: Zusammengesetzter Primaerschluessel aus den Spalten MatrNr und VorlNr.
    -> Jede Kombination aus MatrNr und VorlNr ist einzigartig.
        => Ein Student kann eine bestimmte Vorlesung nur einmal hoeren.
    -> Dies ermöglicht eine genaue Identifikation jedes Datensatzes.

Fremdschluessel: Referentielle Integritaet sicherstellen
    -> MatrNr muss in der Tabelle Studenten existieren.
    -> VorlNr muss in der Tabelle Vorlesungen existieren.
    -> Dies verhindert, dass nicht existierende Studenten oder Vorlesungen eingetragen werden.
*/
CREATE TABLE hoeren (
    MatrNr INTEGER,
    VorlNr INTEGER,
    PRIMARY KEY (MatrNr, VorlNr),
    FOREIGN KEY (MatrNr) REFERENCES Studenten(MatrNr),
    FOREIGN KEY (VorlNr) REFERENCES Vorlesungen(VorlNr)
);

CREATE TABLE voraussetzen (
    Vorgaenger INTEGER,
    Nachfolger INTEGER,
    PRIMARY KEY (Vorgaenger, Nachfolger),
    FOREIGN KEY (Vorgaenger) REFERENCES Vorlesungen(VorlNr),
    FOREIGN KEY (Nachfolger) REFERENCES Vorlesungen(VorlNr)
);

CREATE TABLE pruefen (
    MatrNr INTEGER,
    VorlNr INTEGER,
    PersNr INTEGER,
    Note NUMERIC(2,1) CHECK (Note BETWEEN 1.0 AND 5.0),
    PRIMARY KEY (MatrNr, VorlNr),
    FOREIGN KEY (MatrNr) REFERENCES Studenten(MatrNr),
    FOREIGN KEY (VorlNr) REFERENCES Vorlesungen(VorlNr),
    FOREIGN KEY (PersNr) REFERENCES Professoren(PersNr)
);