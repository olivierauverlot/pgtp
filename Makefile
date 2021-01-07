tests:
	prove -Ilocal\lib\perl5 -v
bin:
	carton exec pp -o pgtp.exe pgtp.pl
clean:
	del pgtp.exe