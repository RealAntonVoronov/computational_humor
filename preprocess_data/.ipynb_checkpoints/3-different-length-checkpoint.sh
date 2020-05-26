src=$1
tgt=$2

count=$(find tmp/ -name subs.$src-$tgt.single.$src* | wc -l)

for ((i = 0 ; i < $count ; i++ )); 
do
    python different-length.py $src $tgt $i &
done

wait

rm tmp/subs.$src-$tgt.single.$src* tmp/subs.$src-$tgt.single.$tgt*
