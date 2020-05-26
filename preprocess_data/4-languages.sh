src=$1
tgt=$2

cat tmp/subs.$src-$tgt.length.$src* > tmp/subs.$src-$tgt.length.full.$src
cat tmp/subs.$src-$tgt.length.$tgt* > tmp/subs.$src-$tgt.length.full.$tgt
rm tmp/subs.$src-$tgt.length.$src* tmp/subs.$src-$tgt.length.$tgt*

langid --line -n < tmp/subs.$src-$tgt.length.full.$src > tmp/$src.lang.txt &
langid --line -n < tmp/subs.$src-$tgt.length.full.$tgt > tmp/$tgt.lang.txt &
wait

python languages.py $src $tgt
rm subs.$src-$tgt.length.full.$src subs.$src-$tgt.length.full.$tgt