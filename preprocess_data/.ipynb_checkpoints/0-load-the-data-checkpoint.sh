src=$1
tgt=$2


if [ ! -f "OpenSubtitles.$src-$tgt.$src" ];
then wget http://opus.nlpl.eu/download.php?f=OpenSubtitles/v2016/moses/$src-$tgt.txt.zip
unzip  download.php?f=OpenSubtitles%2Fv2016%2Fmoses%2F$src-$tgt.txt.zip && rm download.php?f=OpenSubtitles%2Fv2016%2Fmoses%2F$src-$tgt.txt.zip;
fi;

if [ ! -d tmp ]; then mkdir tmp; fi

split -d -l 1000000 OpenSubtitles.$src-$tgt.$src tmp/subs.$src-$tgt.$src
split -d -l 1000000 OpenSubtitles.$src-$tgt.$tgt tmp/subs.$src-$tgt.$tgt

