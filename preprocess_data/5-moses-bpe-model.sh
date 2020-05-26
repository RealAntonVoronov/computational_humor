src=$1
tgt=$2
size=$3

if [[ "$1" = 'pt_br' ]]
then
	src_lang=$(echo 'pt')
else
	src_lang=$src
fi

if [[ "$2" = 'pt_br' ]]
then
        tgt_lang=$(echo 'pt')
else
        tgt_lang=$tgt
fi

mosesdir=~/libs/mosesdecoder/scripts

mkdir tmp/1-tok
mkdir tmp/2-clean
mkdir tmp/3-truecase
mkdir res

# Tokenize
cat tmp/subs.$src-$tgt.goodlang.$src | $mosesdir/tokenizer/normalize-punctuation.perl -l $src_lang | $mosesdir/tokenizer/tokenizer.perl -a -threads 8 -l $src_lang > tmp/1-tok/subs.tok.$src &
cat tmp/subs.$src-$tgt.goodlang.$tgt | $mosesdir/tokenizer/normalize-punctuation.perl -l $tgt_lang | $mosesdir/tokenizer/tokenizer.perl -a -threads 8 -l $tgt_lang > tmp/1-tok/subs.tok.$tgt &

wait

# Clean
$mosesdir/training/clean-corpus-n.perl tmp/1-tok/subs.tok $src $tgt tmp/2-clean/subs.clean.tok 2 128

# Train truecasers
$mosesdir/recaser/train-truecaser.perl -corpus tmp/2-clean/subs.clean.tok.$tgt -model tmp/2-clean/truecase-model.$tgt &
$mosesdir/recaser/train-truecaser.perl -corpus tmp/2-clean/subs.clean.tok.$src -model tmp/2-clean/truecase-model.$src &

wait

# Truecase
$mosesdir/recaser/truecase.perl -model tmp/2-clean/truecase-model.$tgt < tmp/2-clean/subs.clean.tok.$tgt > tmp/3-truecase/subs.tc.$tgt &
$mosesdir/recaser/truecase.perl -model tmp/2-clean/truecase-model.$src < tmp/2-clean/subs.clean.tok.$src > tmp/3-truecase/subs.tc.$src &

wait

# Split into subword units
cat tmp/3-truecase/subs.tc.$tgt tmp/3-truecase/subs.tc.$src | subword-nmt learn-bpe -s $size > res/model_$size.bpe