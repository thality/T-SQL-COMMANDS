 /* 
 1 = Novos
 2 = Ate 03 anos
 3 = De 04 a 08 anos
 4 = De 09 a 11 anos
 5 = Mais de 12 anos
 6 = Sem informação
 */

/* Soma quantidade idade veiculo por UF -> fato_contrato */
SELECT ds_uf, veiculo.ds_idade_veiculo, count(ds_idade_veiculo) AS quantidade
FROM [tbk].[fato_contrato]  AS  fato
INNER JOIN [tbk].[dim_idade_veiculo] AS  veiculo ON fato.cd_idade_veiculo = veiculo.cd_idade_veiculo 
 where cast(fato.dt_contrato as date) between '20210101' and '20210131' 
 and veiculo.cd_idade_veiculo = 1
 and fato.cd_mensagem_transacao = 30
 GROUP BY ds_idade_veiculo, ds_uf

/* Soma quantidade idade veiculo por UF -> fato_contrato2 */
WITH temp_fato2 as(
SELECT  *
 ,case
      when (year(DataContrato)- DsAnoFabricacao) <=  0 then 1    -- Novos
      when (year(DataContrato)- DsAnoFabricacao) <=  3 then 2    -- Ate 03 anos
      when (year(DataContrato)- DsAnoFabricacao) <=  8 then 3    -- De 04 a 08 anos
      when (year(DataContrato)- DsAnoFabricacao) <= 11 then 4    -- De 09 a 11 anos
      when (year(DataContrato)- DsAnoFabricacao)  > 11 then 5    -- Mais de 12 anos
      else 6 -- Sem informação
  end as cd_idade_veiculo
FROM [tbk].[fato_contrato2]  AS  fato2
where cast(fato2.datacontrato as date) between '20210101' and '20210131' )

select dsuf, veiculo.ds_idade_veiculo, count(veiculo.ds_idade_veiculo) AS quantidade
from temp_fato2 as tb
INNER JOIN [tbk].[dim_idade_veiculo] AS  veiculo ON tb.cd_idade_veiculo = veiculo.cd_idade_veiculo
where   veiculo.cd_idade_veiculo = 1
GROUP BY  dsuf, veiculo.ds_idade_veiculo