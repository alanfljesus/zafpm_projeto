CLASS lcl_alv DEFINITION.
  PUBLIC SECTION.

    DATA: lo_alv     TYPE REF TO cl_salv_table,
          lo_columns TYPE REF TO cl_salv_columns_table.


    METHODS:
      get_data,                                         " SELECIONA OS DADOS
      display_report CHANGING VALUE(lt_alv) TYPE any,   " EXIBE O RELATÓRIO
      set_fieldcat,                                     " MODIFICA AS COLUNAS
      set_color,                                        " MODIFICA A COR
      fieldcat_change IMPORTING _column    TYPE lvc_fname
                                _longtxt   TYPE scrtext_l         OPTIONAL
                                _position  TYPE int4              OPTIONAL
                                _outputlen TYPE lvc_outlen        OPTIONAL
                                _display   TYPE sap_bool          DEFAULT abap_true
                                _align     TYPE salv_de_alignment OPTIONAL.


ENDCLASS.

CLASS lcl_alv IMPLEMENTATION.

  METHOD get_data.
    " VAI SER SOBRESCRITO
  ENDMETHOD.

  METHOD display_report.

    cl_salv_table=>factory(
        IMPORTING
            r_salv_table = lo_alv
        CHANGING
            t_table = lt_alv
    ).

    lo_columns = lo_alv->get_columns( ).

    set_fieldcat(  ).
    set_color(  ).

    lo_alv->display(  ).

  ENDMETHOD.

  METHOD set_fieldcat.
    " VAI SER SOBRESCRITO
  ENDMETHOD.

  METHOD set_color.

    TRY.
        lo_columns->set_color_column( EXPORTING value = `COLOR` ).

      CATCH cx_salv_data_error.
    ENDTRY.

  ENDMETHOD.

  METHOD fieldcat_change.

    DATA(lo_column) = lo_columns->get_column( _column ).

    " MODIFICA TEXTO EXIBIÇÃO
    lo_column->set_long_text( _longtxt ).

    " MODIFICA VISIBILIDADE
    lo_column->set_visible( _display ).

    " 1 - ESQUERDA | 2 - DIREITA | 3 - MEIO
    lo_column->set_alignment( COND #( WHEN _align IS NOT INITIAL THEN _align ELSE 1 ) ).

    " MODIFICA TAMANHO EXIBIÇÃO
    lo_column->set_output_length( _outputlen ).

    " MODIFICA ORDEM DE EXIBIÇÃO
    lo_columns->set_column_position( columnname = _column
                                     position   = _position ).

  ENDMETHOD.


ENDCLASS.
