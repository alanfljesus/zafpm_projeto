*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZAFPMVW_001.....................................*
TABLES: ZAFPMVW_001, *ZAFPMVW_001. "view work areas
CONTROLS: TCTRL_ZAFPMVW_001
TYPE TABLEVIEW USING SCREEN '0002'.
DATA: BEGIN OF STATUS_ZAFPMVW_001. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZAFPMVW_001.
* Table for entries selected to show on screen
DATA: BEGIN OF ZAFPMVW_001_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZAFPMVW_001.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZAFPMVW_001_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZAFPMVW_001_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZAFPMVW_001.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZAFPMVW_001_TOTAL.

*.........table declarations:.................................*
TABLES: ZAFPMT_004                     .
