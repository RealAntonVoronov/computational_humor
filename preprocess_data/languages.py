import sys

src, tgt = sys.argv[1], sys.argv[2]

src_idx = set()
tgt_idx = set()
src_langid = open('tmp/'+src+'.lang.txt').readlines()
tgt_langid = open('tmp/'+tgt+'.lang.txt').readlines()

src_lang='pt' if src=='pt_br' else src
tgt_lang='pt' if tgt=='pt_br' else tgt

for i in range(len(src_langid)):
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

src_lines = open('tmp/subs_2m.noneq.single.'+src).readlines()
tgt_lines = open('tmp/subs_2m.noneq.single.'+tgt).readlines()

with  open('tmp/subs_2m.noneq.single.goodlang.'+src, 'w') as src, open('tmp/subs_2m.noneq.single.goodlang.'+tgt, 'w') as tgt:
    for i in range(len(src_lines)):
        l1 = len(src_lines[i].strip().split())
        l2 = len(tgt_lines[i].strip().split())
        if i in src_idx and  l1/l2 < 2 and l1/l2 > 0.5 :            
            if src_lines[i][0] == '-':
                src_lines_towrite = src_lines[i][2:]
            else:
                src_lines_towrite = src_lines[i]
            if tgt_lines[i][0] == '-':
                tgt_lines_towrite = tgt_lines[i][2:]
            else:
                tgt_lines_towrite = tgt_lines[i]
            if src_lines_towrite and tgt_lines_towrite:
                src.writelines(src_lines_towrite)
                tgt.writelines(tgt_lines_towrite)
