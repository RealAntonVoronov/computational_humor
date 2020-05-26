src=$1
tgt=$2

count=$(find tmp/ -name subs.$src-$tgt.noneq.$src* | wc -l)

for ((i = 0 ; i < $count ; i++ )); 
do
    python multiple-sentences.py $src $tgt $i &
done

wait

rm tmp/subs.$src-$tgt.noneq.$src* tmp/subs.$src-$tgt.noneq.$tgt*