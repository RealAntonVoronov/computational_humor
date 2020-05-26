import sys

src, tgt = sys.argv[1], sys.argv[2]

src_idx = set()
tgt_idx = set()

src_langid_name = f'tmp/{src}.lang.txt'
tgt_langid_name = f'tmp/{tgt}.lang.txt'
with open(src_langid_name) as s, open(tgt_langid_name) as t:
    src_langid = s.readlines()
    tgt_langid = t.readlines()

src_lang='pt' if src=='pt_br' else src
tgt_lang='pt' if tgt=='pt_br' else tgt

for i in range(len(src_langid)):
    if i % 1000000 == 0:
        print(i)
    line = src_langid[i].strip().split() 
    if line[0][2:4] == src_lang and float(line[1][:-1]) > 0.7:
        src_idx.add(i)
    elif float(line[1][:-1])< 0.3:
        src_idx.add(i)
    line = tgt_langid[i].strip().split() 
    if line[0][2:4] == tgt_lang and float(line[1][:-1]) > 0.7:
        tgt_idx.add(i)
    elif float(line[1][:-1])< 0.3:
        tgt_idx.add(i)
src_idx.intersection_update(tgt_idx)

src_name = f'tmp/subs.{src}-{tgt}.length.full.{src}'
tgt_name = f'tmp/subs.{src}-{tgt}.length.full.{tgt}'
with open(src_name) as s, open(tgt_name) as t:
    src_lines = s.readlines()
    tgt_lines = t.readlines()
    
res_src_name = f'tmp/subs.{src}-{tgt}.goodlang.{src}'
res_tgt_name = f'tmp/subs.{src}-{tgt}.goodlang.{tgt}'

with  open(res_src_name, 'w') as res_src, open(res_tgt_name, 'w') as res_tgt:
    for i in range(len(src_lines)):
        if i in src_idx:            
            if src_lines[i][0] == '-':
                src_lines_towrite = src_lines[i][2:]
            else:
                src_lines_towrite = src_lines[i]
            if tgt_lines[i][0] == '-':
                tgt_lines_towrite = tgt_lines[i][2:]
            else:
                tgt_lines_towrite = tgt_lines[i]
            if src_lines_towrite and tgt_lines_towrite:
                res_src.writelines(src_lines_towrite)
                res_tgt.writelines(tgt_lines_towrite)
