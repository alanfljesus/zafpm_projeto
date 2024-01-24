*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZAFPMT_006......................................*
DATA:  BEGIN OF STATUS_ZAFPMT_006                    .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZAFPMT_006                    .
CONTROLS: TCTRL_ZAFPMT_006
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZAFPMT_006                    .
TABLES: ZAFPMT_006                     .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
