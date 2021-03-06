C This reads a FINDIT log, looking for duplicate files
C The input file 'in.dat' must be sorted /r80/k54.6 with the format:
C(MAIL        :  74) QQ2571.XXX     2 25-Sep-90 15:30 BADQUV  ALL  RD  NO
C1234567890123456789012345678901234567890123456789012345678901234567890123
	dimension name1(10),name2(10)
	open(unit=1,file='in.dat')
	open(unit=2,file='out.dat')
	open(unit=3,file='dup.dat')
	open(unit=4,file='tty:')
	i=0
	j=100
10	read(1,20,end=999) nam1,nam2,sum1,sum2
20	format(20x,a5,a5,23x,a3,a3)
	if (sum1.eq.old1 .and. sum2.eq.old2) goto 40
C This is not a duplicate of the previous checksum
	old1=sum1
	old2=sum2
	iout=iout+1
	i=i+1
	name1(i)=nam1
	name2(i)=nam2
	if (i.lt.10) goto 10
	write(2,30) j,(name1(n),name2(n),n=1,i)
30	format('TYM',i3,'.QQ='a5,a5,9(',',a5,a5))
	i=0
	j=j+1
	goto 10

C Found a file with a duplicate checksum
40	write(3,50) nam1,nam2
50	format(1x,a5,a5)
	idup=idup+1
	goto 10

C Summary at end
999	write(4,998) iout,idup
998	format(' out.dat=',i,', dup.dat=',i)
	write(2,30) j,(name1(n),name2(n),n=1,i)
	END
 