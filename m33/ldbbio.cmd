0005?	scnser:
    0007?	C
    0010?	%%pat!movei p,%%pat+50
   0020?	%%go:%%fet t1,lintab(u)
   0030?	jsp p,%%pat 15
  0040?	%%fet t1,ldbbio(t1)
  0050?	jsp p,%%pat 15
  0060?	jumpe t1,.+4
    0070?	hrrz t1,u
  0080?	pushj p,%%pat+30
0080?	outchi 40
  0090?	aobjn u,%%go
    0100?	%%end
 0110?	%%pat+15!outchi 55
   0120?	outchi 55
  0140?	%%pat+30!OCTOUT:IDIVI T1,8.
    0150?	HRLM T2,(P)
0160?	SKIPE T1
   0170?	PUSHJ P,OCTOUT
  0180?	HLRZ T1,(P)
0190?	OUTCHI 60(T1)
   0200?	POPJ P,
    0210?	0
 0220?	
 