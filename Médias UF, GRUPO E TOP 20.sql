

select  agente.ds_grupo, COUNT(tbk.fato_contrato.cd_contrato) as quantidade
from tbk.fato_contrato 
INNER JOIN [tbk].[dim_agente] as agente ON tbk.fato_contrato .cd_agente = agente.cd_agente
where cast(dt_contrato as date) between '2021-01-01' and '2021-01-31'
and cd_retorno_transacao = 30
GROUP BY agente.ds_grupo
order by count(agente.nu_cnpj) desc

select   trim(dsuf) as UF , COUNT(1) as Quantidade
from tbk.fato_contrato2 
where cast(datacontrato as date) between '2021-01-01' and '2021-01-31'
and cdmensagemtransacao = 30
GROUP BY trim(dsuf)