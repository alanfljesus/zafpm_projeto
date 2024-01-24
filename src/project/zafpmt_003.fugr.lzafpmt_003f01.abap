*----------------------------------------------------------------------*
***INCLUDE LZAFPMT_003F01.
*----------------------------------------------------------------------*

FORM modify_register.

  CHECK zafpmt_003-criado_por IS NOT INITIAL.

  GET TIME STAMP FIELD DATA(lv_timestamp).

  zafpmt_003-modificado_por = sy-uname.
  zafpmt_003-modificado_em = lv_timestamp.

ENDFORM.

FORM create_register.

  GET TIME STAMP FIELD DATA(lv_timestamp).

  zafpmt_003-id = cl_system_uuid=>create_uuid_x16_static(  ).
  zafpmt_003-criado_por = sy-uname.
  zafpmt_003-criado_em = lv_timestamp.

ENDFORM.
