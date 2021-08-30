select fato.*,
  case
    when fato.cd_tipo_restricao = 0 then 'Sem Informação'
    when fato.cd_tipo_restricao = 1 then 'Leasing'
    when fato.cd_tipo_restricao = 2 then 'Reserva de domínio'
    when fato.cd_tipo_restricao = 3 then 'CDC'
    when fato.cd_tipo_restricao = 4 then 'Penhor'
    when fato.cd_tipo_restricao = 9 then 'Penhor'
    else 'Sem informação' end as classificacaoB   
	INTO #fatoclassificacao1
FROM [tbk].[fato_contrato]  AS  fato
WHERE cast(fato.dt_contrato as date) between '20210101' and '20210131' 


select cont.ds_uf,  count(rest.cd_tipo_restricao) AS Quantidade 
from [tbk].[fato_contrato] as fc
INNER JOIN [tbk].[dim_tipo_restricao_financeira] AS rest on rest.[cd_tipo_restricao] = fc.[cd_tipo_restricao_financeira]
INNER JOIN [tbk].[dim_entidade] AS cont on cont.cd_entidade = fc.cd_entidade
INNER JOIN [tbk].[dim_contrato] AS tra on tra.cd_contrato = fc.cd_contrato
where cast(fc.dt_contrato as date) between '20210101' and '20210131' and rest.cd_tipo_restricao = 1
and  tra.ic_flag_transacao in (1,2,4)
GROUP BY  cont.ds_uf, rest.cd_tipo_restricao 

select fc.ds_uf, count(fc.cd_tipo_restricao_financeira) AS Quantidade
from [tbk].[fato_contrato] as fc
INNER JOIN [tbk].[dim_contrato] AS tra on tra.cd_contrato = fc.cd_contrato
where cast(fc.dt_contrato as date) between '20210101' and '20210131' and fc.cd_tipo_restricao_financeira = 3
and tra.ic_flag_transacao in (1,2,4) and fc.cd_retorno_transacao = 30
GROUP BY fc.ds_uf, fc.cd_tipo_restricao_financeira






and  and fc.cd_tipo_restricao = 1 and  ic_flag_transacao in (1,2,3,4)
GROUP BY  fc.ds_uf, fc.cd_tipo_restricao , fin.ds_produto


select cont.ds_uf,  count(rest.cd_tipo_restricao) AS Quantidade 
from [tbk].[fato_contrato2] as fc
INNER JOIN [tbk].[dim_tipo_restricao_financeira] AS rest on rest.[cd_tipo_restricao] = fc.[cd_tipo_restricao_financeira]
INNER JOIN [tbk].[dim_entidade] AS cont on cont.cd_entidade = fc.cd_entidade
INNER JOIN 
where cast(fc.DtContrato as date) between '20210101' and '20210131' and rest.cd_tipo_restricao = 1
GROUP BY  cont.ds_uf, rest.cd_tipo_restricao 


------------- PROD FINANCIADO X REGIAO -----------
select count(fc.cd_tipo_restricao_financeira) AS Quantidade
from [tbk].[fato_contrato] as fc
INNER JOIN [tbk].[dim_contrato] AS tra on tra.cd_contrato = fc.cd_contrato
where cast(fc.dt_contrato as date) between '20210101' and '20210131' and fc.cd_tipo_restricao_financeira = 2
and tra.ic_flag_transacao in (1,2,4) and fc.cd_retorno_transacao = 30 and fc.ds_uf in ('SC', 'PR')
--'BA','PI', 'PE', 'PB'
--'AC', 'RR'
--'SP', 'RJ', 'MG'

---------------- GRUPO ---------------------
select agente.ds_grupo, COUNT(agente.cd_agente) AS QUANTIDADE 
from tbk.fato_contrato 
INNER JOIN [tbk].[dim_agente] as agente ON tbk.fato_contrato .cd_agente = agente.cd_agente
INNER JOIN [tbk].[dim_tipo_restricao_financeira] AS rest on rest.[cd_tipo_restricao] = tbk.fato_contrato.[cd_tipo_restricao]
INNER JOIN [tbk].[dim_contrato] AS tra on tra.cd_contrato = tbk.fato_contrato .cd_contrato
where cast(tbk.fato_contrato .dt_contrato as date) between '2021-01-01' and '2021-01-31'  and cd_retorno_transacao = 30
and agente.ds_grupo is not null
and tbk.fato_contrato.cd_tipo_restricao in (4,9) 
and  tra.ic_flag_transacao in (1,2,4)
GROUP BY  agente.ds_grupo
order by count(agente.nu_cnpj) desc

---------------- GRUPO count geral ---------------------
select COUNT(agente.cd_agente) AS QUANTIDADE 
from tbk.fato_contrato 
INNER JOIN [tbk].[dim_agente] as agente ON tbk.fato_contrato .cd_agente = agente.cd_agente
INNER JOIN [tbk].[dim_tipo_restricao_financeira] AS rest on rest.[cd_tipo_restricao] = tbk.fato_contrato.[cd_tipo_restricao]
INNER JOIN [tbk].[dim_contrato] AS tra on tra.cd_contrato = tbk.fato_contrato .cd_contrato
where cast(tbk.fato_contrato .dt_contrato as date) between '2021-01-01' and '2021-01-31'  and cd_retorno_transacao = 30
and agente.ds_grupo is not null
--and tbk.fato_contrato.cd_tipo_restricao = 2
and  tra.ic_flag_transacao in (1,2,4)
order by count(agente.nu_cnpj) desc