class ZAFPMCL_007 definition
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



CLASS ZAFPMCL_007 IMPLEMENTATION.


  METHOD validate.

*    can_execute = abap_true.

    DATA(ls_comments) = CORRESPONDING zafpmt_010( is_data ).

    IF ls_comments-id IS INITIAL.
*      can_execute = abap_false.
*      MESSAGE e000(ZAFPM).
      RAISE EXCEPTION NEW zafpmcl_003(
        textid = zafpmcl_003=>has_no_id
      ).
    ENDIF.

    CHECK iv_is_delete IS INITIAL.

    IF ls_comments-comentario IS INITIAL.
      RAISE EXCEPTION NEW zafpmcl_003(
        textid = zafpmcl_003=>has_no_comments
      ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
