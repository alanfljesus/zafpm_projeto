*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZAFPMT_003......................................*
DATA:  BEGIN OF STATUS_ZAFPMT_003                    .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZAFPMT_003                    .
CONTROLS: TCTRL_ZAFPMT_003
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZAFPMT_003                    .
TABLES: ZAFPMT_003                     .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
