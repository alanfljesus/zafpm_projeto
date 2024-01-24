CLASS zafpmcl_002 DEFINITION
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



CLASS zafpmcl_002 IMPLEMENTATION.


  METHOD validate.

*    can_execute = abap_true.

    DATA(ls_projeto) = CORRESPONDING zafpmt_003( cs_data ).

    IF ls_projeto-id IS INITIAL.
*      can_execute = abap_false.
*      MESSAGE e000(ZAFPM).
      RAISE EXCEPTION NEW zafpmcl_003(
        textid = zafpmcl_003=>has_no_id
      ).
    ENDIF.

    CHECK iv_is_delete IS INITIAL.

    IF ls_projeto-titulo IS INITIAL.
*      can_execute = abap_false.
*      MESSAGE e001(ZAFPM).
      RAISE EXCEPTION NEW zafpmcl_003(
        textid = zafpmcl_003=>has_no_title
      ).
    ENDIF.

    IF ls_projeto-equipe IS INITIAL.
*      can_execute = abap_false.
*      MESSAGE e002(ZAFPM).
      RAISE EXCEPTION NEW zafpmcl_003(
        textid = zafpmcl_003=>has_no_squad
      ).
    ENDIF.

    IF ls_projeto-descricao IS INITIAL.
      RAISE EXCEPTION NEW zafpmcl_003(
        textid = zafpmcl_003=>has_no_description
      ).
    ENDIF.

    IF ls_projeto-responsavel IS INITIAL.
      RAISE EXCEPTION NEW zafpmcl_003(
        textid = zafpmcl_003=>has_no_owner
      ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
