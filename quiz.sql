USE cleaner;

show tables;

describe pago;

select * from pago order by id_transaccion desc;
select * from cliente;

select distinct forma_pago from pago; /* PayPal, Transferencia, Cheque*/

insert into pago (id_transaccion, codigo_cliente, forma_pago, fecha_pago, total )
values ('ak-std-000027', 4, 'Paypal', sysdate(), 5000); 

insert into pago (id_transaccion, codigo_cliente, forma_pago, fecha_pago, total )
values ('ak-std-000028', 4, 'Paypal', sysdate(), 300); 


/******************************PROCEDURE *******************************************/
DELIMITER //
CREATE  PROCEDURE SP_INSERTAR_PAGO ( IN p_id_transaccion VARCHAR(50), IN p_codigo_cliente INT, 
IN p_forma_pago VARCHAR(40), IN p_fecha_pago DATE, IN p_total INT)
BEGIN

DECLARE v_existe_id_tran  VARCHAR(50);

SELECT COUNT(*) 
INTO v_existe_id_tran
FROM PAGO WHERE ID_TRANSACCION = p_id_transaccion;

IF v_existe_id_tran = 0 then
	insert into pago (id_transaccion, codigo_cliente, forma_pago, fecha_pago, total )
	values (p_id_transaccion, p_codigo_cliente, p_forma_pago, p_fecha_pago, p_total); 
END IF;

END //
DELIMITER ;

CALL SP_INSERTAR_PAGO ('ak-std-000028', 4, 'Paypal', sysdate(), 300); 
CALL SP_INSERTAR_PAGO ('ak-std-000029', 4, 'Paypal', sysdate(), 400); 

SELECT * FROM PAGO WHERE CODIGO_CLIENTE = 4 ORDER BY 4;

SELECT COUNT(*) 
FROM PAGO WHERE ID_TRANSACCION = 'ak-std-000028';

DROP PROCEDURE SP_INSERTAR_PAGO;

/*************************JOB*******************************/

CREATE TABLE LOGS(
	ID INT AUTO_INCREMENT PRIMARY KEY,
    MENSAJE VARCHAR(100),
    FECHA TIMESTAMP DEFAULT current_timestamp
);


CREATE EVENT REVISION_JUAN
ON SCHEDULE EVERY 1 minute
DO
	INSERT INTO LOGS(MENSAJE)
    values ('Evento ejecutado automaticamente');
    
show EVENTS;

SHOW VARIABLES LIKE 'event_scheduler';

SET GLOBAL event_scheduler = ON;

SELECT * FROM LOGS;

ALTER EVENT REVISION_JUAN DISABLE; /* LO DETENGO */

ALTER EVENT REVISION_JUAN ENABLE; /* LO HABILITO */

DROP EVENT REVISION_JUAN; /* LO ELIMINO */



