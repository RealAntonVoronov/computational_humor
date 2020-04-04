src=$1
tgt=$2

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

mosesdir=~/Work/duolingo-sharedtask-2020/mosesdecoder/scripts

mkdir tmp/1-tok
mkdir tmp/2-clean
mkdir tmp/3-truecase

# Tokenize
cat tmp/subs_2m.noneq.single.goodlang.$src | $mosesdir/tokenizer/normalize-punctuation.perl -l $src_lang | $mosesdir/tokenizer/tokenizer.perl -a -threads 8 -l $src_lang > tmp/1-tok/subs_2m.tok.$src
cat tmp/subs_2m.noneq.single.goodlang.$tgt | $mosesdir/tokenizer/normalize-punctuation.perl -l $tgt_lang | $mosesdir/tokenizer/tokenizer.perl -a -threads 8 -l $tgt_lang > tmp/1-tok/subs_2m.tok.$tgt

# Clean
$mosesdir/training/clean-corpus-n.perl tmp/1-tok/subs_2m.tok $src $tgt tmp/2-clean/subs_2m.clean.tok 2 128

# Train truecasers
$mosesdir/recaser/train-truecaser.perl -corpus tmp/2-clean/subs_2m.clean.tok.$tgt -model tmp/2-clean/truecase-model.$tgt
$mosesdir/recaser/train-truecaser.perl -corpus tmp/2-clean/subs_2m.clean.tok.$src -model tmp/2-clean/truecase-model.$src

# Truecase
$mosesdir/recaser/truecase.perl -model tmp/2-clean/truecase-model.$tgt < tmp/2-clean/subs_2m.clean.tok.$tgt > tmp/3-truecase/subs_2m.tc.$tgt
$mosesdir/recaser/truecase.perl -model tmp/2-clean/truecase-model.$src < tmp/2-clean/subs_2m.clean.tok.$src > tmp/3-truecase/subs_2m.tc.$src

# Split into subword units
cat tmp/3-truecase/subs_2m.tc.$tgt tmp/3-truecase/subs_2m.tc.$src | subword-nmt learn-bpe -s 16000 > model.bpe

subword-nmt apply-bpe -c model.bpe < tmp/3-truecase/subs_2m.tc.$tgt > subs.bpe.$tgt &
subword-nmt apply-bpe -c model.bpe < tmp/3-truecase/subs_2m.tc.$src > subs.bpe.$src &

wait
