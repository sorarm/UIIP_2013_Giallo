CREATE TABLE "EDITORIA_GRUPPO_GIALLO"."ACCOUNT"
  (
    "USERNAME"          VARCHAR2(45 BYTE) NOT NULL ENABLE,
    "PASSWORD"          VARCHAR2(45 BYTE) NOT NULL ENABLE,
    "NOME"              VARCHAR2(45 BYTE) NOT NULL ENABLE,
    "COGNOME"           VARCHAR2(45 BYTE) NOT NULL ENABLE,
    "EMAIL"             VARCHAR2(120 BYTE) NOT NULL ENABLE,
    "SIGLA_REDAZIONE"   VARCHAR2(10 BYTE) NOT NULL ENABLE,
    "SIGLA_GIORNALISTA" VARCHAR2(10 BYTE),
	"STATO"	CHAR(1 BYTE) DEFAULT 'A' NOT NULL ENABLE,
	CHECK (stato       ='A'
  OR stato             ='D') ENABLE,
    CONSTRAINT "ACCOUNT_PK" PRIMARY KEY ("USERNAME")
  );
  

CREATE TABLE "EDITORIA_GRUPPO_GIALLO"."GRUPPO"
  (
    "NOME_GRUPPO" VARCHAR2(45 BYTE),
    CONSTRAINT "GRUPPO_PK" PRIMARY KEY ("NOME_GRUPPO")
  );
 

CREATE TABLE "EDITORIA_GRUPPO_GIALLO"."APPARTENENZA_GRUPPO"
  (
    "USERNAME"    VARCHAR2(45 BYTE),
    "NOME_GRUPPO" VARCHAR2(45 BYTE),
    CONSTRAINT "APPARTENENZA_GRUPPO_PK" PRIMARY KEY ("USERNAME", "NOME_GRUPPO"),
    CONSTRAINT "APPARTENENZA_GRUPPO_FK1" FOREIGN KEY ("USERNAME") REFERENCES "EDITORIA_GRUPPO_GIALLO"."ACCOUNT" ("USERNAME") ON
  DELETE CASCADE ENABLE,
    CONSTRAINT "APPARTENENZA_GRUPPO_FK2" FOREIGN KEY ("NOME_GRUPPO") REFERENCES "EDITORIA_GRUPPO_GIALLO"."GRUPPO" ("NOME_GRUPPO") ON
  DELETE CASCADE ENABLE
  );
  

CREATE TABLE "EDITORIA_GRUPPO_GIALLO"."FUNZIONALITA"
  (
    "SIGLA_FUNZIONALITA" VARCHAR2(10 BYTE),
    "NOME_FUNZIONALITA"  VARCHAR2(100 BYTE),
    "NOME_GRUPPO"        VARCHAR2(45 BYTE),
    CONSTRAINT "FUNZIONALITA_PK" PRIMARY KEY ("SIGLA_FUNZIONALITA"),
    CONSTRAINT "FUNZIONALITA_FK1" FOREIGN KEY ("NOME_GRUPPO") REFERENCES "EDITORIA_GRUPPO_GIALLO"."GRUPPO" ("NOME_GRUPPO") ON DELETE CASCADE ENABLE
  );
 
CREATE TABLE "EDITORIA_GRUPPO_GIALLO"."NOTIZIA"
  (
    "ID"                NUMBER(10,0),
    "STATO"             CHAR(1 BYTE) DEFAULT 'S' NOT NULL ENABLE,
    "LOCK_NOTIZIA"      CHAR(1 BYTE) DEFAULT 'N' NOT NULL ENABLE,
    "TITOLO"            VARCHAR2(120 BYTE),
    "SOTTOTITOLO"       VARCHAR2(120 BYTE),
    "TIPOLOGIA_NOTIZIA" VARCHAR2(120 BYTE),
    "AUTORE"            VARCHAR2(45 BYTE),
    "ULTIMO_DIGITATORE" VARCHAR2(45 BYTE),
    "DATA_CREAZIONE" DATE DEFAULT CURRENT_TIMESTAMP NOT NULL ENABLE,
    "DATA_TRASMISSIONE" DATE,
    "TESTO" NCLOB,
    "LUNGHEZZA_TESTO" NUMBER(4,0),
    CHECK (stato       ='S'
  OR stato             ='Q'
  OR stato             ='T'
  OR stato             ='C') ENABLE,
    CHECK (lock_notizia='Y'
  OR lock_notizia      ='N') ENABLE,
    CONSTRAINT "NOTIZIA_PK" PRIMARY KEY ("ID")
  );
 
 CREATE TABLE "EDITORIA_GRUPPO_GIALLO"."GESTIONE_NOTIZIA"
  (
    "USERNAME"    VARCHAR2(45 BYTE),
    "NOTIZIA"                NUMBER(10,0),
    "DATA_MODIFICA" DATE,
    CONSTRAINT "GESTIONE_NOTIZIA_FK1" FOREIGN KEY ("USERNAME") REFERENCES "EDITORIA_GRUPPO_GIALLO"."ACCOUNT" ("USERNAME") ON DELETE CASCADE ENABLE,
	CONSTRAINT "GESTIONE_NOTIZIA_FK2" FOREIGN KEY ("NOTIZIA") REFERENCES "EDITORIA_GRUPPO_GIALLO"."NOTIZIA" ("ID") ON DELETE CASCADE ENABLE
  );