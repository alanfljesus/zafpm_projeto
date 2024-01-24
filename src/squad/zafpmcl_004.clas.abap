CLASS zafpmcl_004 DEFINITION
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



CLASS zafpmcl_004 IMPLEMENTATION.


  METHOD validate.

    DATA(ls_equipe) = CORRESPONDING zafpmt_004( cs_data ).

    IF ls_equipe-id IS INITIAL.
      RAISE EXCEPTION NEW zafpmcl_003(
        textid = zafpmcl_003=>has_no_id
      ).
    ENDIF.

    CHECK iv_is_delete IS INITIAL.

    IF ls_equipe-descricao IS INITIAL.
      RAISE EXCEPTION NEW zafpmcl_003(
        textid = zafpmcl_003=>has_no_description
      ).
    ENDIF.


  ENDMETHOD.
ENDCLASS.
