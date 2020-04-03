src=$1
tgt=$2

mkdir tmp
cd tmp
wget http://opus.nlpl.eu/download.php?f=OpenSubtitles/v2016/moses/$src-$tgt.txt.zip
unzip  download.php?f=OpenSubtitles%2Fv2016%2Fmoses%2F$src-$tgt.txt.zip && rm download.php?f=OpenSubtitles%2Fv2016%2Fmoses%2F$src-$tgt.txt.zip

head -n 2000000 OpenSubtitles.$src-$tgt.$src > subs_2m.$src
head -n 2000000 OpenSubtitles.$src-$tgt.$tgt > subs_2m.$tgt
