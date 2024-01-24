@AbapCatalog.sqlViewName: 'ZC_AFPM_PROJECT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Consumer - Projetos'
define view ZC_PROJECTS
  as select from ZIAFPM_PROJECT as zp
{
      @UI: { selectionField: [{ position: 10 }],
             lineItem: [{ position: 10, label: 'ID' }] }
  key zp.Id,
      @UI: { selectionField: [{ position: 20 }],
             lineItem: [{ position: 20, label: 'Título' }] }
      zp.Titulo,
      @UI: { lineItem: [{ position: 30, label: 'Descrição' }] }
      zp.Descricao,
      @UI: { selectionField: [{ position: 30 }],
             lineItem: [{ position: 40, label: 'Módulo' }] }
      zp.Modulo,
      @UI: { selectionField: [{ position: 40 }],
             lineItem: [{ position: 50, label: 'Setor' }] }
      @ObjectModel.text.element: ['SetorTexto']
      zp.Setor,
      zp.SetorTexto,
      @UI: { selectionField: [{ position: 50 }],
             lineItem: [{ position: 60, label: 'Equipe' }] }
      @ObjectModel.text.element: ['EquipeTexto']
      @UI.textArrangement: #TEXT_ONLY
      zp.Equipe,
      zp.EquipeTexto,
      zp.Responsavel,
      zp.DataInicio,
      zp.DataFim,
      zp.DataFimReal,
      zp.CriadoPor,
      zp.CriadoEm,
      zp.ModificadoPor,
      zp.ModificadoEm,

      /* Asssociation */
      _zt001,
      _zt004
}
