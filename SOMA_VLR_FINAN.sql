
-- SOMA VALOR FINANCIAMENTO POR FAIXA DE FINANCIAMENTO , ALTERE O NUMERO DE ENTRADA DO [cd_faixa_financiamento] PARA AS DEMAIS FAIXAS
select sum(fc.vl_total_financiamento) as QUANTIDADE 
from [tbk].[fato_contrato3] as fc
INNER JOIN [tbk].[dim_contrato] AS tra on tra.cd_contrato = fc.cd_contrato
INNER JOIN [tbk].[dim_faixa_financiamento] as fin on fin.[cd_faixa_financiamento] = fc.[cd_faixa_financiamento]
where cast(fc.dt_contrato as date) between '20210101' and '20210131'  and fc.[cd_faixa_financiamento] = 1
and tra.ic_flag_transacao in (1,2,4) and fc.[cd_mensagem_transacao] = 30


/*SOMA VALOR FINANCIAMENTO POR UF E MODELO DE NEGOCIO, USE "Integra+, WebSite, WebService Rest, Lote". ALTERE O NUMERO DE ENTRADA 
DO [cd_faixa_financiamento] PARA AS DEMAIS FAIXAS*/

select  (fc.ds_uf), count(fc.ds_uf), (canal.ds_canalservico) 
from [tbk].[fato_contrato3] as fc
INNER JOIN [tbk].[dim_contrato] AS tra on tra.cd_contrato = fc.cd_contrato
INNER JOIN [tbk].[dim_faixa_financiamento] as fin on fin.[cd_faixa_financiamento] = fc.[cd_faixa_financiamento]
INNER JOIN [tbk].[dim_canal_servico] AS canal on canal.cd_canalservico = fc.cd_canal_servico
where cast(fc.dt_contrato as date) between '20210101' and '20210131'  and fc.[cd_faixa_financiamento] = 1
and tra.ic_flag_transacao in (1,2,4) and fc.[cd_mensagem_transacao] = 30 and  canal.ds_canalservico = 'Lote'
GROUP BY (fc.ds_uf), fc.ds_uf, canal.ds_canalservico


-- SOMA DE UF'S POR VALOR TOTAL FINANCIAMENTO
select count(1)
from [tbk].[fato_contrato3] as fc
INNER JOIN [tbk].[dim_contrato] AS tra on tra.cd_contrato = fc.cd_contrato
INNER JOIN [tbk].[dim_faixa_financiamento] as fin on fin.[cd_faixa_financiamento] = fc.[cd_faixa_financiamento]
INNER JOIN [tbk].[dim_canal_servico] AS canal on canal.cd_canalservico = fc.cd_canal_servico
where cast(fc.dt_contrato as date) between '20210101' and '20210131'  and fc.[cd_faixa_financiamento] = 6
and tra.ic_flag_transacao in (1,2,4) and fc.[cd_mensagem_transacao] = 30 and  canal.ds_canalservico = 'Integra+'

--------------------FX VLR FINANCIADO X REGIAO---------------
--'BA','PI', 'PE', 'PB'
--'AC', 'RR'
--'SP', 'RJ', 'MG'
--'SC', 'PR'
select  count (1) as total
from [tbk].[fato_contrato3] as fc
INNER JOIN [tbk].[dim_contrato] AS tra on tra.cd_contrato = fc.cd_contrato
INNER JOIN [tbk].[dim_faixa_financiamento] as fin on fin.[cd_faixa_financiamento] = fc.[cd_faixa_financiamento]
INNER JOIN [tbk].[dim_canal_servico] AS canal on canal.cd_canalservico = fc.cd_canal_servico
where cast(fc.dt_contrato as date) between '20210101' and '20210131'  and fc.[cd_faixa_financiamento] = 6
and tra.ic_flag_transacao in (1,2,4) and fc.[cd_mensagem_transacao] = 30 and  canal.ds_canalservico = 'WebService Rest'
and fc.ds_uf in ('BA','PI', 'PE', 'PB')

---'WebService Rest'  'WebSite'
---'Lote' 
---'Integra+'
----------------------- FX VLR FINANCIADO X PRODUTO TBK ----------------------------------------
select  prod.ds_produto, count (1) as total, fc.[cd_faixa_financiamento]
from [tbk].[fato_contrato3] as fc
INNER JOIN [tbk].[dim_contrato] AS tra on tra.cd_contrato = fc.cd_contrato
INNER JOIN [tbk].[dim_faixa_financiamento] as fin on fin.[cd_faixa_financiamento] = fc.[cd_faixa_financiamento]
INNER JOIN [tbk].[dim_canal_servico] AS canal on canal.cd_canalservico = fc.cd_canal_servico
INNER JOIN [tbk].[dim_produto] as prod on fc.[cd_produto] = prod.[cd_produto]
where 
cast(fc.dt_contrato as date) between '20210101' and '20210131'  
and fc.[cd_faixa_financiamento] in (1,2,3,4,5,6)
and tra.ic_flag_transacao in (1,2,4) 
and fc.[cd_mensagem_transacao] = 30 
and prod.ds_produto = 'eContrato'
AND canal.[ds_canalservico] = 'WebService Rest'
group by prod.ds_produto, fc.[cd_faixa_financiamento]

---'WebService Rest'  'WebSite'
---'Lote' 
---'Integra+'

----------------------------------------FX VLR FINANCIADO X PRODUTO FINANCIADO-----------------------------------------------------------
select   fc.[cd_faixa_financiamento], count (1) as total
from [tbk].[fato_contrato3] as fc
INNER JOIN [tbk].[dim_contrato] AS tra on tra.cd_contrato = fc.cd_contrato
INNER JOIN [tbk].[dim_faixa_financiamento] as fin on fin.[cd_faixa_financiamento] = fc.[cd_faixa_financiamento]
INNER JOIN [tbk].[dim_canal_servico] AS canal on canal.cd_canalservico = fc.cd_canal_servico
INNER JOIN [tbk].[dim_produto] as prod on fc.[cd_produto] = prod.[cd_produto]
where 
cast(fc.dt_contrato as date) between '20210101' and '20210131'  
and fc.[cd_faixa_financiamento] in (1,2,3,4,5,6)
and tra.ic_flag_transacao in (1,2,4) 
and fc.[cd_mensagem_transacao] = 30 
AND fc.cd_tipo_restricao = 1
AND canal.[ds_canalservico] = 'WebService Rest'
group by  fc.[cd_faixa_financiamento]

---'WebService Rest'  'WebSite'
---'Lote' 
---'Integra+'

------------------------------ GRUPOOO ------------------
select  agente.ds_grupo, count (agente.nu_cnpj) as total
from [tbk].[fato_contrato3] as fc
INNER JOIN [tbk].[dim_contrato] AS tra on tra.cd_contrato = fc.cd_contrato
INNER JOIN [tbk].[dim_faixa_financiamento] as fin on fin.[cd_faixa_financiamento] = fc.[cd_faixa_financiamento]
INNER JOIN [tbk].[dim_canal_servico] AS canal on canal.cd_canalservico = fc.cd_canal_servico
INNER JOIN [tbk].[dim_agente] as agente on agente.cd_agente = fc.cd_agente
where 
cast(fc.dt_contrato as date) between '20210101' and '20210131'  
and fc.[cd_faixa_financiamento] = 6
and tra.ic_flag_transacao in (1,2,4) 
and fc.[cd_mensagem_transacao] = 30 
AND canal.[ds_canalservico] = 'Lote'
group by  agente.ds_grupo
order by  count (agente.nu_cnpj) desc

--------------- GRUPO COUNT GERAL
select count (agente.nu_cnpj) as total
from [tbk].[fato_contrato3] as fc
INNER JOIN [tbk].[dim_contrato] AS tra on tra.cd_contrato = fc.cd_contrato
INNER JOIN [tbk].[dim_faixa_financiamento] as fin on fin.[cd_faixa_financiamento] = fc.[cd_faixa_financiamento]
INNER JOIN [tbk].[dim_canal_servico] AS canal on canal.cd_canalservico = fc.cd_canal_servico
INNER JOIN [tbk].[dim_agente] as agente on agente.cd_agente = fc.cd_agente
where 
cast(fc.dt_contrato as date) between '20210101' and '20210131'  
and fc.[cd_faixa_financiamento] IN (1,2,3,4,5,6)
and tra.ic_flag_transacao in (1,2,4) 
and fc.[cd_mensagem_transacao] = 30 
--AND canal.[ds_canalservico] = 'WebSite'