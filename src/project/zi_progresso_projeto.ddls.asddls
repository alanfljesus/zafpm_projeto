@AbapCatalog.sqlViewName: 'ZI_PROG_PROEJCT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Interface - Progresso Projeto'
define view ZI_PROGRESSO_PROJETO
  as select from ZIAFPM_PROJECT
  association [1..1] to Z_TOTAL_HORAS_APONTADA_PROJETO as _thap on $projection.Id = _thap.Projeto
  association [1..1] to Z_TOTAL_HORAS_PROJETO_CUBE     as _thpc on $projection.Id = _thpc.Projeto
{
      @EndUserText: { label: 'ID', quickInfo: 'ID' }
  key Id,
      @EndUserText: { label: 'Título', quickInfo: 'Título' }
      Titulo,
      @EndUserText: { label: 'Total Horas Apontadas', quickInfo: 'Total Horas Apontadas' }
      _thap.HorasApontadas                                       as TotalHorasApontadas,
      @EndUserText: { label: 'Total Horas', quickInfo: 'Total Horas' }
      _thpc.HoursExpected                                        as TotalHoras,
      @EndUserText: { label: 'Progresso', quickInfo: 'Progresso' }
      cast(cast(_thap.HorasApontadas * 100 as abap.decfloat34) /
      cast(_thpc.HoursExpected as abap.decfloat34) as abap.int1) as Progresso,

      /* Association */
      _thap,
      _thpc
}
