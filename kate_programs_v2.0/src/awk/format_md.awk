BEGIN {z=1}

{
  if (z<=4) {print substr ($0,1,99)}
  else {
    printf "all %i:%.5f\n", $1, $2;
  }
  z++;
}

END {printf "\n"}
