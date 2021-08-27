
FOR /F "tokens=*" %%G IN ('DIR /B /S *.rdl*') DO C:\Perl64\bin\perl UpdateDSToStreamline.pl "%%G"
