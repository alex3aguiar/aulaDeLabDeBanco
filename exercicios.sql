
	
    
    DROP procedure IF EXISTS `exercico1`;
DELIMITER $$
CREATE PROCEDURE exercico1 ()
BEGIN	
 DECLARE done INT DEFAULT FALSE;
  DECLARE nome varchar(50);
  DECLARE codTit varchar(50);
  DECLARE meuCursor CURSOR FOR select DISTINCT  nomeProf from Professor  where Professor.codTit <> 3 and  Professor.codTit is not null;
  
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	drop  table if exists tabelaTemporaria;
	create temporary table if not exists tabelaTemporaria (
      nome varchar(50)
    );
    
    OPEN meuCursor;
	
    read_loop: LOOP
    
	FETCH meuCursor INTO nome;
    /*verifica se acabou resultados do cursor*/
	IF done THEN
      LEAVE read_loop;
    END IF;
    
   
    Insert into tabelaTemporaria values(nome);
    
  END LOOP;
	SELECT *  FROM tabelaTemporaria;
	
  CLOSE meuCursor;
  


END $$
DELIMITER ;
CALL exercico1();






create table if not exists logDepto (
	dataDaAlteracao  timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	dadoAntigo varchar(40)
);

DROP TRIGGER logDoDepto; 
 
DELIMITER  $$
CREATE  TRIGGER logDoDepto BEFORE UPDATE
ON depto
FOR EACH ROW
BEGIN
	    INSERT INTO logDepto (dadoAntigo,usuario)VALUES(OLD.NomeDepto,CURRENT_USER());
END$$
DELIMITER ;

UPDATE depto SET NomeDepto = 'teste' where CodDepto = 'POL01';





DROP TRIGGER impedeTurmaComPoucoCredito; 
 
DELIMITER  $$
CREATE  TRIGGER impedeTurmaComPoucoCredito BEFORE INSERT
ON Turma
FOR EACH ROW
BEGIN

 DECLARE credito INT;
 SELECT CreditoDisc INTO credito FROM  Disciplina  WHERE NumDisc = NEW.NumDisc;

 	IF credito < 3   THEN
		signal sqlstate '45000' set message_text = "NOSSO ERRO de segunda";
	END IF;
END$$
DELIMITER ;

Insert into Turma
values
(323031,'INF01',1,'1D',50)


	
