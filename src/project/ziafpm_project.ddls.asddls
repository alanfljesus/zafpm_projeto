@AbapCatalog.sqlViewName: 'ZVW_AFPM_PROJECT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Interface - Projeto'
define view ZIAFPM_PROJECT
  as select from zafpmt_003 as zp
  association [1..1] to zafpmt_001 as _zt001 on zp.setor = _zt001.setor
  association [1..1] to zafpmt_004 as _zt004 on zp.equipe = _zt004.id
{
  key id               as Id,
      titulo           as Titulo,
      descricao        as Descricao,
      modulo           as Modulo,
      setor            as Setor,
      _zt001.descricao as SetorTexto,
      equipe           as Equipe,
      _zt004.descricao as EquipeTexto,
      responsavel      as Responsavel,
      data_inicio      as DataInicio,
      data_fim         as DataFim,
      data_fim_real    as DataFimReal,
      criado_por       as CriadoPor,
      criado_em        as CriadoEm,
      modificado_por   as ModificadoPor,
      modificado_em    as ModificadoEm,

      /* Asssociation */
      _zt001,
      _zt004
}
