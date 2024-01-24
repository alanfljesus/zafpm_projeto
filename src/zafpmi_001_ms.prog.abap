*&---------------------------------------------------------------------*
*& Include zafpmi_001_ms
*&---------------------------------------------------------------------*

CLASS lcl_business_ms DEFINITION.
  PUBLIC SECTION.

    DATA: lt_modulos_sap TYPE TABLE OF zafpmt_002.

    METHODS:
      get_modulos_sap,
      set_modulos_sap IMPORTING VALUE(it_modulos_sap) TYPE any,
      delete_modulos_sap    IMPORTING VALUE(it_delete_rows) TYPE lvc_t_moce.

ENDCLASS.

CLASS lcl_business_ms IMPLEMENTATION.

  METHOD get_modulos_sap.
    SELECT *
      FROM zafpmt_002
      INTO TABLE lt_modulos_sap.
  ENDMETHOD.

  METHOD set_modulos_sap.

    CHECK lt_modulos_sap IS NOT INITIAL.

    GET TIME STAMP FIELD DATA(lv_timestamp).

    DATA(lt_mod_modulos_sap) = CORRESPONDING zafpmtt_002( it_modulos_sap ).

    LOOP AT lt_mod_modulos_sap INTO DATA(ls_modulos_sap).

      ls_modulos_sap-criado_em = lv_timestamp.
      ls_modulos_sap-criado_por = sy-uname.

      ls_modulos_sap-modificado_em = lv_timestamp.
      ls_modulos_sap-modificado_por = sy-uname.

      MODIFY zafpmt_002 FROM ls_modulos_sap.
    ENDLOOP.

    COMMIT WORK.

    MESSAGE 'Registros processados com sucesso!' TYPE 'S'.

  ENDMETHOD.

  METHOD delete_modulos_sap.

    CHECK it_delete_rows[] IS NOT INITIAL.

    LOOP AT it_delete_rows INTO DATA(ls_deleted_rows).
      DATA(ls_modulos_sap) = lt_modulos_sap[ ls_deleted_rows-row_id ].

      DELETE FROM zafpmt_002 WHERE modulo = ls_modulos_sap-modulo.
      CLEAR ls_modulos_sap.
    ENDLOOP.

    MESSAGE 'Registros deletados com sucesso!' TYPE 'S'.

    COMMIT WORK.
  ENDMETHOD.

ENDCLASS.
