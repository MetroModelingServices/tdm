BEGIN {z=1}

{
  if (z<=4) {print substr ($0,1,99)}
  else {
    printf "%i all:%.5f\n", $1, $2;
  }
  z++;
}

END {printf "\n"}
