CLASS zafpmcl_006 DEFINITION
  PUBLIC
  INHERITING FROM zafpmcl_001
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS approve_hour
      IMPORTING
        !iv_approve      TYPE zafpmel_012
      CHANGING
        !cs_data         TYPE zafpmt_009
      RETURNING
        VALUE(rs_result) TYPE bapiret2 .

    METHODS validate
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zafpmcl_006 IMPLEMENTATION.


  METHOD approve_hour.

    CHECK iv_approve CA 'AR'.

    " Modidifca o valor de entrada
    cs_data-aprovacao     = iv_approve.
    cs_data-aprovacao_em  = sy-datum.
    cs_data-aprovacao_por = sy-uname.

    MODIFY zafpmt_009 FROM cs_data.

  ENDMETHOD.


  METHOD validate.

*    can_execute = abap_true.

    DATA(ls_hour) = CORRESPONDING zafpmt_009( cs_data ).

    IF ls_hour-id IS INITIAL.
*      can_execute = abap_false.
*      MESSAGE e000(ZAFPM).
      RAISE EXCEPTION NEW zafpmcl_003(
        textid = zafpmcl_003=>has_no_id
      ).
    ENDIF.

    CHECK iv_is_delete IS INITIAL.

    IF ls_hour-descricao IS INITIAL.
      RAISE EXCEPTION NEW zafpmcl_003(
        textid = zafpmcl_003=>has_no_description
      ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
