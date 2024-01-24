*&---------------------------------------------------------------------*
*& Include zafpmi_001_se
*&---------------------------------------------------------------------*

CLASS lcl_business_se DEFINITION.
  PUBLIC SECTION.

    DATA: lt_setor_empresa TYPE TABLE OF zafpmt_001.

    METHODS:
      get_setor_empresa,
      set_setor_empresa IMPORTING VALUE(it_setor_empresa) TYPE any,
      delete_setor_empresa    IMPORTING VALUE(it_delete_rows) TYPE lvc_t_moce.

ENDCLASS.


CLASS lcl_business_se IMPLEMENTATION.

  METHOD get_setor_empresa.
    SELECT *
      FROM zafpmt_001
      INTO TABLE lt_setor_empresa.
  ENDMETHOD.

  METHOD set_setor_empresa.

    CHECK lt_setor_empresa IS NOT INITIAL.

    GET TIME STAMP FIELD DATA(lv_timestamp).

    DATA(lt_mod_setor_empresa) = CORRESPONDING zafpmtt_001( it_setor_empresa ).

    LOOP AT lt_mod_setor_empresa INTO DATA(ls_setor_empresa).

      ls_setor_empresa-criado_em = lv_timestamp.
      ls_setor_empresa-criado_por = sy-uname.

      ls_setor_empresa-modificado_em = lv_timestamp.
      ls_setor_empresa-modificado_por = sy-uname.

      MODIFY zafpmt_001 FROM ls_setor_empresa.
    ENDLOOP.

    COMMIT WORK.

    MESSAGE 'Registros processados com sucesso!' TYPE 'S'.

  ENDMETHOD.

  METHOD delete_setor_empresa.

    CHECK it_delete_rows[] IS NOT INITIAL.

    LOOP AT it_delete_rows INTO DATA(ls_deleted_rows).
      DATA(ls_setor_empresa) = lt_setor_empresa[ ls_deleted_rows-row_id ].

      DELETE FROM zafpmt_001 WHERE setor = ls_setor_empresa-setor.
      CLEAR ls_setor_empresa.
    ENDLOOP.

    MESSAGE 'Registros deletados com sucesso!' TYPE 'S'.

    COMMIT WORK.
  ENDMETHOD.


ENDCLASS.
