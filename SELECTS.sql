/*-------------------------------------------------------------------------------*/
--              PONTIFÍCIA UNIVERSIDADE CATÓLICA DE MINAS GERAIS                --
--                     TRABALHO PRÁTICO DE BANCO DE DADOS                       --
--                    BACHARELADO EM ENGENHARIA DE COMPUTAÇÃO                   --
--                            PROFESSOR: RODRIGO BARONI                         --
-- ALUNO: WILTON  GARCIA    CURSO: SISTEMAS DE INFORMAÇÃO    MATRICULA: 521843  --          
-- ALUNA: MARCELLA BARROS   CUSRO: SISTEMAS DE INFORMAÇÃO    MATRICULA: 515100  --
--                                                                              --
/*-------------------------------------------------------------------------------*/

/* A )JUNÇÃO DE TRÊS OU MAIS TABELAS COM ODER BY*/
-- LISTA DE COMPANHIAS AREAS E A QUANTIDADE DE AEROPOROS EM QUE OPERA
SELECT 
	CA.NM_NOME_COMPANHIA as 'Companhia Áerea', 
    count(AER.ID_AEROPORTO) as  'Quantidade de Aeroportos em que opera'
FROM 
	tb_companhia_aerea CA 
JOIN 
    tb_operacao_aeroporto_cia_aerea OCIA
ON 
    CA.ID_COMPANHIA_AEREA = OCIA.ID_COMPANHIA_AEREA
JOIN
     tb_aeroporto AER
ON OCIA.ID_AEROPORTO = AER.ID_AEROPORTO
GROUP BY
     NM_NOME_COMPANHIA
ORDER BY
     CA.NM_NOME_COMPANHIA

/* B )JOIN COM 3 TABELAS OU MAIS USANDO A CLAUSULA WHERE*/
-- LISTA COM NOME DE FUNCIONARIO, CARGOS E ID DA OCORRENCIA DOS VOO
SELECT  
	FUN.NM_NOME AS 'FUNCIONARIO',
    CG.NM_CARGO AS 'CARGO',
    OCV.ID_OCORRENCIA_VOO
FROM 
	TB_ESCALA_FUNCIONARIOS_OCV OCV 
JOIN TB_FUNCIONARIO FUN
	ON FUN.ID_FUNCIONARIO = OCV.ID_FUNCIONARIO 
JOIN TB_CARGO CG
	ON FUN.ID_CARGO = CG.ID_CARGO
WHERE CG.ID_CARGO IN (1,2,3,4);

-- C ) JUNÇÃO DE TRÊS OU MAIS TABELAS USASNDO LIKE E BETWEEN
-- AEROROTOS QUE MAIS RECEBEM VOOS QUE FORAM INAUGURADOS NOS ANOS 90 E NÃO SÃO INTERNACIONAIS
SELECT 
	AER.NM_NOME_AEROPORTO 'NOME DO AEROPORTO',
    ENR.NM_CIDADE 'CIDADE DO AEROPORTO',
	COUNT(VOO.ID_VOO) 'NÚMERO DE VOOS'
FROM 
	TB_AEROPORTO AS AER
JOIN 
	TB_ENDERECO ENR
ON
	ENR.ID_ENDERECO = AER.ID_ENDERECO
JOIN 
	TB_VOO AS VOO
ON 
	VOO.ID_AEROPORTO_DESTINO = AER.ID_AEROPORTO
WHERE 
	AER.DT_DATA_INAUGURACAO BETWEEN '1990/01/01' AND '1999/01/31'
AND
	AER.NM_NOME_AEROPORTO NOT LIKE '%INTERNACIONAL%'
GROUP BY
	AER.ID_AEROPORTO
ORDER BY 3 DESC;

-- D)
-- LISTA DE TODAS OCORRECIAS DE VOO QUE USAM AERONAVES ENTRE OS MODELOS 700 E 800

SELECT 
	OCV.DT_DATA_OCORRENCIA,
    AER.NM_NOME_AEROPORTO,
    AER2.NM_NOME_AEROPORTO
FROM 
	TB_OCORRENCIA_VOO OCV
JOIN 
	TB_VOO VOO 
ON
	OCV.ID_VOO = VOO.ID_VOO
JOIN 
	TB_AEROPORTO AER
ON 	
	AER.ID_AEROPORTO = VOO.ID_AEROPORTO_ORIGEM
JOIN 
	TB_AEROPORTO AER2
ON	
	AER2.ID_AEROPORTO = VOO.ID_AEROPORTO_DESTINO	
WHERE OCV.ID_AERONAVE IN 
	(SELECT 
		ID_AERONAVE 
	FROM 
		TB_AERONAVE 
	WHERE 
		NM_MODELO 
	BETWEEN 700 AND 799
    )
AND 
	OCV.DT_DATA_OCORRENCIA  IS NOT NULL
ORDER BY
	OCV.DT_DATA_OCORRENCIA;

-- E) JUNÇÃO DE 2 OU MAIS TABELAS USANDO GROUP BY E FUNÇÕES AGREGADAS
-- NOME DA COMPHANIA COM A DATA DO PRIMEIRO DE O ULTIMO VOO REALIZADO
SELECT 
	CIA.NM_NOME_COMPANHIA 'NOME COMAPHINA AEREA ',
    MIN(OCV.DT_DATA_OCORRENCIA) 'DATA DO PRIMEIRO VOO REALIZADO',
    MAX(OCV.DT_DATA_OCORRENCIA)  'DATA D OULTIMO VOO REALIZADO'
FROM 
	tb_companhia_aerea CIA
JOIN 
	TB_VOO VOO
ON 
	CIA.ID_COMPANHIA_AEREA = VOO.ID_COMPANHIA_AEREA
JOIN 
	tb_ocorrencia_voo OCV
ON 
    OCV.ID_VOO = VOO.ID_VOO
GROUP BY  
    CIA.NM_NOME_COMPANHIA;
-- F)JUNÇÃO DE 2 OU MAIS TABELAS COM GROUP BY E HAVING USANDO FUNÇÃO AGREGADORA
-- LISTA DOS AEROPORTOS QUE JÁ RECEBERAM + DE 50 VOOS
SELECT 
	 aer.nm_nome_aeroporto, count(*)
FROM
	 tb_voo voo
JOIN 
	tb_ocorrencia_voo ocv
ON
	 ocv.ID_VOO = voo.ID_VOO
JOIN
	 tb_aeroporto aer
ON 
	aer.ID_AEROPORTO = voo.ID_AEROPORTO_DESTINO
GROUP BY
	 aer.NM_NOME_AEROPORTO 
HAVING COUNT(*) > 50; 

-- G) SUBSELECT SEM CORRELAÇÃO
-- LISTA COM OS NOMES DE AEROORTOS QUE ESTÃO NOS ESTADO DA CALIFORNIA OU NO ESTADO DO TEXAS 
SELECT
	NM_NOME_AEROPORTO
FROM 
	TB_AEROPORTO 
WHERE 
	ID_ENDERECO 
IN (
	SELECT 
		ID_ENDERECO
	FROM 
		TB_ENDERECO 
	WHERE 
		NM_ESTADO = 'California' 
	OR 
		NM_ESTADO = 'Texas'
    );
-- H) SUBSELECT COM CORRELAÇÃO
--  LISTA DE EMPRESAS QUE JÁ SERVIRÃO CARDAPIOS VEGETARIANOS
SELECT 
	*
FROM 
	tb_empresa_alimentacao EMA 
WHERE 
	EMA.ID_EMPRESA_ALIMENTACAO = 
 (SELECT 
 	ID_COMPANHIA_AEREA
	FROM 
		tb_servico_prestado SEP 
	WHERE 
		SEP.ID_COMPANHIA_AEREA = EMA.ID_EMPRESA_ALIMENTACAO
 	AND 
	 SEP.DS_TIPO_CARDAPIO = 'Vegetariano'
) ;
-- I) SUBSELCT COM EXISTS
-- AEROPORTOS QUE EXISTEM NO ESTADO DE NEW YORK
SELECT
	NM_NOME_AEROPORTO
FROM 
	TB_AEROPORTO 
WHERE 
	EXISTS (
	SELECT 
		ID_ENDERECO
	FROM 
		TB_ENDERECO 
	WHERE 
		NM_ESTADO = 'New York' 
    );
--G) JUNÇÃO DE 4 TABELAS OU MAIS COM ORDER BY 
-- LISTA DE AEROPORTOS QUE TIVERAM OCORRENCIA DEPOIS DO SEGUNDO SEMESTRE DE 2018 E A QUANTIDADE DE OCORRENCIAS
SELECT 
	aer.nm_nome_aeroporto,
    enr.nm_estado,
    count(VOO.ID_VOO)
FROM 
	tb_aeroporto AER
JOIN 
	TB_ENDERECO ENR
ON 
	ENR.ID_ENDERECO = AER.ID_ENDERECO
JOIN
	tb_voo VOO
ON 
	VOO.ID_AEROPORTO_ORIGEM = AER.ID_AEROPORTO
JOIN
	tb_ocorrencia_voo ocv
on 
	voo.id_voo = ocv.ID_VOO
WHERE
	OCV.DT_DATA_OCORRENCIA > '01/06/2018'
group by 
	NM_NOME_AEROPORTO
ORDER BY ENR.NM_ESTADO;