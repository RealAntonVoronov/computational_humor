src=$1
tgt=$2

count=$(find tmp/ -name subs.$src-$tgt.$src* | wc -l)

for ((i = 0 ; i < $count ; i++ )); 
do
    python find-equal-lines.py $src $tgt $i &
done

wait

rm tmp/subs.$src-$tgt.$src* tmp/subs.$src-$tgt.$tgt*