import nltk
nltk.download('punkt')
from nltk.tokenize import sent_tokenize
import sys

src, tgt = sys.argv[1], sys.argv[2]

src_lines = open('tmp/subs_2m.noneq.'+src).readlines()
tgt_lines = open('tmp/subs_2m.noneq.'+tgt).readlines()
n = len(src_lines)
with open('tmp/subs_2m.noneq.single.'+src, 'w') as src, open('tmp/subs_2m.noneq.single.'+tgt, 'w') as tgt:
    for i in range(n):
        src_line = src_lines[i].strip()
        n_src_sentences = len(sent_tokenize(src_line))
        tgt_line = tgt_lines[i].strip()
        n_tgt_sentences = len(sent_tokenize(tgt_line))
        if n_src_sentences==1 and n_tgt_sentences==1:
            src.writelines(src_lines[i])
            tgt.writelines(tgt_lines[i])
