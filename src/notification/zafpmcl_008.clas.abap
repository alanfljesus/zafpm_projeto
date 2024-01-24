class ZAFPMCL_008 definition
  public
  inheriting from ZAFPMCL_001
  final
  create public .

public section.

  methods VALIDATE
    redefinition .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZAFPMCL_008 IMPLEMENTATION.


  METHOD validate.

*   can_execute = abap_true.

    DATA(ls_notification) = CORRESPONDING zafpmt_011( is_data ).

    IF ls_notification-id IS INITIAL.
*     can_execute = abap_false.
*     MESSAGE e000(ZAFPM).
      RAISE EXCEPTION NEW zafpmcl_003(
        textid = zafpmcl_003=>has_no_id
      ).
    ENDIF.

    CHECK iv_is_delete IS INITIAL.

    IF ls_notification-ticket IS INITIAL.
      RAISE EXCEPTION NEW zafpmcl_003(
        textid = zafpmcl_003=>has_no_ticket
      ).
    ENDIF.

    IF ls_notification-usuario IS INITIAL.
      RAISE EXCEPTION NEW zafpmcl_003(
        textid = zafpmcl_003=>has_no_user
      ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
