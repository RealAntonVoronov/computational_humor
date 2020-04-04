src=$1
tgt=$2

langid --line -n < tmp/subs_2m.noneq.single.$src > tmp/$src.lang.txt &
langid --line -n < tmp/subs_2m.noneq.single.$tgt > tmp/$tgt.lang.txt &

wait

python languages.py $1 $2
