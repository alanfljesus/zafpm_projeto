*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZAFPMVW_002.....................................*
TABLES: ZAFPMVW_002, *ZAFPMVW_002. "view work areas
CONTROLS: TCTRL_ZAFPMVW_002
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_ZAFPMVW_002. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZAFPMVW_002.
* Table for entries selected to show on screen
DATA: BEGIN OF ZAFPMVW_002_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZAFPMVW_002.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZAFPMVW_002_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZAFPMVW_002_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZAFPMVW_002.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZAFPMVW_002_TOTAL.

*.........table declarations:.................................*
TABLES: ZAFPMT_005                     .
