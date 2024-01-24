CLASS zafpmcl_test_squad DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  FOR TESTING
  RISK LEVEL HARMLESS.

  PUBLIC SECTION.

    DATA go_squad TYPE REF TO zafpmcl_004 .
  PROTECTED SECTION.
  PRIVATE SECTION.

    METHODS setup .
    METHODS teardown .
    METHODS has_no_description
      FOR TESTING
      RAISING zafpmcl_003 .
    METHODS filled
      FOR TESTING
      RAISING zafpmcl_003 .
    METHODS edit
      FOR TESTING
      RAISING zafpmcl_003 .
    METHODS delete
      FOR TESTING
      RAISING zafpmcl_003 .
ENDCLASS.



CLASS zafpmcl_test_squad IMPLEMENTATION.


  METHOD delete.
    DATA(squad) = VALUE zafpmt_004(
      id = ''
      descricao = 'Equipe'
    ).

    DATA(ls_result_create) = me->go_squad->create(
                                CHANGING is_data = squad
                             ).

    squad-id = ls_result_create-message_v1.
    squad-descricao = `Deletado`.

    DATA(ls_result_delete) = me->go_squad->delete( squad ).

    cl_abap_unit_assert=>assert_equals( act = ls_result_delete-type exp = 'S' msg = ls_result_delete-message ).
  ENDMETHOD.


  METHOD edit.
    DATA(squad) = VALUE zafpmt_004(
      id = ''
      descricao = `Equipe`
    ).

    DATA(ls_result_create) = me->go_squad->create(
                                CHANGING is_data = squad
                             ).

    squad-id = ls_result_create-message_v1.
    squad-descricao = `Modificado`.

    DATA(ls_result_update) = me->go_squad->update(
                                CHANGING is_data = squad
                             ).

    cl_abap_unit_assert=>assert_equals( act = ls_result_update-type exp = 'S' msg = ls_result_update-message ).
  ENDMETHOD.


  METHOD filled.
    DATA(squad) = VALUE zafpmt_004(
      id = ''
      descricao = `Equipe`
    ).

    DATA(ls_result) = me->go_squad->create(
                        CHANGING is_data = squad
                      ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'S' msg = ls_result-message ).
  ENDMETHOD.


  METHOD has_no_description.
    DATA(squad) = VALUE zafpmt_004(
      id = ''
      descricao = ''
    ).

    DATA(ls_result) = me->go_squad->create(
                        CHANGING is_data = squad
                      ).

    cl_abap_unit_assert=>assert_equals( act = ls_result-type exp = 'E' msg = ls_result-message ).
  ENDMETHOD.


  METHOD setup.
    me->go_squad = NEW zafpmcl_004('ZAFPMT_004').
  ENDMETHOD.


  METHOD teardown.
    FREE: me->go_squad.
  ENDMETHOD.
ENDCLASS.
