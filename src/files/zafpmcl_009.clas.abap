class ZAFPMCL_009 definition
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



CLASS ZAFPMCL_009 IMPLEMENTATION.


  METHOD validate.

*   can_execute = abap_true.

    DATA(ls_file) = CORRESPONDING zafpmt_012( is_data ).

    IF ls_file-id IS INITIAL.
*     can_execute = abap_false.
*     MESSAGE e000(ZAFPM).
      RAISE EXCEPTION NEW zafpmcl_003(
        textid = zafpmcl_003=>has_no_id
      ).
    ENDIF.

    CHECK iv_is_delete IS INITIAL.

    IF ls_file-ticket IS INITIAL.
      RAISE EXCEPTION NEW zafpmcl_003(
        textid = zafpmcl_003=>has_no_ticket
      ).
    ENDIF.

    IF ls_file-binario IS INITIAL.
      RAISE EXCEPTION NEW zafpmcl_003(
        textid = zafpmcl_003=>has_no_binary
      ).
    ENDIF.

    IF ls_file-tipo_documento IS INITIAL.
      RAISE EXCEPTION NEW zafpmcl_003(
        textid = zafpmcl_003=>has_no_type_file
      ).
    ENDIF.

    IF ls_file-nome_arquivo IS INITIAL.
      RAISE EXCEPTION NEW zafpmcl_003(
        textid = zafpmcl_003=>has_no_name_file
      ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
