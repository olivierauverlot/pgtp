tests:
	prove -Ilocal\lib\perl5 -v
bin:
	carton exec pp -o pgtp.exe pgtp.pl
doc:
	carton exec pod2pdf "manual.pod > manual.pdf"
clean:
	del manual.pdf
	del pgtp.exe