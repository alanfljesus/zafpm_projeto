*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZAFPMT_001......................................*
DATA:  BEGIN OF STATUS_ZAFPMT_001                    .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZAFPMT_001                    .
CONTROLS: TCTRL_ZAFPMT_001
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZAFPMT_001                    .
TABLES: ZAFPMT_001                     .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
