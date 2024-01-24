CLASS zafpmcl_test_project DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  FOR TESTING
  RISK LEVEL HARMLESS .

  PUBLIC SECTION.

    DATA go_project TYPE REF TO zafpmcl_002 .
  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS setup .
    METHODS teardown .
    METHODS has_no_title
      FOR TESTING
      RAISING
        zafpmcl_003 .
    METHODS has_no_description
      FOR TESTING
      RAISING
        zafpmcl_003 .
    METHODS has_no_squad
      FOR TESTING
      RAISING
        zafpmcl_003 .
    METHODS has_no_owner
      FOR TESTING
      RAISING
        zafpmcl_003 .
    METHODS filled
      FOR TESTING
      RAISING
        zafpmcl_003 .
    METHODS edit
      FOR TESTING
      RAISING
        zafpmcl_003 .
    METHODS delete
      FOR TESTING
      RAISING
        zafpmcl_003 .
ENDCLASS.



CLASS zafpmcl_test_project IMPLEMENTATION.


  METHOD delete.
    DATA(project) = VALUE zafpmt_003(
      titulo        = `Título`
      descricao     = `Descrição`
      modulo        = `FI`
      setor         = '1'
      equipe        = '1'
      responsavel   = `ABAP26`
      data_inicio   = `20231020`
      data_fim      = `20230123`
      data_fim_real = ''
    ).

    DATA(ls_result_create) = me->go_project->create(
                            CHANGING cs_data = project
                          ).

    project-id        = ls_result_create-message_v1.
    project-descricao = `Deletado`.

    DATA(ls_result_delete) = me->go_project->delete( project ).

    cl_abap_unit_assert=>assert_equals( act = ls_result_delete-type exp = 'S' msg = ls_result_delete-message ).
  ENDMETHOD.


  METHOD edit.
    DATA(project) = VALUE zafpmt_003(
      titulo        = `Título`
      descricao     = `Descrição`
      modulo        = `FI`
      setor         = '1'
      equipe        = '1'
      responsavel   = `ABAP26`
      data_inicio   = `20231020`
      data_fim      = `20230123`
      data_fim_real = ''
    ).

    DATA(ls_result_create) = me->go_project->create(
                               CHANGING cs_data = project
                             ).

    project-id        = ls_result_create-message_v1.
    project-descricao = `Modificado`.

    DATA(ls_result_update) = me->go_project->update(
                            CHANGING cs_data = project
                      ).

    cl_abap_unit_assert=>assert_equals( act = ls_result_update-type exp = 'S' msg = ls_result_update-message ).
  ENDMETHOD.


  METHOD filled.
    DATA(project) = VALUE zafpmt_003(
      titulo        = `Título`
      descricao     = `Descrição`
      modulo        = `FI`
      setor         = '1'
      equipe        = '1'
      responsavel   = `ABAP26`
      data_inicio   = `20231020`
      data_fim      = `20230123`
      data_fim_real = ''
    ).

    DATA(ls_result) = me->go_project->create(
                        CHANGING cs_data = project
                      ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'S' msg = ls_result-message ).
  ENDMETHOD.


  METHOD has_no_description.
    DATA(project) = VALUE zafpmt_003(
      titulo        = `Título`
      descricao     = ``
      modulo        = `FI`
      setor         = '1'
      equipe        = '1'
      responsavel   = `ABAP26`
      data_inicio   = `20231020`
      data_fim      = `20230123`
      data_fim_real = ''
    ).

    DATA(ls_result) = me->go_project->create(
                        CHANGING cs_data = project
                      ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).
  ENDMETHOD.


  METHOD has_no_owner.
    DATA(project) = VALUE zafpmt_003(
      titulo        = `Título`
      descricao     = `Descrição`
      modulo        = `FI`
      setor         = '1'
      equipe        = '1'
      responsavel   = ``
      data_inicio   = `20231020`
      data_fim      = `20230123`
      data_fim_real = ''
    ).

    DATA(ls_result) = me->go_project->create(
                        CHANGING cs_data = project
                      ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).
  ENDMETHOD.


  METHOD has_no_squad.
    DATA(project) = VALUE zafpmt_003(
      titulo        = `Título`
      descricao     = `Descrição`
      modulo        = `FI`
      setor         = '1'
      equipe        = ''
      responsavel   = `ABAP26`
      data_inicio   = `20231020`
      data_fim      = `20230123`
      data_fim_real = ''
    ).

    DATA(ls_result) = me->go_project->create(
                        CHANGING cs_data = project
                      ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).
  ENDMETHOD.


  METHOD has_no_title.
    DATA(project) = VALUE zafpmt_003(
      descricao     = `Descrição`
      modulo        = `FI`
      setor         = '1'
      equipe        = '1'
      responsavel   = `ABAP26`
      data_inicio   = `20231020`
      data_fim      = `20230123`
      data_fim_real = ''
    ).

    DATA(ls_result) = me->go_project->create(
                        CHANGING cs_data = project
                      ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).
  ENDMETHOD.


  METHOD setup.
    me->go_project = NEW zafpmcl_002('ZAFPMT_003').
  ENDMETHOD.


  METHOD teardown.
    FREE: me->go_project.
  ENDMETHOD.
ENDCLASS.
