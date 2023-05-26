/*
-------------------------------
----   TRABAJO PRACTICO 6  ----
-------------------------------

NOMBRE: JUEL VARGAS ROJAS
GRUPO: 1
*/


USE ENTREGAS;

/*----------------------
----  EJERCICIO 11  ----
------------------------*/

DELIMITER //
	CREATE PROCEDURE PA_EJERCICIO11(IN M1 INT, IN M2 INT )
    BEGIN
		IF ((M1 > 0 AND M1 <= 12) AND (M2 > 0  AND M2 <=12) AND M1 < M2) THEN
			IF EXISTS (SELECT * FROM ENTREGA WHERE (YEAR(FECHA) = YEAR(NOW())
            AND MONTH(FECHA) BETWEEN M1 AND M2)) THEN
                
                SELECT H.CODIGO, SUM(H.PRECIO * E.CANTIDAD) AS 'COSTO TOTAL'
				FROM HERRAMIENTA H INNER JOIN ENTREGA E ON E.CODIGO = H.CODIGO
                WHERE YEAR(E.FECHA) = YEAR(NOW()) AND 
                MONTH(E.FECHA) BETWEEN M1 AND M2
                GROUP BY E.CODIGO;
                
            ELSE SELECT 'NO EXISTEN ENTREGAS ENTRE ESTOS MESES'; END IF;
			
        ELSE SELECT 'MESES FUERA DE RANGO'; END IF; 
    END //
DELIMITER ;

CALL PA_EJERCICIO11(3, 6);


/*----------------------
----  EJERCICIO 12  ----
------------------------*/

DELIMITER //
	CREATE PROCEDURE PA_EJERCICIO12(IN DT DATE)
    BEGIN
   
		IF EXISTS (SELECT * FROM ENTREGA WHERE DATE(FECHA)= DT) THEN
            
            SELECT H.DESCRIPCION AS 'HERRAMIENTA', AVG(E.CANTIDAD)
            FROM HERRAMIENTA H INNER JOIN ENTREGA E ON E.CODIGO = H.CODIGO
            WHERE DATE(E.FECHA) = DT AND E.CANTIDAD > 3
            GROUP BY E.CODIGO;
            
        ELSE SELECT (' NO EXISTE ENTREGAS EN ESTA FECHA'); END IF;
    END //
DELIMITER ;

CALL PA_EJERCICIO12('2023-05-01');


/*----------------------
----  EJERCICIO 13  ----
------------------------*/
DELIMITER //
	CREATE PROCEDURE PA_EJERCICIO13( IN FE DATETIME, IN CANT SMALLINT, IN COD CHAR(6))
    BEGIN 
		IF EXISTS (SELECT * FROM HERRAMIENTA WHERE CODIGO = COD) THEN
        
			INSERT INTO ENTREGA (FECHA, CANTIDAD, CODIGO) 
            VALUES ( FE, CANT, COD);
        
        ELSE SELECT 'NO EXISTE HERRAMIENTA REGISTRADA'; END IF;
    END //
DELIMITER ;

CALL PA_EJERCICIO13(NOW(), 6, 'H-0003');


/*----------------------
----  EJERCICIO 14  ----
------------------------*/
DELIMITER //
CREATE PROCEDURE PA_EJERCICIO14(IN PRCNT TINYINT)
BEGIN 
	DECLARE F CHAR (6); DECLARE L CHAR(6);
    
    IF(PRCNT > 0 AND PRCNT <= 100) THEN
		SELECT MIN(CODIGO) INTO F FROM HERRAMIENTA;
        SELECT MAX(CODIGO) INTO L FROM HERRAMIENTA;
        UPDATE HERRAMIENTA SET PRECIO = CAST(PRECIO * (1 + PRCNT / 100) AS DECIMAL (6,2))
        WHERE CODIGO BETWEEN F AND L;
        
    ELSE SELECT 'NUMERO FUERA DE RANGO'; END IF;
    
END//
DELIMITER ;
CALL PA_EJERCICIO14(4);

/*----------------------
----  EJERCICIO 15  ----
------------------------*/

DELIMITER //
	CREATE PROCEDURE PA_EJERCICIO15(IN CEN INT, DES VARCHAR (35))
    BEGIN 
		IF EXISTS (SELECT * FROM HERRAMIENTA WHERE DESCRIPCION = DES) THEN
			UPDATE ALMACEN SET CENTRADA = CEN WHERE CODIGO IN (SELECT CODIGO FROM HERRAMIENTA WHERE DESCRIPCION = DES);
        ELSE SELECT 'LA HERRAMIENTA NO EXISTE'; END IF;
    END //
DELIMITER ;

CALL PA_EJERCICIO15(200, 'ALICATE DE PUNTA');





