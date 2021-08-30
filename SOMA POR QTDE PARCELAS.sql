
select distinct ds_qtd_parcelas from tbk.fato_contrato 


---------------- QTD PARCELAS X GRUPO ------------
select agente.ds_grupo, COUNT(agente.nu_cnpj) AS QUANTIDADE
from tbk.fato_contrato 
INNER JOIN [tbk].[dim_agente] as agente ON tbk.fato_contrato .cd_agente = agente.cd_agente
INNER JOIN [tbk].[dim_canal_servico]  ON [tbk].[fato_contrato].[cd_canal_servico]   = [tbk].[dim_canal_servico].[cd_canalservico]
where cast(dt_contrato as date) between '2021-01-01' and '2021-01-31'  and cd_retorno_transacao = 30
AND [tbk].[fato_contrato].ds_qtd_parcelas = '24'
AND [ds_canalservico] = 'WebService Rest'
GROUP BY  agente.ds_grupo
order by count(agente.nu_cnpj) desc

select COUNT(agente.nu_cnpj) AS QUANTIDADE
from tbk.fato_contrato 
INNER JOIN [tbk].[dim_agente] as agente ON tbk.fato_contrato .cd_agente = agente.cd_agente
INNER JOIN [tbk].[dim_canal_servico]  ON [tbk].[fato_contrato].[cd_canal_servico]   = [tbk].[dim_canal_servico].[cd_canalservico]
where cast(dt_contrato as date) between '2021-01-01' and '2021-01-31'  and cd_retorno_transacao = 30
AND [tbk].[fato_contrato].ds_qtd_parcelas = '12'
AND [ds_canalservico] = 'Lote'




------------ QUANTIDADE DE REGISTROS POR QTD PARCELAS --------
select  COUNT(1) AS QUANTIDADE
from tbk.fato_contrato 
INNER JOIN [tbk].[dim_parcelas]  ON [tbk].[fato_contrato].[cd_qtd_parcelas]  = [tbk].[dim_parcelas].[cd_qtd_parcelas]
where cast(dt_contrato as date) between '2021-01-01' and '2021-01-31'  and cd_retorno_transacao = 30
AND [ds_parcelas] = '36 Parcelas'


---------------- QTD PARCELAS X UF -----------------
select tbk.fato_contrato.ds_uf, count([tbk].[dim_canal_servico].[ds_canalservico]) 
from tbk.fato_contrato
INNER JOIN [tbk].[dim_canal_servico]  ON [tbk].[fato_contrato].[cd_canal_servico]   = [tbk].[dim_canal_servico].[cd_canalservico]
INNER JOIN [tbk].[dim_parcelas]  ON [tbk].[fato_contrato].[cd_qtd_parcelas]  = [tbk].[dim_parcelas].[cd_qtd_parcelas]
where cast(dt_contrato as date) between '2021-01-01' and '2021-01-31' and cd_retorno_transacao = 30
AND [ds_canalservico] = 'WebSite' AND [ds_parcelas] = 'Acima de 72 Parcelas'
group by [ds_canalservico], ds_uf


-----------------------------------------
select  count([tbk].[dim_canal_servico].[ds_canalservico]) 
from tbk.fato_contrato
INNER JOIN [tbk].[dim_canal_servico]  ON [tbk].[fato_contrato].[cd_canal_servico]   = [tbk].[dim_canal_servico].[cd_canalservico]
INNER JOIN [tbk].[dim_parcelas]  ON [tbk].[fato_contrato].[cd_qtd_parcelas]  = [tbk].[dim_parcelas].[cd_qtd_parcelas]
where cast(dt_contrato as date) between '2021-01-01' and '2021-01-31' and cd_retorno_transacao = 30
AND [ds_parcelas] = '36 Parcelas' AND [ds_canalservico] = 'WebSite'

------------------------QTD PARCELAS X PRODUTO TBK-------------
select ([tbk].[dim_canal_servico].[ds_canalservico]), count(prod.cd_produto)
from tbk.fato_contrato3 as fato
INNER JOIN [tbk].[dim_canal_servico]  ON fato.[cd_canal_servico]   = [tbk].[dim_canal_servico].[cd_canalservico]
INNER JOIN [tbk].[dim_parcelas]  ON fato.[cd_qtd_parcelas]  = [tbk].[dim_parcelas].[cd_qtd_parcelas]
INNER JOIN [tbk].[dim_produto] as prod on fato.[cd_produto] = prod.[cd_produto]
where cast(dt_contrato as date) between '2021-01-01' and '2021-01-31' and fato.cd_mensagem_transacao = 30 
AND [tbk].[dim_canal_servico].[ds_canalservico] = 'WebService Rest' AND [tbk].[dim_parcelas].[ds_parcelas] = 'Acima de 72 Parcelas' 
and prod.ds_produto = 'eContrato'
group by [ds_canalservico]


------------------------------QTD PARCELAS X PRODUTO FINANCIADO---------------
select ([tbk].[dim_canal_servico].[ds_canalservico]), finan.ds_tipo_restricao, finan.cd_tipo_restricao, count(1)
from tbk.fato_contrato3 as fato
INNER JOIN [tbk].[dim_canal_servico]  ON fato.[cd_canal_servico]   = [tbk].[dim_canal_servico].[cd_canalservico]
INNER JOIN [tbk].[dim_parcelas]  ON fato.[cd_qtd_parcelas]  = [tbk].[dim_parcelas].[cd_qtd_parcelas]
INNER JOIN [tbk].[dim_tipo_restricao_financeira] AS finan on fato.cd_tipo_restricao = finan.cd_tipo_restricao
where cast(dt_contrato as date) between '2021-01-01' and '2021-01-31' and fato.cd_mensagem_transacao = 30 
AND [tbk].[dim_canal_servico].[ds_canalservico] = 'WebSite' AND [tbk].[dim_parcelas].[ds_parcelas] = '12 parcelas' 
and fato.cd_tipo_restricao in (1,2,3,4,9) and fato.ic_flag_transacao in (1,2,4)
group by [ds_canalservico], finan.ds_tipo_restricao, finan.cd_tipo_restricao


select  count(1)
from tbk.fato_contrato3 as fato
INNER JOIN [tbk].[dim_canal_servico]  ON fato.[cd_canal_servico]   = [tbk].[dim_canal_servico].[cd_canalservico]
INNER JOIN [tbk].[dim_parcelas]  ON fato.[cd_qtd_parcelas]  = [tbk].[dim_parcelas].[cd_qtd_parcelas]
INNER JOIN [tbk].[dim_tipo_restricao_financeira] AS finan on fato.cd_tipo_restricao = finan.cd_tipo_restricao
where cast(dt_contrato as date) between '2021-01-01' and '2021-01-31' and fato.cd_mensagem_transacao = 30 
AND [tbk].[dim_canal_servico].[ds_canalservico] = 'WebSite' 
and fato.cd_tipo_restricao in (1,2,3,4,9) and fato.ic_flag_transacao in (1,2,4)

select top 100 * from [tbk].[dim_parcelas]

select top 100 * from [tbk].[dim_agente]