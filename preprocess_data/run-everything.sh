src=$1
tgt=$2
size=$3

./0-load-the-data.sh $src $tgt

./1-find-equal-lines.sh $src $tgt

./2-multiple-sentences.sh $src $tgt

./3-different-length.sh $src $tgt

./4-languages.sh $src $tgt

./5-moses-bpe-model.sh $src $tgt $size


subword-nmt apply-bpe -c res/model_$size.bpe < tmp/3-truecase/subs.tc.$tgt > res/subs_$size.bpe.$tgt &
subword-nmt apply-bpe -c res/model_$size.bpe < tmp/3-truecase/subs.tc.$src > res/subs_$size.bpe.$src &

wait