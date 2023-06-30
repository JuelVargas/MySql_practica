/*
-------------------------------
-------- PRACTICO 9  ----------
-------------------------------*/
USE ENTREGAS; 

CREATE TABLE TECNICO (
CI CHAR(11) NOT NULL PRIMARY KEY,
NOMBRE VARCHAR(35) DEFAULT ' ',
DIRECCION VARCHAR(30) DEFAULT ' ',
SEXO CHAR(1), CHECK(SEXO IN('F', 'M')),
EDAD SMALLINT DEFAULT 0
) ENGINE = InnoDB;

INSERT INTO TECNICO VALUES ('10545678', 'JULIO CASTRO', 'CALLE SANTA LUCIA # 17', 'M', 25), 
 ('10541123', 'MARIA RUIZ', 'CALLE SANTA LUCIA # 21', 'F', 19), 
 ('10677678', 'JUAN PEMINTEL', 'CALLE SANTA LUCIA # 30', 'M', 40), 
 ('10356781', 'CARLA ORTIZ', ' ', 'F', 20);
 
ALTER TABLE ENTREGA ADD COLUMN CI CHAR(11) ;
UPDATE ENTREGA SET CI = 10356781 WHERE NE=1;
UPDATE ENTREGA SET CI = 10356781 WHERE NE=2;
UPDATE ENTREGA SET CI = 10356781 WHERE NE=3;


/*13. VISTA QUE MUESTRE LA HERRAMIENTA QUE MENOS SE HA ENTREGADO, MOSTRANDO SU CODIGO, 
DESCRIPCION Y CANTIDAD ENTREGADA.*/

CREATE VIEW EJERCICIO13
AS 
	SELECT H.CODIGO AS 'CODIGO',
			H.DESCRIPCION AS 'HERRAMIENTA',
            E.CANTIDAD AS 'CANTIDAD ENTREGADA'
	FROM HERRAMIENTA H INNER JOIN ENTREGA E ON E.CODIGO = H.CODIGO
    WHERE E.CANTIDAD = (SELECT MIN(CANTIDAD) FROM ENTREGA) LIMIT 1;
    
SELECT * FROM EJERCICIO13;

/*14. VISTA QUE MUESTRE EL TECNICO QUE MAS ENTREGAS DE HERRAMIENTAS HA RECIBIDO EN TERMINOS DE 
DINERO (COSTO). MOSTRAR NOMBRE DEL TECNCIO Y EL MONTO DE DINERO.*/

CREATE VIEW EJERCICIO14 AS
	SELECT T.NOMBRE AS 'TECNICO',
			SUM(H.PRECIO * E.CANTIDAD) AS 'MONTO'
	FROM TECNICO T
	JOIN ENTREGA E ON T.CI = E.CI
	JOIN HERRAMIENTA H ON E.CODIGO = H.CODIGO
	GROUP BY T.CI
	ORDER BY MONTO DESC
	LIMIT 1;
    
SELECT * FROM EJERCICIO14;

/*15. TABLA VIRTUAL QUE DETERMINE CUAL ES EL MEJOR PRECIO Y EL MENOR PRECIO OBTENIDO POR LAS 
HERRAMIENTAS DEL GRUPO CUYO CODIGO COMIENZA CON LA LETRA “H”.*/

CREATE VIEW EJERCICIO15 AS
	SELECT MAX(PRECIO) AS 'MEJOR PRECIO',
			MIN(PRECIO) AS 'MENOR PRECIO'
	FROM HERRAMIENTA 
    WHERE CODIGO LIKE 'H%';

SELECT * FROM EJERCICIO15;

/*16. VISTA QUE MUESTRE EL COSTO TOTAL DE ENTREGAS REALIZADA A CADA TECNICO, INCLUYENDO 
SOLAMENTE LAS ENTREGAS COMPRENDIDAS ENTRE 500 Y 1000 INCLUSIVE. SE DEBEN MOSTRAR 
SOLAMENTE LOS TECNCIOS CUYA CANTIDAD TOTAL DE ENTREGAS ES SUPERIOR A 10.*/

CREATE VIEW EJERCICIO16 AS
	SELECT T.NOMBRE AS 'TECNICO',
		(H.PRECIO * E.CANTIDAD) AS 'COSTO'
	FROM TECNICO T INNER JOIN ENTREGA E ON E.CI = T.CI
    INNER JOIN HERRAMIENTA H ON H.CODIGO = E.CODIGO
    WHERE E.NE BETWEEN 1 AND 10 AND E.CANTIDAD >=10;

    
SELECT * FROM EJERCICIO16;





            
    