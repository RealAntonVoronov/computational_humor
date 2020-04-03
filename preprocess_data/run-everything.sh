src=$1
tgt=$2

./0-load-the-data.sh $src $tgt

./1-find-equal-lines.sh $src $tgt

./2-multiple-sentences.sh $src $tgt

./3-languages.sh $src $tgt

./4-moses-bpe.sh $src $tgt
