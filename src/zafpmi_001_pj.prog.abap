*&---------------------------------------------------------------------*
*& Include zafpmi_001_pj
*&---------------------------------------------------------------------*

CLASS lcl_business_pj DEFINITION.
  PUBLIC SECTION.

    DATA: lt_projetos        TYPE TABLE OF zafpmt_003,
          lo_projeto_negocio TYPE REF TO zafpmcl_002.

    METHODS:
      constructor,
      get_projetos,
      set_projetos IMPORTING VALUE(it_projetos) TYPE any,
      delete_projetos    IMPORTING VALUE(it_delete_rows) TYPE lvc_t_moce.

ENDCLASS.

CLASS lcl_business_pj IMPLEMENTATION.

  METHOD constructor.

    lo_projeto_negocio = NEW zafpmcl_002( iv_table = 'ZAFPMT_003').

  ENDMETHOD.

  METHOD get_projetos.

    lo_projeto_negocio->read( IMPORTING et_data = lt_projetos ).

*    SELECT *
*      FROM zafpmt_003
*      INTO TABLE lt_projetos.
  ENDMETHOD.

  METHOD set_projetos.

    CHECK lt_projetos IS NOT INITIAL.

    GET TIME STAMP FIELD DATA(lv_timestamp).

    DATA(lt_mod_projetos) = CORRESPONDING zafpmtt_003( it_projetos ).

    LOOP AT lt_mod_projetos INTO DATA(ls_projetos).

      IF ls_projetos-id EQ space.
        DATA(ls_return_create) = lo_projeto_negocio->create( CHANGING cs_data = ls_projetos ).
      ELSE.
        DATA(ls_return_update) = lo_projeto_negocio->update( CHANGING cs_data = ls_projetos ).
      ENDIF.

      MESSAGE ls_return_create-message TYPE ls_return_create-type.
*      ls_projetos-criado_em = lv_timestamp.
*      ls_projetos-criado_por = sy-uname.
*
*      ls_projetos-modificado_em = lv_timestamp.
*      ls_projetos-modificado_por = sy-uname.
*
*      MODIFY zafpmt_003 FROM ls_projetos.
    ENDLOOP.

    COMMIT WORK.

    MESSAGE 'Registros processados com sucesso!' TYPE 'S'.

  ENDMETHOD.

  METHOD delete_projetos.

    CHECK it_delete_rows[] IS NOT INITIAL.

    LOOP AT it_delete_rows INTO DATA(ls_deleted_rows).
      DATA(ls_projetos) = lt_projetos[ ls_deleted_rows-row_id ].

*      DELETE FROM zafpmt_003 WHERE modulo = ls_projetos-id.
      DATA(ls_return_delete) = lo_projeto_negocio->delete( EXPORTING cs_data = ls_projetos ).
      CLEAR ls_projetos.
    ENDLOOP.

    MESSAGE 'Registros deletados com sucesso!' TYPE 'S'.

    COMMIT WORK.
  ENDMETHOD.

ENDCLASS.
