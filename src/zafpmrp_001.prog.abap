*&---------------------------------------------------------------------*
*& Report zafpmrp_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zafpmrp_001.

" - [  ] ALV
"    - [ X ] PROJETO
"    - [  ] NAVEGANDO PARA TELA PROJETO
"    - [  ] BOTÃO PARA FINALIZAR PROJETO
"    - [ X ] % DE CONCLUSÃO ( COM COR VERMELHA ( ATÉ 30% ), AMARELA ( ENTRE 31% E 99% ) E VERDE ( 100% ) )
"    - [ X ] TOTAL DE HORAS ESTIMADAS
"    - [ X ] TOTAL DE HORAS APONTADAS

TABLES: zafpmt_009,
        zafpmt_003,
        zafpmt_007.
INCLUDE zafpmrp_003.


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS s_proj FOR zafpmt_003-id.
SELECTION-SCREEN END OF BLOCK b1.

CLASS lcl_main DEFINITION INHERITING FROM lcl_alv CREATE PRIVATE.

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_alv,
             projeto        TYPE zafpmt_003-id,
             titulo         TYPE zafpmt_003-titulo,
             total_horas    TYPE int4,
             total_apontado TYPE int4,
             progresso      TYPE int4,
             progresso_txt  TYPE string,
             color          TYPE lvc_t_scol,
           END OF ty_alv.

    DATA lt_alv TYPE TABLE OF ty_alv.

    CLASS-METHODS create
      RETURNING VALUE(r_result) TYPE REF TO lcl_main.

    METHODS run.
    METHODS get_data     REDEFINITION.
    METHODS set_fieldcat REDEFINITION.

ENDCLASS.


CLASS lcl_main IMPLEMENTATION.
  METHOD create.
    r_result = NEW #( ).
  ENDMETHOD.

  METHOD run.
    get_data( ).
    display_report( CHANGING lt_alv = lt_alv ).
  ENDMETHOD.

  METHOD get_data.
    " SELECIONAR OS PROJETOS COM O SOMATÓRIO DAS HORAS ESPERADAS (TICKETS)

    SELECT z003~id,
           z003~titulo,
           SUM( z007~hours_expected ) AS expected
      FROM zafpmt_003 AS z003
             LEFT JOIN
               zafpmt_007 AS z007 ON z003~id = z007~projeto
      INTO TABLE @DATA(lt_projects)
      WHERE z003~id IN @s_proj
      GROUP BY z003~id,
               z003~titulo.

    " SOMATÓRIO DE HORAS APONTADAS POR PROJETO
    SELECT z007~projeto,
           SUM( z009~horas ) AS horas
      FROM zafpmt_009 AS z009
             LEFT JOIN
               zafpmt_007 AS z007 ON z009~ticket = z007~id
      INTO TABLE @DATA(lt_hours)
      WHERE aprovacao = 'A'
      GROUP BY z007~projeto.


    LOOP AT lt_projects REFERENCE INTO DATA(lrf_project).

      " FILTRANDO AS HORAS APONTADAS DO PROJETO
      DATA(ls_hour) = VALUE #( lt_hours[ projeto = lrf_project->id ] OPTIONAL ).

      " CALCULANDO O PROGRESSO
      DATA(lv_progresso) = ( ls_hour-horas * 100 ) / lrf_project->expected.

      " CONTROLE DE CORES
      DATA(lv_color) = COND #(
        WHEN lv_progresso >= 50 AND lv_progresso <= 99 THEN 3
        WHEN lv_progresso = 100                        THEN 5
        WHEN lv_progresso > 100                        THEN 6
        ELSE                                                4 ).
      DATA(lt_color_column) = VALUE lvc_t_scol( ( fname = `PROGRESSO_TXT` color-col = lv_color ) ).

      " ADICIONAR A LINHA AO RELATÓRIO
      APPEND VALUE ty_alv( projeto        = lrf_project->id
                           titulo         = lrf_project->titulo
                           total_horas    = lrf_project->expected
                           total_apontado = ls_hour-horas
                           progresso      = lv_progresso
                           progresso_txt  = |{ lv_progresso }%|
                           color          = lt_color_column ) TO lt_alv.

    ENDLOOP.
  ENDMETHOD.

  METHOD set_fieldcat.
    fieldcat_change( _column   = `PROJETO`
                     _longtxt  = `Projeto`
                     _position = 1 ).

    fieldcat_change( _column    = `TITULO`
                     _longtxt   = `Título`
                     _position  = 2
                     _outputlen = 27 ).

    fieldcat_change( _column    = `TOTAL_HORAS`
                     _longtxt   = `Total Horas`
                     _position  = 3
                     _outputlen = 15
                     _align     = 3 ).

    fieldcat_change( _column    = `TOTAL_APONTADO`
                     _longtxt   = `Total Apontado`
                     _position  = 4
                     _outputlen = 15
                     _align     = 3 ).

    fieldcat_change( _column  = `PROGRESSO`
                     _display = abap_false ).

    fieldcat_change( _column    = `PROGRESSO_TXT`
                     _longtxt   = `Progresso %`
                     _position  = 5
                     _outputlen = 15
                     _align     = 3 ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  lcl_main=>create( )->run( ).
