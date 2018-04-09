BEGIN {i=1; j=1; z=1; numzones=1260;}

{
  if (z>4) {
    printf "%i,%i,%.5f\n", i, j, $1;

    j++;
    if (j > numzones) {
      j=1;
      i++;
    }
  }
  z++;
}

