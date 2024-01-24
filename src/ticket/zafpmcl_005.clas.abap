CLASS zafpmcl_005 DEFINITION
  PUBLIC
  INHERITING FROM zafpmcl_001
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS validate
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zafpmcl_005 IMPLEMENTATION.


  METHOD validate.

*    can_execute = abap_true.

    DATA(ls_ticket) = CORRESPONDING zafpmt_007( cs_data ).

    IF ls_ticket-id IS INITIAL.
*      can_execute = abap_false.
*      MESSAGE e000(ZAFPM).
      RAISE EXCEPTION NEW zafpmcl_003(
        textid = zafpmcl_003=>has_no_id
      ).
    ENDIF.

    CHECK iv_is_delete IS INITIAL.

    IF ls_ticket-titulo IS INITIAL.
*      can_execute = abap_false.
*      MESSAGE e001(ZAFPM).
      RAISE EXCEPTION NEW zafpmcl_003(
        textid = zafpmcl_003=>has_no_title
      ).
    ENDIF.

    IF ls_ticket-descricao IS INITIAL.
      RAISE EXCEPTION NEW zafpmcl_003(
        textid = zafpmcl_003=>has_no_description
      ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
