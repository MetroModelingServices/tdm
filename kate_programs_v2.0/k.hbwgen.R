#k.hbwgen.R
# HBW Productions
# employment factor is 1.48 since BEA had totemp=1175095 and BLS had totemp=951582
# factor was 1.2 before so 1.2*1175095/951582 = 1.48 (previous, Edna)
# factor changed to 1.1 so 1.1*1175095/951582 = 1.36 (new, Joan & Kate - AAB, 11/06/12)

# HBW Trip Production Rates
r1 <- 1.386047  #  1-Worker
r2 <- 2.462282  #  2-Worker
r3 <- 3.578358  #  3+-Worker

## CVAL 0  (cars=0)

#  workers  HHsize  cval  income
hbw0101<-0  #no workers = no hbw trips generated
hbw0102<-0  #no workers = no hbw trips generated
hbw0103<-0  #no workers = no hbw trips generated
hbw0104<-0  #no workers = no hbw trips generated
hbw0201<-0  #no workers = no hbw trips generated
hbw0202<-0  #no workers = no hbw trips generated
hbw0203<-0  #no workers = no hbw trips generated
hbw0204<-0  #no workers = no hbw trips generated
hbw0301<-0  #no workers = no hbw trips generated
hbw0302<-0  #no workers = no hbw trips generated
hbw0303<-0  #no workers = no hbw trips generated
hbw0304<-0  #no workers = no hbw trips generated
hbw0401<-0  #no workers = no hbw trips generated
hbw0402<-0  #no workers = no hbw trips generated
hbw0403<-0  #no workers = no hbw trips generated
hbw0404<-0  #no workers = no hbw trips generated
hbw1101<-apply(mf.cval[,65:68],1,sum)*r1
hbw1102<-apply(mf.cval[,69:72],1,sum)*r1
hbw1103<-apply(mf.cval[,73:76],1,sum)*r1
hbw1104<-apply(mf.cval[,77:80],1,sum)*r1
hbw1201<-apply(mf.cval[,81:84],1,sum)*r1
hbw1202<-apply(mf.cval[,85:88],1,sum)*r1
hbw1203<-apply(mf.cval[,89:92],1,sum)*r1
hbw1204<-apply(mf.cval[,93:96],1,sum)*r1
hbw1301<-apply(mf.cval[,97:100],1,sum)*r1
hbw1302<-apply(mf.cval[,101:104],1,sum)*r1
hbw1303<-apply(mf.cval[,105:108],1,sum)*r1
hbw1304<-apply(mf.cval[,109:112],1,sum)*r1
hbw1401<-apply(mf.cval[,113:116],1,sum)*r1
hbw1402<-apply(mf.cval[,117:120],1,sum)*r1
hbw1403<-apply(mf.cval[,121:124],1,sum)*r1
hbw1404<-apply(mf.cval[,125:128],1,sum)*r1
hbw2101<-0  #illogical: workers > hh
hbw2102<-0  #illogical: workers > hh
hbw2103<-0  #illogical: workers > hh
hbw2104<-0  #illogical: workers > hh
hbw2201<-apply(mf.cval[,145:148],1,sum)*r2
hbw2202<-apply(mf.cval[,149:152],1,sum)*r2
hbw2203<-apply(mf.cval[,153:156],1,sum)*r2
hbw2204<-apply(mf.cval[,157:160],1,sum)*r2
hbw2301<-apply(mf.cval[,161:164],1,sum)*r2
hbw2302<-apply(mf.cval[,165:168],1,sum)*r2
hbw2303<-apply(mf.cval[,169:172],1,sum)*r2
hbw2304<-apply(mf.cval[,173:176],1,sum)*r2
hbw2401<-apply(mf.cval[,177:180],1,sum)*r2
hbw2402<-apply(mf.cval[,181:184],1,sum)*r2
hbw2403<-apply(mf.cval[,185:188],1,sum)*r2
hbw2404<-apply(mf.cval[,189:192],1,sum)*r2
hbw3101<-0  #illogical: workers > hh
hbw3102<-0  #illogical: workers > hh
hbw3103<-0  #illogical: workers > hh
hbw3104<-0  #illogical: workers > hh
hbw3201<-0  #illogical: workers > hh
hbw3202<-0  #illogical: workers > hh
hbw3203<-0  #illogical: workers > hh
hbw3204<-0  #illogical: workers > hh
hbw3301<-apply(mf.cval[,225:228],1,sum)*r3
hbw3302<-apply(mf.cval[,229:232],1,sum)*r3
hbw3303<-apply(mf.cval[,233:236],1,sum)*r3
hbw3304<-apply(mf.cval[,237:240],1,sum)*r3
hbw3401<-apply(mf.cval[,241:244],1,sum)*r3
hbw3402<-apply(mf.cval[,245:248],1,sum)*r3
hbw3403<-apply(mf.cval[,249:252],1,sum)*r3
hbw3404<-apply(mf.cval[,253:256],1,sum)*r3

## CVAL 1   (cars<workers)

#  workers  HHsize  cval  income
hbw0111<-0  #no workers = no hbw trips generated 
hbw0112<-0  #no workers = no hbw trips generated 
hbw0113<-0  #no workers = no hbw trips generated
hbw0114<-0  #no workers = no hbw trips generated
hbw0211<-0  #no workers = no hbw trips generated
hbw0212<-0  #no workers = no hbw trips generated
hbw0213<-0  #no workers = no hbw trips generated
hbw0214<-0  #no workers = no hbw trips generated
hbw0311<-0  #no workers = no hbw trips generated
hbw0312<-0  #no workers = no hbw trips generated
hbw0313<-0  #no workers = no hbw trips generated
hbw0314<-0  #no workers = no hbw trips generated
hbw0411<-0  #no workers = no hbw trips generated
hbw0412<-0  #no workers = no hbw trips generated
hbw0413<-0  #no workers = no hbw trips generated
hbw0414<-0  #no workers = no hbw trips generated
hbw1111<-0  #illogical: 1 worker hh cannot be CVAL1
hbw1112<-0  #illogical: 1 worker hh cannot be CVAL1
hbw1113<-0  #illogical: 1 worker hh cannot be CVAL1
hbw1114<-0  #illogical: 1 worker hh cannot be CVAL1
hbw1211<-0  #illogical: 1 worker hh cannot be CVAL1
hbw1212<-0  #illogical: 1 worker hh cannot be CVAL1
hbw1213<-0  #illogical: 1 worker hh cannot be CVAL1
hbw1214<-0  #illogical: 1 worker hh cannot be CVAL1
hbw1311<-0  #illogical: 1 worker hh cannot be CVAL1
hbw1312<-0  #illogical: 1 worker hh cannot be CVAL1
hbw1313<-0  #illogical: 1 worker hh cannot be CVAL1
hbw1314<-0  #illogical: 1 worker hh cannot be CVAL1
hbw1411<-0  #illogical: 1 worker hh cannot be CVAL1
hbw1412<-0  #illogical: 1 worker hh cannot be CVAL1
hbw1413<-0  #illogical: 1 worker hh cannot be CVAL1
hbw1414<-0  #illogical: 1 worker hh cannot be CVAL1
hbw2111<-0  #illogical: workers > hh
hbw2112<-0  #illogical: workers > hh
hbw2113<-0  #illogical: workers > hh
hbw2114<-0  #illogical: workers > hh
hbw2211<-apply(mf.cval[,273:276],1,sum)*r2
hbw2212<-apply(mf.cval[,277:280],1,sum)*r2
hbw2213<-apply(mf.cval[,281:284],1,sum)*r2
hbw2214<-apply(mf.cval[,285:288],1,sum)*r2
hbw2311<-apply(mf.cval[,289:292],1,sum)*r2
hbw2312<-apply(mf.cval[,293:296],1,sum)*r2
hbw2313<-apply(mf.cval[,297:300],1,sum)*r2
hbw2314<-apply(mf.cval[,301:304],1,sum)*r2
hbw2411<-apply(mf.cval[,305:308],1,sum)*r2
hbw2412<-apply(mf.cval[,309:312],1,sum)*r2
hbw2413<-apply(mf.cval[,313:316],1,sum)*r2
hbw2414<-apply(mf.cval[,317:320],1,sum)*r2
hbw3111<-0  #illogical: workers > hh
hbw3112<-0  #illogical: workers > hh
hbw3113<-0  #illogical: workers > hh
hbw3114<-0  #illogical: workers > hh
hbw3211<-0  #illogical: workers > hh
hbw3212<-0  #illogical: workers > hh
hbw3213<-0  #illogical: workers > hh
hbw3214<-0  #illogical: workers > hh
hbw3311<-apply(mf.cval[,c(353:356,417:420)],1,sum)*r3
hbw3312<-apply(mf.cval[,c(357:360,421:424)],1,sum)*r3
hbw3313<-apply(mf.cval[,c(361:364,425:428)],1,sum)*r3
hbw3314<-apply(mf.cval[,c(365:368,429:432)],1,sum)*r3
hbw3411<-apply(mf.cval[,c(369:372,433:436)],1,sum)*r3
hbw3412<-apply(mf.cval[,c(373:376,437:440)],1,sum)*r3
hbw3413<-apply(mf.cval[,c(377:380,441:444)],1,sum)*r3
hbw3414<-apply(mf.cval[,c(381:384,445:448)],1,sum)*r3

## CVAL 2   (cars=workers)

#  workers  HHsize  cval  income
hbw0121<-0  #no workers = no hbw trips generated
hbw0122<-0  #no workers = no hbw trips generated
hbw0123<-0  #no workers = no hbw trips generated
hbw0124<-0  #no workers = no hbw trips generated
hbw0221<-0  #no workers = no hbw trips generated
hbw0222<-0  #no workers = no hbw trips generated
hbw0223<-0  #no workers = no hbw trips generated
hbw0224<-0  #no workers = no hbw trips generated
hbw0321<-0  #no workers = no hbw trips generated
hbw0322<-0  #no workers = no hbw trips generated
hbw0323<-0  #no workers = no hbw trips generated
hbw0324<-0  #no workers = no hbw trips generated
hbw0421<-0  #no workers = no hbw trips generated
hbw0422<-0  #no workers = no hbw trips generated
hbw0423<-0  #no workers = no hbw trips generated
hbw0424<-0  #no workers = no hbw trips generated
hbw1121<-apply(mf.cval[,449:452],1,sum)*r1
hbw1122<-apply(mf.cval[,453:456],1,sum)*r1
hbw1123<-apply(mf.cval[,457:460],1,sum)*r1
hbw1124<-apply(mf.cval[,461:464],1,sum)*r1
hbw1221<-apply(mf.cval[,465:468],1,sum)*r1
hbw1222<-apply(mf.cval[,469:472],1,sum)*r1
hbw1223<-apply(mf.cval[,473:476],1,sum)*r1
hbw1224<-apply(mf.cval[,477:480],1,sum)*r1
hbw1321<-apply(mf.cval[,481:484],1,sum)*r1
hbw1322<-apply(mf.cval[,485:488],1,sum)*r1
hbw1323<-apply(mf.cval[,489:492],1,sum)*r1
hbw1324<-apply(mf.cval[,493:496],1,sum)*r1
hbw1421<-apply(mf.cval[,497:500],1,sum)*r1
hbw1422<-apply(mf.cval[,501:504],1,sum)*r1
hbw1423<-apply(mf.cval[,505:508],1,sum)*r1
hbw1424<-apply(mf.cval[,509:512],1,sum)*r1
hbw2121<-0  #illogical: workers > hh
hbw2122<-0  #illogical: workers > hh
hbw2123<-0  #illogical: workers > hh
hbw2124<-0  #illogical: workers > hh
hbw2221<-apply(mf.cval[,529:532],1,sum)*r2
hbw2222<-apply(mf.cval[,533:536],1,sum)*r2
hbw2223<-apply(mf.cval[,537:540],1,sum)*r2
hbw2224<-apply(mf.cval[,541:544],1,sum)*r2
hbw2321<-apply(mf.cval[,545:548],1,sum)*r2
hbw2322<-apply(mf.cval[,549:552],1,sum)*r2
hbw2323<-apply(mf.cval[,553:556],1,sum)*r2
hbw2324<-apply(mf.cval[,557:560],1,sum)*r2
hbw2421<-apply(mf.cval[,561:564],1,sum)*r2
hbw2422<-apply(mf.cval[,565:568],1,sum)*r2
hbw2423<-apply(mf.cval[,569:572],1,sum)*r2
hbw2424<-apply(mf.cval[,573:576],1,sum)*r2
hbw3121<-0  #illogical: workers > hh
hbw3122<-0  #illogical: workers > hh
hbw3123<-0  #illogical: workers > hh
hbw3124<-0  #illogical: workers > hh
hbw3221<-0  #illogical: workers > hh
hbw3222<-0  #illogical: workers > hh
hbw3223<-0  #illogical: workers > hh
hbw3224<-0  #illogical: workers > hh
hbw3321<-apply(mf.cval[,609:612],1,sum)*r3
hbw3322<-apply(mf.cval[,613:616],1,sum)*r3
hbw3323<-apply(mf.cval[,617:620],1,sum)*r3
hbw3324<-apply(mf.cval[,621:624],1,sum)*r3
hbw3421<-apply(mf.cval[,625:628],1,sum)*r3
hbw3422<-apply(mf.cval[,629:632],1,sum)*r3
hbw3423<-apply(mf.cval[,633:636],1,sum)*r3
hbw3424<-apply(mf.cval[,637:640],1,sum)*r3

## CVAL 3   (cars>workers)

#  workers  HHsize  cval  income
hbw0131<-0  #no workers = no hbw trips generated
hbw0132<-0  #no workers = no hbw trips generated
hbw0133<-0  #no workers = no hbw trips generated
hbw0134<-0  #no workers = no hbw trips generated
hbw0231<-0  #no workers = no hbw trips generated
hbw0232<-0  #no workers = no hbw trips generated
hbw0233<-0  #no workers = no hbw trips generated
hbw0234<-0  #no workers = no hbw trips generated
hbw0331<-0  #no workers = no hbw trips generated
hbw0332<-0  #no workers = no hbw trips generated
hbw0333<-0  #no workers = no hbw trips generated
hbw0334<-0  #no workers = no hbw trips generated
hbw0431<-0  #no workers = no hbw trips generated
hbw0432<-0  #no workers = no hbw trips generated
hbw0433<-0  #no workers = no hbw trips generated
hbw0434<-0  #no workers = no hbw trips generated
hbw1131<-apply(mf.cval[,c(769:772,897:900)],1,sum)*r1
hbw1132<-apply(mf.cval[,c(773:776,901:904)],1,sum)*r1
hbw1133<-apply(mf.cval[,c(777:780,905:908)],1,sum)*r1
hbw1134<-apply(mf.cval[,c(781:784,909:912)],1,sum)*r1
hbw1231<-apply(mf.cval[,c(785:788,913:916)],1,sum)*r1
hbw1232<-apply(mf.cval[,c(789:792,917:920)],1,sum)*r1
hbw1233<-apply(mf.cval[,c(793:796,921:924)],1,sum)*r1
hbw1234<-apply(mf.cval[,c(797:800,925:928)],1,sum)*r1
hbw1331<-apply(mf.cval[,c(801:804,929:932)],1,sum)*r1
hbw1332<-apply(mf.cval[,c(805:808,933:936)],1,sum)*r1
hbw1333<-apply(mf.cval[,c(809:812,937:940)],1,sum)*r1
hbw1334<-apply(mf.cval[,c(813:816,941:944)],1,sum)*r1
hbw1431<-apply(mf.cval[,c(817:820,945:948)],1,sum)*r1
hbw1432<-apply(mf.cval[,c(821:824,949:952)],1,sum)*r1
hbw1433<-apply(mf.cval[,c(825:828,953:956)],1,sum)*r1
hbw1434<-apply(mf.cval[,c(829:832,957:960)],1,sum)*r1
hbw2131<-0  #illogical: workers > hh
hbw2132<-0  #illogical: workers > hh
hbw2133<-0  #illogical: workers > hh
hbw2134<-0  #illogical: workers > hh
hbw2231<-apply(mf.cval[,977:980],1,sum)*r2
hbw2232<-apply(mf.cval[,981:984],1,sum)*r2
hbw2233<-apply(mf.cval[,985:988],1,sum)*r2
hbw2234<-apply(mf.cval[,989:992],1,sum)*r2
hbw2331<-apply(mf.cval[,993:996],1,sum)*r2
hbw2332<-apply(mf.cval[,997:1000],1,sum)*r2
hbw2333<-apply(mf.cval[,1001:1004],1,sum)*r2
hbw2334<-apply(mf.cval[,1005:1008],1,sum)*r2
hbw2431<-apply(mf.cval[,1009:1012],1,sum)*r2
hbw2432<-apply(mf.cval[,1013:1016],1,sum)*r2
hbw2433<-apply(mf.cval[,1017:1020],1,sum)*r2
hbw2434<-apply(mf.cval[,1021:1024],1,sum)*r2
hbw3131<-0  #illogical: workers > hh
hbw3132<-0  #illogical: workers > hh
hbw3133<-0  #illogical: workers > hh
hbw3134<-0  #illogical: workers > hh
hbw3231<-0  #illogical: workers > hh
hbw3232<-0  #illogical: workers > hh
hbw3233<-0  #illogical: workers > hh
hbw3234<-0  #illogical: workers > hh
hbw3331<-0  #more than 3 cars not allowed
hbw3332<-0  #more than 3 cars not allowed
hbw3333<-0  #more than 3 cars not allowed
hbw3334<-0  #more than 3 cars not allowed
hbw3431<-0  #more than 3 cars not allowed
hbw3432<-0  #more than 3 cars not allowed
hbw3433<-0  #more than 3 cars not allowed
hbw3434<-0  #more than 3 cars not allowed 

#########################################

# TOTAL PRODUCTIONS
 
# Low Income Productions (income bin 1)
ma.hbwprl <- hbw0101+hbw0201+hbw0301+hbw0401+hbw1101+hbw1201+hbw1301+hbw1401+
             hbw2101+hbw2201+hbw2301+hbw2401+hbw3101+hbw3201+hbw3301+hbw3401+
             hbw0111+hbw0211+hbw0311+hbw0411+hbw1111+hbw1211+hbw1311+hbw1411+
             hbw2111+hbw2211+hbw2311+hbw2411+hbw3111+hbw3211+hbw3311+hbw3411+
             hbw0121+hbw0221+hbw0321+hbw0421+hbw1121+hbw1221+hbw1321+hbw1421+
             hbw2121+hbw2221+hbw2321+hbw2421+hbw3121+hbw3221+hbw3321+hbw3421+
             hbw0131+hbw0231+hbw0331+hbw0431+hbw1131+hbw1231+hbw1331+hbw1431+
             hbw2131+hbw2231+hbw2331+hbw2431+hbw3131+hbw3231+hbw3331+hbw3431

# Middle Income Productions (income bins 2 & 3)
ma.hbwprm <- hbw0102+hbw0202+hbw0302+hbw0402+hbw1102+hbw1202+hbw1302+hbw1402+
             hbw2102+hbw2202+hbw2302+hbw2402+hbw3102+hbw3202+hbw3302+hbw3402+
             hbw0112+hbw0212+hbw0312+hbw0412+hbw1112+hbw1212+hbw1312+hbw1412+
             hbw2112+hbw2212+hbw2312+hbw2412+hbw3112+hbw3212+hbw3312+hbw3412+
             hbw0122+hbw0222+hbw0322+hbw0422+hbw1122+hbw1222+hbw1322+hbw1422+
             hbw2122+hbw2222+hbw2322+hbw2422+hbw3122+hbw3222+hbw3322+hbw3422+
             hbw0132+hbw0232+hbw0332+hbw0432+hbw1132+hbw1232+hbw1332+hbw1432+
             hbw2132+hbw2232+hbw2332+hbw2432+hbw3132+hbw3232+hbw3332+hbw3432+
             hbw0103+hbw0203+hbw0303+hbw0403+hbw1103+hbw1203+hbw1303+hbw1403+
             hbw2103+hbw2203+hbw2303+hbw2403+hbw3103+hbw3203+hbw3303+hbw3403+
             hbw0113+hbw0213+hbw0313+hbw0413+hbw1113+hbw1213+hbw1313+hbw1413+
             hbw2113+hbw2213+hbw2313+hbw2413+hbw3113+hbw3213+hbw3313+hbw3413+
             hbw0123+hbw0223+hbw0323+hbw0423+hbw1123+hbw1223+hbw1323+hbw1423+
             hbw2123+hbw2223+hbw2323+hbw2423+hbw3123+hbw3223+hbw3323+hbw3423+
             hbw0133+hbw0233+hbw0333+hbw0433+hbw1133+hbw1233+hbw1333+hbw1433+
             hbw2133+hbw2233+hbw2333+hbw2433+hbw3133+hbw3233+hbw3333+hbw3433

# High Income Productions (income bin 4)
ma.hbwprh <- hbw0104+hbw0204+hbw0304+hbw0404+hbw1104+hbw1204+hbw1304+hbw1404+
             hbw2104+hbw2204+hbw2304+hbw2404+hbw3104+hbw3204+hbw3304+hbw3404+
             hbw0114+hbw0214+hbw0314+hbw0414+hbw1114+hbw1214+hbw1314+hbw1414+
             hbw2114+hbw2214+hbw2314+hbw2414+hbw3114+hbw3214+hbw3314+hbw3414+
             hbw0124+hbw0224+hbw0324+hbw0424+hbw1124+hbw1224+hbw1324+hbw1424+
             hbw2124+hbw2224+hbw2324+hbw2424+hbw3124+hbw3224+hbw3324+hbw3424+
             hbw0134+hbw0234+hbw0334+hbw0434+hbw1134+hbw1234+hbw1334+hbw1434+
             hbw2134+hbw2234+hbw2334+hbw2434+hbw3134+hbw3234+hbw3334+hbw3434

# Total Productions (All Incomes)
ma.hbwpr <- ma.hbwprl + ma.hbwprm + ma.hbwprh

#############################################

## Calculate Attractions

ms.TotalEmp <- sum(ma.totemp)

ms.TotalHbwTrips <- sum(ma.hbwpr)

# Average Trip Rate per Employee
ms.aveHbwTripRate <- ms.TotalHbwTrips / ms.TotalEmp

ma.hbwat <- ma.totemp * ms.aveHbwTripRate

# Scale Attractions to Productions
ms.hbwat <- sum(ma.hbwat)
ma.hbwat <- ma.hbwat * (ms.TotalHbwTrips / ms.hbwat)

## Scale Trips to Employment

# Production Factor
ms.hbwFactor <- (ms.TotalEmp * HBW.gen.calibrationFac) / ms.TotalHbwTrips

# Adjust Productions
ma.hbwprl <- ma.hbwprl * ms.hbwFactor
ma.hbwprm <- ma.hbwprm * ms.hbwFactor
ma.hbwprh <- ma.hbwprh * ms.hbwFactor
ma.hbwpr  <- ma.hbwprl + ma.hbwprm + ma.hbwprh

for (w in 0:3) {
  for (h in 1:4) {
    for (c in 0:3) {
      for (i in 1:4) {
        assign(paste("hbw",w,h,c,i,sep=''), get(paste("hbw",w,h,c,i,sep='')) * ms.hbwFactor)
      }
    }
  }
}

# Adjust Attractions
ma.hbwat <- ma.hbwat * ms.hbwFactor

###################################

# Calculate Percentage Productions by worker, hh size, cval, and income

hbwLowInc.m<-ma.hbwprl
hbwLowInc.m[hbwLowInc.m==0]<-0.000001
hbwMedInc.m<-ma.hbwprm
hbwMedInc.m[hbwMedInc.m==0]<-0.000001
hbwHiInc.m<-ma.hbwprh
hbwHiInc.m[hbwHiInc.m==0]<-0.000001

# A=1 worker      A=HH1    #=CVAL    l=low income
# B=2,3 workers   B=HH2              m=mid income
#                 C=HH34             h=high income

malist.hbw<-list(
ma.hbwAA0l=(hbw1101)/hbwLowInc.m,
ma.hbwAA0m=(hbw1102+
            hbw1103)/hbwMedInc.m,
ma.hbwAA0h=(hbw1104)/hbwHiInc.m,
ma.hbwAA1l=rep(0,length(ma.hbwpr)),
ma.hbwAA1m=rep(0,length(ma.hbwpr)),
ma.hbwAA1h=rep(0,length(ma.hbwpr)),
ma.hbwAA2l=(hbw1121)/hbwLowInc.m,
ma.hbwAA2m=(hbw1122+
            hbw1123)/hbwMedInc.m,
ma.hbwAA2h=(hbw1124)/hbwHiInc.m,
ma.hbwAA3l=(hbw1131)/hbwLowInc.m,
ma.hbwAA3m=(hbw1132+
            hbw1133)/hbwMedInc.m,
ma.hbwAA3h=(hbw1134)/hbwHiInc.m,
ma.hbwAB0l=(hbw1201)/hbwLowInc.m,
ma.hbwAB0m=(hbw1202+
            hbw1203)/hbwMedInc.m,
ma.hbwAB0h=(hbw1204)/hbwHiInc.m,
ma.hbwAB1l=(hbw1211)/hbwLowInc.m,
ma.hbwAB1m=(hbw1212+
            hbw1213)/hbwMedInc.m,
ma.hbwAB1h=(hbw1214)/hbwHiInc.m,
ma.hbwAB2l=(hbw1221)/hbwLowInc.m,
ma.hbwAB2m=(hbw1222+
            hbw1223)/hbwMedInc.m,
ma.hbwAB2h=(hbw1224)/hbwHiInc.m,
ma.hbwAB3l=(hbw1231)/hbwLowInc.m,
ma.hbwAB3m=(hbw1232+
            hbw1233)/hbwMedInc.m,
ma.hbwAB3h=(hbw1234)/hbwHiInc.m,
ma.hbwAC0l=(hbw1301+hbw1401)/hbwLowInc.m,
ma.hbwAC0m=(hbw1302+hbw1402+
            hbw1303+hbw1403)/hbwMedInc.m,
ma.hbwAC0h=(hbw1304+hbw1404)/hbwHiInc.m,
ma.hbwAC1l=(hbw1311+hbw1411)/hbwLowInc.m,
ma.hbwAC1m=(hbw1312+hbw1412+
            hbw1313+hbw1413)/hbwMedInc.m,
ma.hbwAC1h=(hbw1314+hbw1414)/hbwHiInc.m,
ma.hbwAC2l=(hbw1321+hbw1421)/hbwLowInc.m,
ma.hbwAC2m=(hbw1322+hbw1422+
            hbw1323+hbw1423)/hbwMedInc.m,
ma.hbwAC2h=(hbw1324+hbw1424)/hbwHiInc.m,
ma.hbwAC3l=(hbw1331+hbw1431)/hbwLowInc.m,
ma.hbwAC3m=(hbw1332+hbw1432+
            hbw1333+hbw1433)/hbwMedInc.m,
ma.hbwAC3h=(hbw1334+hbw1434)/hbwHiInc.m,
ma.hbwBA0l=rep(0,length(ma.hbwpr)),
ma.hbwBA0m=rep(0,length(ma.hbwpr)),
ma.hbwBA0h=rep(0,length(ma.hbwpr)),
ma.hbwBA1l=rep(0,length(ma.hbwpr)),
ma.hbwBA1m=rep(0,length(ma.hbwpr)),
ma.hbwBA1h=rep(0,length(ma.hbwpr)),
ma.hbwBA2l=rep(0,length(ma.hbwpr)),
ma.hbwBA2m=rep(0,length(ma.hbwpr)),
ma.hbwBA2h=rep(0,length(ma.hbwpr)),
ma.hbwBA3l=rep(0,length(ma.hbwpr)),
ma.hbwBA3m=rep(0,length(ma.hbwpr)),
ma.hbwBA3h=rep(0,length(ma.hbwpr)),
ma.hbwBB0l=(hbw2201+hbw3201)/hbwLowInc.m,
ma.hbwBB0m=(hbw2202+hbw3202+
            hbw2203+hbw3203)/hbwMedInc.m,
ma.hbwBB0h=(hbw2204+hbw3204)/hbwHiInc.m,
ma.hbwBB1l=(hbw2211+hbw3211)/hbwLowInc.m,
ma.hbwBB1m=(hbw2212+hbw3212+
            hbw2213+hbw3213)/hbwMedInc.m,
ma.hbwBB1h=(hbw2214+hbw3214)/hbwHiInc.m,
ma.hbwBB2l=(hbw2221+hbw3221)/hbwLowInc.m,
ma.hbwBB2m=(hbw2222+hbw3222+
            hbw2223+hbw3223)/hbwMedInc.m,
ma.hbwBB2h=(hbw2224+hbw3224)/hbwHiInc.m,
ma.hbwBB3l=(hbw2231+hbw3231)/hbwLowInc.m,
ma.hbwBB3m=(hbw2232+hbw3232+
            hbw2233+hbw3233)/hbwMedInc.m,
ma.hbwBB3h=(hbw2234+hbw3234)/hbwHiInc.m,
ma.hbwBC0l=(hbw2301+hbw2401+hbw3301+hbw3401)/hbwLowInc.m,
ma.hbwBC0m=(hbw2302+hbw2402+hbw3302+hbw3402+
            hbw2303+hbw2403+hbw3303+hbw3403)/hbwMedInc.m,
ma.hbwBC0h=(hbw2304+hbw2404+hbw3304+hbw3404)/hbwHiInc.m,
ma.hbwBC1l=(hbw2311+hbw2411+hbw3311+hbw3411)/hbwLowInc.m,
ma.hbwBC1m=(hbw2312+hbw2412+hbw3312+hbw3412+
            hbw2313+hbw2413+hbw3313+hbw3413)/hbwMedInc.m,
ma.hbwBC1h=(hbw2314+hbw2414+hbw3314+hbw3414)/hbwHiInc.m,
ma.hbwBC2l=(hbw2321+hbw2421+hbw3321+hbw3421)/hbwLowInc.m,
ma.hbwBC2m=(hbw2322+hbw2422+hbw3322+hbw3422+
            hbw2323+hbw2423+hbw3323+hbw3423)/hbwMedInc.m,
ma.hbwBC2h=(hbw2324+hbw2424+hbw3324+hbw3424)/hbwHiInc.m,
ma.hbwBC3l=(hbw2331+hbw2431+hbw3331+hbw3431)/hbwLowInc.m,
ma.hbwBC3m=(hbw2332+hbw2432+hbw3332+hbw3432+
            hbw2333+hbw2433+hbw3333+hbw3433)/hbwMedInc.m,
ma.hbwBC3h=(hbw2334+hbw2434+hbw3334+hbw3434)/hbwHiInc.m,
ma.hbwpr=ma.hbwpr, ma.hbwprl=ma.hbwprl, ma.hbwprm=ma.hbwprm, ma.hbwprh=ma.hbwprh,
ma.hbwat=ma.hbwat)

save(malist.hbw,file="malist.hbw.dat")

rm(hbwLowInc.m,hbwMedInc.m,hbwHiInc.m,
   hbw0101,hbw0102,hbw0103,hbw0104,hbw0201,hbw0202,hbw0203,hbw0204,hbw0301,hbw0302,hbw0303,hbw0304,hbw0401,hbw0402,hbw0403,hbw0404,
   hbw1101,hbw1102,hbw1103,hbw1104,hbw1201,hbw1202,hbw1203,hbw1204,hbw1301,hbw1302,hbw1303,hbw1304,hbw1401,hbw1402,hbw1403,hbw1404,
   hbw2101,hbw2102,hbw2103,hbw2104,hbw2201,hbw2202,hbw2203,hbw2204,hbw2301,hbw2302,hbw2303,hbw2304,hbw2401,hbw2402,hbw2403,hbw2404,
   hbw3101,hbw3102,hbw3103,hbw3104,hbw3201,hbw3202,hbw3203,hbw3204,hbw3301,hbw3302,hbw3303,hbw3304,hbw3401,hbw3402,hbw3403,hbw3404,
   hbw0111,hbw0112,hbw0113,hbw0114,hbw0211,hbw0212,hbw0213,hbw0214,hbw0311,hbw0312,hbw0313,hbw0314,hbw0411,hbw0412,hbw0413,hbw0414,
   hbw1111,hbw1112,hbw1113,hbw1114,hbw1211,hbw1212,hbw1213,hbw1214,hbw1311,hbw1312,hbw1313,hbw1314,hbw1411,hbw1412,hbw1413,hbw1414,
   hbw2111,hbw2112,hbw2113,hbw2114,hbw2211,hbw2212,hbw2213,hbw2214,hbw2311,hbw2312,hbw2313,hbw2314,hbw2411,hbw2412,hbw2413,hbw2414,
   hbw3111,hbw3112,hbw3113,hbw3114,hbw3211,hbw3212,hbw3213,hbw3214,hbw3311,hbw3312,hbw3313,hbw3314,hbw3411,hbw3412,hbw3413,hbw3414,
   hbw0121,hbw0122,hbw0123,hbw0124,hbw0221,hbw0222,hbw0223,hbw0224,hbw0321,hbw0322,hbw0323,hbw0324,hbw0421,hbw0422,hbw0423,hbw0424,
   hbw1121,hbw1122,hbw1123,hbw1124,hbw1221,hbw1222,hbw1223,hbw1224,hbw1321,hbw1322,hbw1323,hbw1324,hbw1421,hbw1422,hbw1423,hbw1424,
   hbw2121,hbw2122,hbw2123,hbw2124,hbw2221,hbw2222,hbw2223,hbw2224,hbw2321,hbw2322,hbw2323,hbw2324,hbw2421,hbw2422,hbw2423,hbw2424,
   hbw3121,hbw3122,hbw3123,hbw3124,hbw3221,hbw3222,hbw3223,hbw3224,hbw3321,hbw3322,hbw3323,hbw3324,hbw3421,hbw3422,hbw3423,hbw3424,
   hbw0131,hbw0132,hbw0133,hbw0134,hbw0231,hbw0232,hbw0233,hbw0234,hbw0331,hbw0332,hbw0333,hbw0334,hbw0431,hbw0432,hbw0433,hbw0434,
   hbw1131,hbw1132,hbw1133,hbw1134,hbw1231,hbw1232,hbw1233,hbw1234,hbw1331,hbw1332,hbw1333,hbw1334,hbw1431,hbw1432,hbw1433,hbw1434,
   hbw2131,hbw2132,hbw2133,hbw2134,hbw2231,hbw2232,hbw2233,hbw2234,hbw2331,hbw2332,hbw2333,hbw2334,hbw2431,hbw2432,hbw2433,hbw2434,
   hbw3131,hbw3132,hbw3133,hbw3134,hbw3231,hbw3232,hbw3233,hbw3234,hbw3331,hbw3332,hbw3333,hbw3334,hbw3431,hbw3432,hbw3433,hbw3434)
