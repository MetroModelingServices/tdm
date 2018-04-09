# distsum.awk - WRS 12/04/02
# creates summary by district from R output
# works in concert with distsum.R
# for 8-districts (ga):  print with "mpage8d rptname.rpt |lp"
# mpage8d syntax (if not in .login file):  mpage -l -W90 -L36

BEGIN {
  FS=","; 
  z=1;
  cols=numdist+2;
}

{
  if (z<8) {printf ("%s\n", substr($0,1,99))}
  if (z==8) {
    printf ("      ");
    for (x=1; x<=cols; x++) {
      printf ("  %7s", $x);
      if (x==cols) {printf ("\norigin\ngroups\n\n")}
    }
  }
  if (z>8) {
    for (x=1; x<=cols; x++) {
      if (x==1) {printf ("  %4s", $x)}
      else {printf ("  %7s", $x)}
      if (x==cols) {printf ("\n\n", $x)}
    }
  }
  z++;
}  

