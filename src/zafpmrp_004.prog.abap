*&---------------------------------------------------------------------*
*& Report zafpmrp_004
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zafpmrp_004.

" GERANDO UM ALV IDA EM UMA LINHA DE CÓDIGHO

" CL_SALV_GUI_TABLE_IDA=>CREATE( 'SPFLI' )->FULLSCREEN( )->DISPLAY( ).

TABLES spfli.

" ALV IDA:
"       - SPFLI (TABELA DE VOOS)
"       - SFLIGHT )DETALHAMENTO DOS VOOS)
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
  PARAMETERS     p_carrid TYPE spfli-carrid.
  SELECT-OPTIONS s_connid FOR  spfli-connid.
SELECTION-SCREEN END OF BLOCK b1.

CLASS lcl_main DEFINITION CREATE PRIVATE.

  PUBLIC SECTION.
    DATA lo_ida TYPE REF TO if_salv_gui_table_ida.

    CLASS-METHODS create
      RETURNING VALUE(r_result) TYPE REF TO lcl_main.

    METHODS run.
    METHODS set_filters.
    METHODS set_fieldcat.
    METHODS set_sort.
    METHODS set_toolbar_actions.
    METHODS handle_action FOR EVENT function_selected OF if_salv_gui_toolbar_ida.

ENDCLASS.


CLASS lcl_main IMPLEMENTATION.
  METHOD create.
    r_result = NEW #( ).
  ENDMETHOD.

  METHOD run.
    " CRIAR O IDA
    lo_ida = cl_salv_gui_table_ida=>create( 'SPFLI' ).

    set_filters( ).
    set_fieldcat( ).
    set_sort( ).
    set_toolbar_actions( ).

    " COLOCAR EM FULLSCREEN E EXIBIR
    lo_ida->fullscreen( )->display( ).
  ENDMETHOD.

  METHOD set_filters.
    DATA(lo_collector) = NEW cl_salv_range_tab_collector( ).

    " ADICIONAR PARÂMETROS - PARAMETERS
    IF p_carrid IS NOT INITIAL.
      " TRANSFORMAR PARAMETER EM UM RANGE
      DATA(lr_carrid) = VALUE rseloption( ( sign = 'I' option = 'EQ' low = p_carrid ) ).
    ENDIF.
    lo_collector->add_ranges_for_name( iv_name   = 'CARRID'
                                       it_ranges = lr_carrid[] ).

    " ADICIONAR RANGES - SELECTOPTIONS
    lo_collector->add_ranges_for_name( iv_name   = 'CONNID'
                                       it_ranges = s_connid[] ).

    " MONTAR TABELA DE RANGES DE FILTRO
    lo_collector->get_collected_ranges( IMPORTING et_named_ranges = DATA(lt_named_ranges) ).

    " ADICIONAR TABELA DE RANGES AO IDA
    lo_ida->set_select_options( lt_named_ranges[] ).
  ENDMETHOD.

  METHOD set_fieldcat.
    DATA(lt_field_names) = VALUE if_salv_gui_types_ida=>yts_field_name( ( CONV string( 'CARRID' ) )
                                                                        ( CONV string( 'CONNID' ) )
                                                                        ( CONV string( 'COUNTRYFR' ) )
                                                                        ( CONV string( 'CITYFROM' ) )
                                                                        ( CONV string( 'AIRPFROM' ) )
                                                                        ( CONV string( 'COUNTRYTO' ) )
                                                                        ( CONV string( 'CITYTO' ) )
                                                                        ( CONV string( 'AIRPTO' ) )
                                                                        ( CONV string( 'FLTIME' ) )
                                                                        ( CONV string( 'DEPTIME' ) )
                                                                        ( CONV string( 'ARRTIME' ) ) ).

    lo_ida->field_catalog( )->set_available_fields( lt_field_names ).
  ENDMETHOD.

  METHOD set_sort.
  ENDMETHOD.

  METHOD set_toolbar_actions.
    " ADICIONA BOTÃO NA TOOLBAR
    lo_ida->toolbar( )->add_button( iv_fcode = 'DISP'
                                    iv_icon  = '@16@'
                                    iv_text  = 'Detalhar Voo' ).

    " LIBERA OPÇÃO DE SELEÇÃO DE LINHA
    lo_ida->selection( )->set_selection_mode( 'SINGLE' ).

    " ADICIONAR EVENTO "CLIQUE"
    SET HANDLER handle_action FOR lo_ida->toolbar( ).
  ENDMETHOD.

  METHOD handle_action.
    DATA ls_spfli TYPE spfli.

    IF lo_ida IS NOT BOUND.
      RETURN.
    ENDIF.

    IF lo_ida->selection( )->is_row_selected( ).

      lo_ida->selection( )->get_selected_row( IMPORTING es_row = ls_spfli ).

      DATA(lo_ida_detail) = cl_salv_gui_table_ida=>create( 'SFLIGHT' ).

      IF lo_ida_detail IS BOUND.

        DATA(lt_named_ranges_detail) = VALUE if_salv_service_types=>yt_named_ranges(
                                                 sign   = 'I'
                                                 option = 'EQ'
                                                 ( name = 'CARRID' low = ls_spfli-carrid )
                                                 ( name = 'CONNID' low = ls_spfli-connid ) ).

        lo_ida_detail->set_select_options( lt_named_ranges_detail ).

        lo_ida_detail->fullscreen( )->display( ).

      ENDIF.

    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  lcl_main=>create( )->run( ).
