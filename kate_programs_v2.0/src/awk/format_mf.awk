BEGIN {i=1; j=1; x=99; z=1;}

{
  if (z<4) {print substr ($0,1,99)}
  if (z==4) {printf "%s", substr ($0,1,99)}
  if (z>4) {
    if (x>4) {
      x=1; 
      printf "\n%i %i:%.5f", i, j, $1;
    } 
    else {
      printf " %i:%.5f", j, $1;
      x++; 
    }

    j++;
    if (j > numzones) {
      j=1;
      i++;
    }
  }
  
  z++;
}

END {printf "\n\n"}
