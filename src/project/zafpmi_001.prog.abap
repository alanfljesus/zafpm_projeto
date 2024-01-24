*&---------------------------------------------------------------------*
*& Modulpool ZAFPMI_001
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
PROGRAM zafpmi_001.

DATA: custom_container TYPE REF TO cl_gui_custom_container,
      grid_alv         TYPE REF TO cl_gui_alv_grid.

INCLUDE:zafpmi_001_se,
        zafpmi_001_ms,
        zafpmi_001_pj.

" CLASSE DE NEGÓCIO
CLASS lcl_business DEFINITION.

  PUBLIC SECTION.

    DATA: lo_business_se TYPE REF TO lcl_business_se,
          lo_business_ms TYPE REF TO lcl_business_ms,
          lo_business_pj TYPE REF TO lcl_business_pj.

    DATA: lv_screen        TYPE string.

    METHODS:
      constructor IMPORTING VALUE(iv_screen) TYPE string,
      run,
      run_project,
      run_setor_empresa,
      run_modulo_sap,
      refresh,
      active_change_handle,
      handle_data_changed FOR EVENT data_changed OF cl_gui_alv_grid
        IMPORTING er_data_changed.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

DATA: go_custom_control TYPE REF TO cl_gui_custom_container,
      go_grid           TYPE REF TO cl_gui_alv_grid,
      gt_fieldcat       TYPE lvc_t_fcat,
      gs_layout         TYPE lvc_s_layo.

CLASS lcl_business IMPLEMENTATION.

  METHOD constructor.
    lv_screen = iv_screen.
    lo_business_ms = NEW lcl_business_ms(  ).
    lo_business_se = NEW lcl_business_se(  ).
    lo_business_pj = NEW lcl_business_pj(  ).
  ENDMETHOD.

  METHOD run.
    CALL METHOD (lv_screen).
  ENDMETHOD.

  METHOD run_project.

    CHECK go_custom_control IS INITIAL.

    " ATRELANDO O COMPONENTE DE TELA A UM OBJETO ABAP
    go_custom_control = NEW cl_gui_custom_container( 'CC_PROJETO' ).

    " ATRELANDO A GRID A UM OBJETO ABAP DE TELA
    go_grid = NEW cl_gui_alv_grid( i_parent = go_custom_control ).

    " CARREGANDO CONFIGURAÇÕES PADRÕES DAS COLUNAS
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = 'ZAFPMT_003'
      CHANGING
        ct_fieldcat      = gt_fieldcat.

    LOOP AT gt_fieldcat ASSIGNING FIELD-SYMBOL(<fs_fieldcat>).
      CASE <fs_fieldcat>-fieldname.
        WHEN 'ID'.
        WHEN 'TITULO'.
          <fs_fieldcat>-outputlen = 15.
          <fs_fieldcat>-edit      = 'X'.
        WHEN 'DESCRICAO'.
          <fs_fieldcat>-outputlen = 15.
          <fs_fieldcat>-edit      = 'X'.
        WHEN 'MODULO'.
          <fs_fieldcat>-outputlen = 15.
          <fs_fieldcat>-edit      = 'X'.
        WHEN 'SETOR'.
          <fs_fieldcat>-outputlen = 15.
          <fs_fieldcat>-edit      = 'X'.
        WHEN 'EQUIPE'.
          <fs_fieldcat>-outputlen = 15.
          <fs_fieldcat>-edit      = 'X'.
        WHEN 'RESPONSAVEL'.
          <fs_fieldcat>-outputlen = 15.
          <fs_fieldcat>-edit      = 'X'.
        WHEN 'DATA_INICIO'.
          <fs_fieldcat>-outputlen = 15.
          <fs_fieldcat>-edit      = 'X'.
        WHEN 'DATA_FIM'.
          <fs_fieldcat>-outputlen = 15.
          <fs_fieldcat>-edit      = 'X'.
        WHEN 'DATA_FIM_REAL'.
          <fs_fieldcat>-outputlen = 15.
          <fs_fieldcat>-edit      = 'X'.
        WHEN 'MODIFICADO_EM'.
          <fs_fieldcat>-reptext   = 'Mod. Em'.
          <fs_fieldcat>-scrtext_s = 'Mod. Em'.
          <fs_fieldcat>-scrtext_m = 'Modificado Em'.
          <fs_fieldcat>-scrtext_l = 'Modificado Em'.
        WHEN 'MODIFICADO_POR'.
          <fs_fieldcat>-reptext   = 'Mod. Por'.
          <fs_fieldcat>-scrtext_s = 'Mod. Por'.
          <fs_fieldcat>-scrtext_m = 'Modificado Por'.
          <fs_fieldcat>-scrtext_l = 'Modificado Por'.
        WHEN OTHERS .
          <fs_fieldcat>-no_out = 'X'.
      ENDCASE.
    ENDLOOP.

    " INICIANDO A GRID
    go_grid->set_table_for_first_display(
        EXPORTING
            i_structure_name = 'ZAFPMT_003'
            is_layout        = gs_layout
        CHANGING
            it_fieldcatalog  = gt_fieldcat
            it_outtab        = lo_business_pj->lt_projetos
    ).

    SET HANDLER handle_data_changed FOR go_grid.

    refresh(  ).

  ENDMETHOD.

  METHOD run_setor_empresa.

    CHECK go_custom_control IS INITIAL.

    " ATRELANDO O COMPONENTE DE TELA A UM OBJETO ABAP
    go_custom_control = NEW cl_gui_custom_container( 'CC_SETOR_EMPRESA' ).

    " ATRELANDO A GRID A UM OBJETO ABAP DE TELA
    go_grid = NEW cl_gui_alv_grid( i_parent = go_custom_control ).

    " CARREGANDO CONFIGURAÇÕES PADRÕES DAS COLUNAS
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = 'ZAFPMT_001'
      CHANGING
        ct_fieldcat      = gt_fieldcat.

    LOOP AT gt_fieldcat ASSIGNING FIELD-SYMBOL(<fs_fieldcat>).
      CASE <fs_fieldcat>-fieldname.
        WHEN 'SETOR'.
          <fs_fieldcat>-just      = 'C'.
          <fs_fieldcat>-edit      = 'X'.
        WHEN 'DESCRICAO'.
          <fs_fieldcat>-outputlen = 15.
          <fs_fieldcat>-edit      = 'X'.
        WHEN 'MODIFICADO_EM'.
          <fs_fieldcat>-reptext   = 'Mod. Em'.
          <fs_fieldcat>-scrtext_s = 'Mod. Em'.
          <fs_fieldcat>-scrtext_m = 'Modificado Em'.
          <fs_fieldcat>-scrtext_l = 'Modificado Em'.
        WHEN 'MODIFICADO_POR'.
          <fs_fieldcat>-reptext   = 'Mod. Por'.
          <fs_fieldcat>-scrtext_s = 'Mod. Por'.
          <fs_fieldcat>-scrtext_m = 'Modificado Por'.
          <fs_fieldcat>-scrtext_l = 'Modificado Por'.
        WHEN OTHERS .
          <fs_fieldcat>-no_out = 'X'.
      ENDCASE.
    ENDLOOP.

    " INICIANDO A GRID
    go_grid->set_table_for_first_display(
        EXPORTING
            i_structure_name = 'ZAFPMT_001'
            is_layout        = gs_layout
        CHANGING
            it_fieldcatalog  = gt_fieldcat
            it_outtab        = lo_business_se->lt_setor_empresa
    ).

    SET HANDLER handle_data_changed FOR go_grid.

    refresh(  ).
  ENDMETHOD.

  METHOD active_change_handle.

    go_grid->check_changed_data(  ).

  ENDMETHOD.

  METHOD refresh.
    go_grid->refresh_table_display(  ).
    cl_gui_cfw=>flush(  ).
  ENDMETHOD.

  METHOD handle_data_changed.

    ASSIGN er_data_changed->mp_mod_rows->* TO FIELD-SYMBOL(<modified_rows>).
    ASSIGN er_data_changed->mt_deleted_rows TO FIELD-SYMBOL(<deleted_rows>).

    CASE lv_screen.
      WHEN `RUN_SETOR_EMPRESA`.
        lo_business_se->set_setor_empresa( <modified_rows> ).
        lo_business_se->delete_setor_empresa( <deleted_rows> ).
      WHEN `RUN_MODULO_SAP`.
        lo_business_ms->set_modulos_sap( <modified_rows> ).
        lo_business_ms->delete_modulos_sap( <deleted_rows> ).
      WHEN `RUN_PROJECT`.
        lo_business_pj->set_projetos( <modified_rows> ).
        lo_business_pj->delete_projetos( <deleted_rows> ).
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.

  METHOD run_modulo_sap.

    CHECK go_custom_control IS INITIAL.

    " ATRELANDO O COMPONENTE DE TELA A UM OBJETO ABAP
    go_custom_control = NEW cl_gui_custom_container( 'CC_MODULO' ).

    " ATRELANDO A GRID A UM OBJETO ABAP DE TELA
    go_grid = NEW cl_gui_alv_grid( i_parent = go_custom_control ).

    " CARREGANDO CONFIGURAÇÕES PADRÕES DAS COLUNAS
    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name = 'ZAFPMT_002'
      CHANGING
        ct_fieldcat      = gt_fieldcat.

    LOOP AT gt_fieldcat ASSIGNING FIELD-SYMBOL(<fs_fieldcat>).
      CASE <fs_fieldcat>-fieldname.
        WHEN 'MODULO'.
          <fs_fieldcat>-just      = 'C'.
          <fs_fieldcat>-edit      = 'X'.
          <fs_fieldcat>-outputlen = 5.
        WHEN 'MODIFICADO_EM'.
          <fs_fieldcat>-reptext   = 'Mod. Em'.
          <fs_fieldcat>-scrtext_s = 'Mod. Em'.
          <fs_fieldcat>-scrtext_m = 'Modificado Em'.
          <fs_fieldcat>-scrtext_l = 'Modificado Em'.
        WHEN 'MODIFICADO_POR'.
          <fs_fieldcat>-reptext   = 'Mod. Por'.
          <fs_fieldcat>-scrtext_s = 'Mod. Por'.
          <fs_fieldcat>-scrtext_m = 'Modificado Por'.
          <fs_fieldcat>-scrtext_l = 'Modificado Por'.
        WHEN OTHERS .
          <fs_fieldcat>-no_out = 'X'.
      ENDCASE.
    ENDLOOP.

    " INICIANDO A GRID
    go_grid->set_table_for_first_display(
        EXPORTING
            i_structure_name = 'ZAFPMT_002'
            is_layout        = gs_layout
        CHANGING
            it_fieldcatalog  = gt_fieldcat
            it_outtab        = lo_business_ms->lt_modulos_sap
    ).

    SET HANDLER handle_data_changed FOR go_grid.

    refresh(  ).
  ENDMETHOD.
ENDCLASS.


*&---------------------------------------------------------------------*
*& Module STATUS_2001 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
DATA: lo_business TYPE REF TO lcl_business.

MODULE set_status OUTPUT.
  IF lo_business IS INITIAL.
    lo_business = NEW lcl_business(
        COND #(
            WHEN sy-dynnr = `2001` THEN `RUN_PROJECT`
            WHEN sy-dynnr = `2002` THEN `RUN_SETOR_EMPRESA`
            ELSE `RUN_MODULO_SAP`
        )
      ).
  ENDIF.
  lo_business->run(  ).

  SET PF-STATUS 'STANDARD'.
  SET TITLEBAR sy-dynnr.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_2001  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command INPUT.

  CASE sy-ucomm.
*    EVENTOS DE SAÍDA DE TRANSAÇÃO
    WHEN '&F03' OR '&F15' OR '&F12'.
      LEAVE PROGRAM.
    WHEN 'BTN_SETOR_EMPRESA'.
      lo_business->lo_business_se->get_setor_empresa(  ).
      lo_business->refresh(  ).
    WHEN 'BTN_MODULO'.
      lo_business->lo_business_ms->get_modulos_sap(  ).
      lo_business->refresh(  ).
    WHEN 'BTN_PROJETO'.
      lo_business->lo_business_pj->get_projetos(  ).
      lo_business->refresh(  ).
    WHEN 'BTN_SE_SAVE' OR 'BTN_PJ_SAVE' OR 'BTN_MS_SAVE'.
      lo_business->active_change_handle(  ).
    WHEN OTHERS .
  ENDCASE.

ENDMODULE.
