echo -off

for %i in fs0 fs1 fs2 fs3 fs4 fs5 FS6 FS7 blk1 blk2 blk3
	if exist %i:\%0 then 
		%i:
		AfuEfix64.efi NC14G0124.01.07.bin /N /P /X
		reset -s
	else
		echo not found %i
	endif
endfor



Fpt.efi -y -f NC14G0124.01.07.bin