*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZAFPMT_002......................................*
DATA:  BEGIN OF STATUS_ZAFPMT_002                    .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZAFPMT_002                    .
CONTROLS: TCTRL_ZAFPMT_002
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZAFPMT_002                    .
TABLES: ZAFPMT_002                     .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
