import sys

src, tgt = sys.argv[1], sys.argv[2]

src_lines = open('tmp/subs_2m.'+src).readlines()
tgt_lines = open('tmp/subs_2m.'+tgt).readlines()
with  open('tmp/subs_2m.noneq.'+src, 'w') as src, open('tmp/subs_2m.noneq.'+tgt, 'w') as tgt:
    for i in range(len(src_lines)):
        if src_lines[i] != tgt_lines[i]:
            src.writelines(src_lines[i])
            tgt.writelines(tgt_lines[i])
