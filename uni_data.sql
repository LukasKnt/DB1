ALTER TABLE Vorlesungen DROP CONSTRAINT vorlesungen_gelesenvon_fkey;
ALTER TABLE Professoren DROP CONSTRAINT fk_professoren_vv;


INSERT INTO Studenten(MatrNr, Name, Semester) 
VALUES (24002, 'Xenokrates', 18); 
 
INSERT INTO Studenten(MatrNr, Name, Semester) 
VALUES (25403, 'Jonas', 12); 
 
INSERT INTO Studenten(MatrNr, Name, Semester) 
VALUES (26120, 'Fichte', 10); 

INSERT INTO Studenten(MatrNr, Name, Semester) 
VALUES (26830, 'Aristoxenos', 8); 
 
INSERT INTO Studenten(MatrNr, Name, Semester) 
VALUES (27550, 'Schopenhauer', 6); 

INSERT INTO Studenten(MatrNr, Name, Semester) 
VALUES (28106, 'Carnap', 3); 
 
INSERT INTO Studenten(MatrNr, Name, Semester) 
VALUES (29120, 'Theophrastos', 2); 
 
INSERT INTO Studenten(MatrNr, Name, Semester) 
VALUES (29555, 'Feuerbach', 2);

INSERT INTO Studenten(MatrNr, Name, Semester) 
VALUES (29999, 'Lukas', 3);

INSERT INTO Studenten(MatrNr, Name, Semester) 
VALUES (29998, 'Fabian', 3);

INSERT INTO Studenten(MatrNr, Name, Semester) 
VALUES (29997, 'Abraham', 3);

INSERT INTO Studenten(MatrNr, Name, Semester) 
VALUES (29996, 'David', 3);

INSERT INTO Studenten(MatrNr, Name, Semester) 
VALUES (29995, 'Popper', 6);


INSERT INTO Professoren(PersNr, Name, Raum, VVorl) 
VALUES (2125, 'Sokrates', 226, 5001); 

INSERT INTO Professoren(PersNr, Name, Raum, VVorl) 
VALUES (2126, 'Russel', 232, 5041);  
 
INSERT INTO Professoren(PersNr, Name, Raum, VVorl) 
VALUES (2127, 'Kopernikus', 310, 5043); 
 
INSERT INTO Professoren(PersNr, Name, Raum, VVorl) 
VALUES (2133, 'Popper', 052, 5049); 
 
INSERT INTO Professoren(PersNr, Name, Raum, VVorl) 
VALUES (2134, 'Augustinus', 309, 5052); 
 
INSERT INTO Professoren(PersNr, Name, Raum, VVorl) 
VALUES (2136, 'Curie', 036, 5022); 
 
INSERT INTO Professoren(PersNr, Name, Raum, VVorl) 
VALUES (2137, 'Kant', 007, 4630); 
 
 
 
INSERT INTO Assistenten(PersNr, Name, Fachgebiet, Boss) 
VALUES (3002, 'Platon', 'Ideenlehre', 2125); 
 
INSERT INTO Assistenten(PersNr, Name, Fachgebiet, Boss) 
VALUES (3003, 'Aristoteles', 'Syllogistik', 2125); 
 
INSERT INTO Assistenten(PersNr, Name, Fachgebiet, Boss) 
VALUES (3004, 'Wittgenstein', 'Sprachtheorie', 2126); 
 
INSERT INTO Assistenten(PersNr, Name, Fachgebiet, Boss) 
VALUES (3005, 'Rhetikus', 'Planetenbewegung', 2127); 
 
INSERT INTO Assistenten(PersNr, Name, Fachgebiet, Boss) 
VALUES (3006, 'Newton', 'Keplersche Gesetze', 2127); 
 
INSERT INTO Assistenten(PersNr, Name, Fachgebiet, Boss) 
VALUES (3007, 'Spinoza', 'Gott und Natur', 2134); 


 
INSERT INTO Vorlesungen(VorlNr, Titel, SWS, gelesenVon) 
VALUES (5001, 'Grundzuege', 4, 2137);

INSERT INTO Vorlesungen(VorlNr, Titel, SWS, gelesenVon) 
VALUES (5041, 'Ethik', 4, 2125);
 
INSERT INTO Vorlesungen(VorlNr, Titel, SWS, gelesenVon) 
VALUES (5043, 'Erkenntnistheorie', 3, 2126);
 
INSERT INTO Vorlesungen(VorlNr, Titel, SWS, gelesenVon) 
VALUES (5049, 'Maeeutik', 2, 2125);
 
INSERT INTO Vorlesungen(VorlNr, Titel, SWS, gelesenVon) 
VALUES (4052, 'Logik', 4, 2125);
 
INSERT INTO Vorlesungen(VorlNr, Titel, SWS, gelesenVon) 
VALUES (5052, 'Wissenschaftstheorie', 3, 2126); 
 
INSERT INTO Vorlesungen(VorlNr, Titel, SWS, gelesenVon) 
VALUES (5216, 'Bioethik', 2, 2126); 
 
INSERT INTO Vorlesungen(VorlNr, Titel, SWS, gelesenVon) 
VALUES (5259, 'Der Wiener Kreis', 2, 2133); 
 
INSERT INTO Vorlesungen(VorlNr, Titel, SWS, gelesenVon) 
VALUES (5022, 'Glaube und Wissen', 2, 2134); 
 
INSERT INTO Vorlesungen(VorlNr, Titel, SWS, gelesenVon) 
VALUES (4630, 'Die 3 Kritiken', 4, 2137); 


 
 
INSERT INTO hoeren(MatrNr, VorlNr) 
VALUES (26120, 5001); 
 
INSERT INTO hoeren(MatrNr, VorlNr) 
VALUES (27550, 5001); 
 
INSERT INTO hoeren(MatrNr, VorlNr) 
VALUES (27550, 4052); 
 
INSERT INTO hoeren(MatrNr, VorlNr) 
VALUES (28106, 5041); 
 
INSERT INTO hoeren(MatrNr, VorlNr) 
VALUES (28106, 5052); 
 
INSERT INTO hoeren(MatrNr, VorlNr) 
VALUES (28106, 5216); 
 
INSERT INTO hoeren(MatrNr, VorlNr) 
VALUES (28106, 5259); 
 
INSERT INTO hoeren(MatrNr, VorlNr) 
VALUES (29120, 5001); 

INSERT INTO hoeren(MatrNr, VorlNr) 
VALUES (29120, 5041); 

INSERT INTO hoeren(MatrNr, VorlNr) 
VALUES (29120, 5049); 

INSERT INTO hoeren(MatrNr, VorlNr) 
VALUES (29555, 5022); 

INSERT INTO hoeren(MatrNr, VorlNr) 
VALUES (25403, 5022);  
 
INSERT INTO hoeren(MatrNr, VorlNr) 
VALUES (29555, 5001);

-- Lukas hoert die Vorlesungen die auch Schopenhauer hoert + weitere
INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29999, 5001);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29999, 4052);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29999, 5041);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29999, 5043);

-- Fabian hoert alle Vorlesungen
INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29998, 5001);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29998, 4052);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29998, 5041);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29998, 5043);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29998, 5049);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29998, 5052);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29998, 5216);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29998, 5259);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29998, 5022);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29998, 4630);

-- Abraham hoert alle Vorlesungen
INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29997, 5001);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29997, 4052);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29997, 5041);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29997, 5043);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29997, 5049);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29997, 5052);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29997, 5216);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29997, 5259);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29997, 5022);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29997, 4630);

-- David hoert fast alle Vorlesungen
INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29996, 5001);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29996, 4052);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29996, 5041);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29996, 5043);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29996, 5049);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29996, 5052);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29996, 5022);

INSERT INTO hoeren(MatrNr, VorlNr)
VALUES (29996, 4630);
 
 
INSERT INTO voraussetzen(Vorgaenger, Nachfolger) 
VALUES (5001, 5041); 
 
INSERT INTO voraussetzen(Vorgaenger, Nachfolger) 
VALUES (5001, 5043); 
 
INSERT INTO voraussetzen(Vorgaenger, Nachfolger) 
VALUES (5001, 5049); 
 
INSERT INTO voraussetzen(Vorgaenger, Nachfolger) 
VALUES (5041, 5216);  

INSERT INTO voraussetzen(Vorgaenger, Nachfolger) 
VALUES (5043, 5052);  

INSERT INTO voraussetzen(Vorgaenger, Nachfolger) 
VALUES (5041, 5052); 
 
INSERT INTO voraussetzen(Vorgaenger, Nachfolger) 
VALUES (5052, 5259); 
 


INSERT INTO pruefen(MatrNr, VorlNr, PersNr, Note) 
VALUES (28106, 5001, 2126, 1.0);

INSERT INTO pruefen(MatrNr, VorlNr, PersNr, Note) 
VALUES (25403, 5041, 2125, 2.0);

INSERT INTO pruefen(MatrNr, VorlNr, PersNr, Note) 
VALUES (27550, 4630, 2137, 2.0);

INSERT INTO pruefen(MatrNr, VorlNr, PersNr, Note)
VALUES (26120, 5001, 2137, 3.0);

-- Lukas hat die Vorlesung Grundzuege bestanden
INSERT INTO pruefen(MatrNr, VorlNr, PersNr, Note) 
VALUES (29999, 5001, 2126, 1.0);

INSERT INTO pruefen(MatrNr, VorlNr, PersNr, Note)
VALUES (29999, 4052, 2125, 2.0);

INSERT INTO pruefen(MatrNr, VorlNr, PersNr, Note)
VALUES (29999, 5041, 2125, 3.0);

INSERT INTO pruefen(MatrNr, VorlNr, PersNr, Note)
VALUES (29999, 5043, 2127, 5.0);


-- Fabian
INSERT INTO pruefen(MatrNr, VorlNr, PersNr, Note)
VALUES (29998, 5001, 2126, 3.0);

INSERT INTO pruefen(MatrNr, VorlNr, PersNr, Note)
VALUES (29998, 4052, 2125, 5.0);

INSERT INTO pruefen(MatrNr, VorlNr, PersNr, Note)
VALUES (29998, 5041, 2125, 4.0);

INSERT INTO pruefen(MatrNr, VorlNr, PersNr, Note)
VALUES (29998, 5043, 2127, 2.0);

-- Abraham
INSERT INTO pruefen(MatrNr, VorlNr, PersNr, Note)
VALUES (29997, 5001, 2126, 3.0);

INSERT INTO pruefen(MatrNr, VorlNr, PersNr, Note)
VALUES (29997, 4052, 2125, 1.0);

INSERT INTO pruefen(MatrNr, VorlNr, PersNr, Note)
VALUES (29997, 5041, 2125, 2.0);

INSERT INTO pruefen(MatrNr, VorlNr, PersNr, Note)
VALUES (29997, 5043, 2127, 2.0);

INSERT INTO pruefen(MatrNr, VorlNr, PersNr, Note)
VALUES (29997, 5049, 2125, 5.0);

-- David
INSERT INTO pruefen(MatrNr, VorlNr, PersNr, Note)
VALUES (29996, 5001, 2126, 3.0);

INSERT INTO pruefen(MatrNr, VorlNr, PersNr, Note)
VALUES (29996, 4052, 2125, 1.0);

INSERT INTO pruefen(MatrNr, VorlNr, PersNr, Note)
VALUES (29996, 5041, 2125, 2.0);

INSERT INTO pruefen(MatrNr, VorlNr, PersNr, Note)
VALUES (29996, 5043, 2127, 5.0);


ALTER TABLE Vorlesungen
ADD CONSTRAINT vorlesungen_gelesenvon_fkey
FOREIGN KEY (gelesenVon) REFERENCES Professoren(PersNr);

ALTER TABLE Professoren
ADD CONSTRAINT fk_professoren_vv
FOREIGN KEY (VVorl) REFERENCES Vorlesungen(VorlNr);