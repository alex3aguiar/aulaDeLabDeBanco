
	
    
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
