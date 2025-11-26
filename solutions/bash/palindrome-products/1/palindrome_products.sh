## EXIT ON INVALID INPUT ##
function exitOnErr () {
  ## What to Search For ##
  [[ $1 =~ ^(largest|smallest)$ ]] \
     || { echo "first arg should be 'smallest' or 'largest'"; exit  1; }
  ## Test for Valid Range ##
  [[ $2$3 =~ ^[0-9]+$ ]] && (( $2 ))  || { echo "Error in Range"; exit 2; }
  r1=$2; r2=$3
  if ((  r1 > r2 )); then  echo "min must be <= max"; exit 3; fi  
}
  
## TEST FOR PALINDROME ##
function ipal () {                  
  num=$1; ndx=0; (( endx=${#num}-1 ))
  while (( endx >= 0 )); do
    [[ ${num:ndx:1} != ${num:endx:1} ]] && return 0
    (( ndx++ )); (( endx-- ))
  done
  return 1
}

## OUTPUT FACTORS ##
function showFactors () {
  number=$1; last=$3
  nroot=$(bc <<< "scale=0; sqrt($number)")
  (( nroot < last )) && last=$nroot

  for (( factor0=$2; factor0<=last; factor0++ )); do
     (( factor1=number/factor0 ))
     (( number % factor1 > 0 )) && continue
     (( factor1 <=$3 )) && echo "[$factor0, $factor1]"
  done
}

exitOnErr $1 $2 $3                          # Make sure input is valid
target=$1; range0=$2; rangeN=$3             # User input

if [[ $target == largest ]]; then           # Adjust search for large or small
  goal=0; range0=$3; rangeN=$2; dir=-1      # Search back from largest in range
else                                        # Search from smallest in range up
  (( goal=rangeN*rangeN+1 ))
  range0=$2; rangeN=$3; dir=1;
fi             
found=0;                                    #  in-range palindrome found?

for (( j=range0; j*dir<=rangeN*dir; j+=dir )); do      # j is factor0
  (( j*range0*dir  > dir*goal )) && break
  if (( j % 10 == 0 )); then continue; fi
   for (( k=range0; k*dir<=j*dir; k+=dir )); do        # k is factpr1
    (( kj=k*j ))                                       # product pair
    (( kj % 10 == 0 )) || (( kj*dir >= dir*goal )) && continue
    $(ipal $kj); pal=$?                                # is it a palindrome?
    if (( pal )); then found=1;goal=$kj; fi            # save if yes
  done
done

if (( found )); then echo "$goal:"; showFactors $goal $2 $3; fi