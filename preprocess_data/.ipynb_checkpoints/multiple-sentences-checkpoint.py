import nltk
nltk.download('punkt')
from nltk.tokenize import sent_tokenize
import sys

src, tgt, i = sys.argv[1], sys.argv[2], sys.argv[3]
if len(i) == 1:
    i = '0' + i
    
src_name = f'tmp/subs.{src}-{tgt}.noneq.{src}{i}'
tgt_name = f'tmp/subs.{src}-{tgt}.noneq.{tgt}{i}'
src_res_name = f'tmp/subs.{src}-{tgt}.single.{src}{i}'
tgt_res_name = f'tmp/subs.{src}-{tgt}.single.{tgt}{i}'

with open(src_name) as s, open(tgt_name) as t:
    src_lines = s.readlines()
    tgt_lines = t.readlines()

n_lines = len(src_lines)
with open(src_res_name, 'w') as res_src, open(tgt_res_name, 'w') as res_tgt:
    for i in range(n_lines):
        src_line = src_lines[i].strip()
        n_src_sentences = len(sent_tokenize(src_line))
        tgt_line = tgt_lines[i].strip()
        n_tgt_sentences = len(sent_tokenize(tgt_line))
        if n_src_sentences==1 and n_tgt_sentences==1:
            res_src.writelines(src_lines[i])
            res_tgt.writelines(tgt_lines[i])
