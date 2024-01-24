*&---------------------------------------------------------------------*
*& Report zafpmrp_002
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zafpmrp_002.

" - [  ] ALV
"    - [  ] EQUIPE
"    - [  ] % DE EFICÁCIA (COM COR VERMELHA (ATÉ 30%), AMARELA (ENTRE 31% E 99%) E VERDE (100%)
"    - [  ] TOTAL PROJETOS
"    - [  ] TOTAL PROJETOS DENTRO E FORA DO PRAZO

TABLES: zafpmt_003, zafpmt_004, zafpmt_009.
INCLUDE zafpmrp_003.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  SELECT-OPTIONS s_squad FOR zafpmt_004-id.
SELECTION-SCREEN END OF BLOCK b1.


CLASS lcl_main DEFINITION INHERITING FROM lcl_alv CREATE PRIVATE.

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_alv,
             equipe              TYPE zafpmt_004-id,
             equipe_descricao    TYPE zafpmt_004-descricao,
             quantidade_projetos TYPE int4,
             projetos_prazo      TYPE int4,
             projetos_fora_prazo TYPE int4,
             eficacia_equipe     TYPE string,
             eficacia_equipe_txt TYPE string,
             color               TYPE lvc_t_scol,
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
    " SELECIONAR AS EQUIPES
    SELECT * FROM zafpmt_004
      INTO TABLE @DATA(lt_squads)
      WHERE id IN @s_squad.

    " SELECIONAR OS PROJETOS E AS HORAS ESTIMADAS
    SELECT z003~id,
           z003~equipe,
           SUM( z007~hours_expected ) AS expected
      FROM zafpmt_003 AS z003
             LEFT JOIN
               zafpmt_007 AS z007 ON z003~id = z007~projeto
      INTO TABLE @DATA(lt_project)
      WHERE z003~id IN @s_squad
      GROUP BY z003~id,
               z003~equipe.

    " SELECIONAR O SOMATÓRIO DAS HORAS APONTADAS DE CADA PROJETO
    IF lt_project[] IS NOT INITIAL.

      SELECT z007~projeto,
             SUM( z009~horas ) AS horas
        FROM                                  zafpmt_009 AS z009
        JOIN zafpmt_007
             AS z007 ON z009~ticket = z007~id
        INTO TABLE @DATA(lt_hours_by_project)
        GROUP BY z007~projeto.

    ENDIF.

    " ALIMENTAR O ALV DE SAÍDA
    LOOP AT lt_squads REFERENCE INTO DATA(lrf_squads).

      " QUANTIDADE DE PROJETOS DA EQUIPE
      DATA(lv_qtd_projetos_equipe) = REDUCE i( INIT count = 0
                                             FOR ls_project IN lt_project
                                             WHERE ( equipe = lrf_squads->id )
                                             NEXT count += 1 ).

      " PROJETOS NO PRAZO
      DATA(lv_qtd_projetos_no_prazo) = 0.

      " PROJETOS ATRASADOS
      DATA(lv_qtd_projetos_fora_prazo) = 0.

      LOOP AT lt_project REFERENCE
           INTO DATA(lrf_project)
           WHERE equipe = lrf_squads->id.

        " TOTAL DE HORAS APONTADAS NO PROJETO
        DATA(ls_hour) = VALUE #( lt_hours_by_project[ projeto = lrf_project->id ] OPTIONAL ).

        IF ls_hour-horas <= lrf_project->expected.
          lv_qtd_projetos_no_prazo += 1.
        ELSE.
          lv_qtd_projetos_fora_prazo += 1.
        ENDIF.

        CLEAR ls_hour.
      ENDLOOP.

      " DECLARAR EFICÁCIA DA EQUIPE
      DATA(lv_eficacia) = ( lv_qtd_projetos_no_prazo * 100 ) / lv_qtd_projetos_equipe.

      DATA(lv_color) = COND #( WHEN lv_eficacia >= 1 AND lv_eficacia < 99 THEN 3
                               WHEN lv_eficacia = 100                     THEN 5
                               ELSE                                            6 ).
      DATA(lt_color_column) = VALUE lvc_t_scol(
          ( fname = `EFICACIA_EQUIPE_TXT` color-col = lv_color color-int = 0 color-inv = 0 ) ).

      APPEND VALUE ty_alv( equipe              = lrf_squads->id
                           equipe_descricao    = lrf_squads->descricao
                           quantidade_projetos = lv_qtd_projetos_equipe
                           projetos_prazo      = lv_qtd_projetos_no_prazo
                           projetos_fora_prazo = lv_qtd_projetos_fora_prazo
                           eficacia_equipe     = lv_eficacia
                           eficacia_equipe_txt = |{ lv_eficacia }%|
                           color               = lt_color_column )
             TO lt_alv.

    ENDLOOP.
  ENDMETHOD.

  METHOD set_fieldcat.
    fieldcat_change( _column   = `EQUIPE`
                     _longtxt  = `Equipe`
                     _position = 1 ).

    fieldcat_change( _column    = `EQUIPE_DESCRICAO`
                     _longtxt   = `Descrição`
                     _position  = 2
                     _outputlen = 25 ).

    fieldcat_change( _column    = `QUANTIDADE_PROJETOS`
                     _longtxt   = `Qtd Projetos`
                     _position  = 3
                     _outputlen = 15
                     _align     = 3 ).

    fieldcat_change( _column    = `PROJETOS_PRAZO`
                     _longtxt   = `Projetos no Prazo`
                     _position  = 4
                     _outputlen = 15
                     _align     = 3 ).

    fieldcat_change( _column    = `PROJETOS_FORA_PRAZO`
                     _longtxt   = `Projetos Fora Prazo`
                     _position  = 5
                     _outputlen = 15
                     _align     = 3 ).

    fieldcat_change( _column  = `EFICACIA_EQUIPE`
                     _display = abap_false ).

    fieldcat_change( _column    = `EFICACIA_EQUIPE_TXT`
                     _longtxt   = `Eficácia %`
                     _position  = 6
                     _outputlen = 15
                     _align     = 3 ).
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  lcl_main=>create( )->run( ).
