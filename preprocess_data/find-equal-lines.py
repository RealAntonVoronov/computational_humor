import sys

src, tgt, i = sys.argv[1], sys.argv[2], sys.argv[3]

if len(i) == 1:
    i = '0' + i
    
src_name = f'tmp/subs.{src}-{tgt}.{src}{i}'
tgt_name = f'tmp/subs.{src}-{tgt}.{tgt}{i}'
src_res_name = f'tmp/subs.{src}-{tgt}.noneq.{src}{i}'
tgt_res_name = f'tmp/subs.{src}-{tgt}.noneq.{tgt}{i}'

with open(src_name) as s, open(tgt_name) as t:
    src_lines = s.readlines()
    tgt_lines = t.readlines()

with  open(src_res_name, 'w') as src_res, open(tgt_res_name, 'w') as tgt_res:
    for i in range(len(src_lines)):
        if src_lines[i] != tgt_lines[i]:
            src_res.writelines(src_lines[i])
            tgt_res.writelines(tgt_lines[i])
