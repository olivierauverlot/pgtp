tests:
	prove -v
bin:
	carton exec pp -o pgtp.exe pgtp.pl
clean:
	del pgtp.exe