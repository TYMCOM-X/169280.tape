:---------------------------------------------------------------------
: Patch name:  RETCML                Product and Version:  CMH 1.07
:     Author:  PHIL SNEDDON                 Organization:  QSATS/STS
:   Customer:  UKNET                        Date Written:  FEB 15, 1989
: Description of Problem:  One cmdlnk for each circuit was not returned to the
: free list when the circuit was zapped.  ESC #216296
:---------------------------------------------------------------------

PATCH(890215,1108,P/SNEDDON,ZPHCK1+14,,6)
         J     ZPHCK2,,
CONPATCH(PA1PTR,,4E)
ZPHCK2   LHL   R6,DCBLKS+GPQUE,RDCB,  :SEE IF ANY CMD LINKS OUTSTANDING
         LHL   R0,DCBLKS+PPQUE,RDCB,  :ALL THREE FIELDS SHOULD BE EQUAL
         CR    R6,R0
         JEFS  .+4                    :IF NOT, CRASH HERE FOR FURTHER DEBUGGING
         HC    0
         LHL   R0,DCBLKS+RPQUE,RDCB,
         CR    R6,R0
         JEFS  .+4                    :SAME STORY HERE
         HC    0
         LR    R6,R6                  :ALL EQUAL, ARE THEY ALL ZERO?
         JEFS  ZPHCK3                 :YES
         JAL   R4,RELCL,,             :RETURN THE CMD LINK
         LIS   R6,0
         STH   R6,DCBLKS+GPQUE,RDCB,  :ZERO IT OUT NOW
         STH   R6,DCBLKS+PPQUE,RDCB,  :ZERO IT OUT NOW
         STH   R6,DCBLKS+RPQUE,RDCB,  :ZERO IT OUT NOW
ZPHCK3   LHL   RDCB,DCBLKS+DCBADB,RDCB,  :RESTORE ORIGINAL INSTRUCTION
         JE    ZPHCK4,,                  :RESTORE ORIGINAL INSTRUCTION
         J     ZPHCK1+1C,,               :RESTORE ORIGINAL INSTRUCTION
ENDPATCH(return cmd link when circuit is zapped)
  