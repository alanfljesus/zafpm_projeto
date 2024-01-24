*----------------------------------------------------------------------*
***INCLUDE LZAFPMT_002F01.
*----------------------------------------------------------------------*
FORM modify_register.

  CHECK zafpmt_002-criado_por IS NOT INITIAL.

  GET TIME STAMP FIELD DATA(lv_timestamp).

  zafpmt_002-modificado_por = sy-uname.
  zafpmt_002-modificado_em = lv_timestamp.

ENDFORM.

FORM create_register.

  GET TIME STAMP FIELD DATA(lv_timestamp).

  zafpmt_002-criado_por = sy-uname.
  zafpmt_002-criado_em = lv_timestamp.

ENDFORM.
