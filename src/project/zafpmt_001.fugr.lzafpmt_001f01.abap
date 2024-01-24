*----------------------------------------------------------------------*
***INCLUDE LZAFPMT_001F01.
*----------------------------------------------------------------------*

FORM modify_register.

  CHECK zafpmt_001-criado_por IS NOT INITIAL.

  GET TIME STAMP FIELD DATA(lv_timestamp).

  zafpmt_001-modificado_por = sy-uname.
  zafpmt_001-modificado_em = lv_timestamp.

ENDFORM.

FORM create_register.

  GET TIME STAMP FIELD DATA(lv_timestamp).

  zafpmt_001-criado_por = sy-uname.
  zafpmt_001-criado_em = lv_timestamp.

ENDFORM.
