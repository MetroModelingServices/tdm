#k.hbsgen.R

# HBS Trip Production Rates
r1  <- 0.5889655  #  0-Worker, 1 PerHH
r2  <- 1.02852    #  0-Worker, 2 PerHH
r3  <- 1.371429   #  0-Worker, 3 PerHH
r4  <- 1.847826   #  0-Worker, 4+ PerHH
r5  <- 0.3597194  #  1-Worker, 1 PerHH
r6  <- 0.7578216  #  1-Worker, 2 PerHH
r7  <- 1.121711   #  1-Worker, 3 PerHH
r8  <- 1.260241   #  1-Worker, 4+ PerHH
r9  <- 0.6313181  #  2-Worker, 2 PerHH
r10 <- 0.9657534  #  2-Worker, 3 PerHH
r11 <- 0.9130435  #  2-Worker, 4+ PerHH
r12 <- 0.8703704  #  3+-Worker, 3 PerHH
r13 <- 1.14375    #  3+-Worker, 4+ PerHH

## CVAL 0 (cars=0)

#  workers  HHsize  cval  income
hbs0101<-apply(mf.cval[,1:4],1,sum)*r1*HBS.gen.calibrationFac
hbs0102<-apply(mf.cval[,5:8],1,sum)*r1*HBS.gen.calibrationFac
hbs0103<-apply(mf.cval[,9:12],1,sum)*r1*HBS.gen.calibrationFac
hbs0104<-apply(mf.cval[,13:16],1,sum)*r1*HBS.gen.calibrationFac
hbs0201<-apply(mf.cval[,17:20],1,sum)*r2*HBS.gen.calibrationFac
hbs0202<-apply(mf.cval[,21:24],1,sum)*r2*HBS.gen.calibrationFac
hbs0203<-apply(mf.cval[,25:28],1,sum)*r2*HBS.gen.calibrationFac
hbs0204<-apply(mf.cval[,29:32],1,sum)*r2*HBS.gen.calibrationFac
hbs0301<-apply(mf.cval[,33:36],1,sum)*r3*HBS.gen.calibrationFac
hbs0302<-apply(mf.cval[,37:40],1,sum)*r3*HBS.gen.calibrationFac
hbs0303<-apply(mf.cval[,41:44],1,sum)*r3*HBS.gen.calibrationFac
hbs0304<-apply(mf.cval[,45:48],1,sum)*r3*HBS.gen.calibrationFac
hbs0401<-apply(mf.cval[,49:52],1,sum)*r4*HBS.gen.calibrationFac
hbs0402<-apply(mf.cval[,53:56],1,sum)*r4*HBS.gen.calibrationFac
hbs0403<-apply(mf.cval[,57:60],1,sum)*r4*HBS.gen.calibrationFac
hbs0404<-apply(mf.cval[,61:64],1,sum)*r4*HBS.gen.calibrationFac
hbs1101<-apply(mf.cval[,65:68],1,sum)*r5*HBS.gen.calibrationFac
hbs1102<-apply(mf.cval[,69:72],1,sum)*r5*HBS.gen.calibrationFac
hbs1103<-apply(mf.cval[,73:76],1,sum)*r5*HBS.gen.calibrationFac
hbs1104<-apply(mf.cval[,77:80],1,sum)*r5*HBS.gen.calibrationFac
hbs1201<-apply(mf.cval[,81:84],1,sum)*r6*HBS.gen.calibrationFac
hbs1202<-apply(mf.cval[,85:88],1,sum)*r6*HBS.gen.calibrationFac
hbs1203<-apply(mf.cval[,89:92],1,sum)*r6*HBS.gen.calibrationFac
hbs1204<-apply(mf.cval[,93:96],1,sum)*r6*HBS.gen.calibrationFac
hbs1301<-apply(mf.cval[,97:100],1,sum)*r7*HBS.gen.calibrationFac
hbs1302<-apply(mf.cval[,101:104],1,sum)*r7*HBS.gen.calibrationFac
hbs1303<-apply(mf.cval[,105:108],1,sum)*r7*HBS.gen.calibrationFac
hbs1304<-apply(mf.cval[,109:112],1,sum)*r7*HBS.gen.calibrationFac
hbs1401<-apply(mf.cval[,113:116],1,sum)*r8*HBS.gen.calibrationFac
hbs1402<-apply(mf.cval[,117:120],1,sum)*r8*HBS.gen.calibrationFac
hbs1403<-apply(mf.cval[,121:124],1,sum)*r8*HBS.gen.calibrationFac
hbs1404<-apply(mf.cval[,125:128],1,sum)*r8*HBS.gen.calibrationFac
hbs2101<-0  #illogical: workers > hh
hbs2102<-0  #illogical: workers > hh
hbs2103<-0  #illogical: workers > hh
hbs2104<-0  #illogical: workers > hh
hbs2201<-apply(mf.cval[,145:148],1,sum)*r9*HBS.gen.calibrationFac
hbs2202<-apply(mf.cval[,149:152],1,sum)*r9*HBS.gen.calibrationFac
hbs2203<-apply(mf.cval[,153:156],1,sum)*r9*HBS.gen.calibrationFac
hbs2204<-apply(mf.cval[,157:160],1,sum)*r9*HBS.gen.calibrationFac
hbs2301<-apply(mf.cval[,161:164],1,sum)*r10*HBS.gen.calibrationFac
hbs2302<-apply(mf.cval[,165:168],1,sum)*r10*HBS.gen.calibrationFac
hbs2303<-apply(mf.cval[,169:172],1,sum)*r10*HBS.gen.calibrationFac
hbs2304<-apply(mf.cval[,173:176],1,sum)*r10*HBS.gen.calibrationFac
hbs2401<-apply(mf.cval[,177:180],1,sum)*r11*HBS.gen.calibrationFac
hbs2402<-apply(mf.cval[,181:184],1,sum)*r11*HBS.gen.calibrationFac
hbs2403<-apply(mf.cval[,185:188],1,sum)*r11*HBS.gen.calibrationFac
hbs2404<-apply(mf.cval[,189:192],1,sum)*r11*HBS.gen.calibrationFac
hbs3101<-0  #illogical: workers > hh
hbs3102<-0  #illogical: workers > hh
hbs3103<-0  #illogical: workers > hh
hbs3104<-0  #illogical: workers > hh
hbs3201<-0  #illogical: workers > hh
hbs3202<-0  #illogical: workers > hh
hbs3203<-0  #illogical: workers > hh
hbs3204<-0  #illogical: workers > hh
hbs3301<-apply(mf.cval[,225:228],1,sum)*r12*HBS.gen.calibrationFac
hbs3302<-apply(mf.cval[,229:232],1,sum)*r12*HBS.gen.calibrationFac
hbs3303<-apply(mf.cval[,233:236],1,sum)*r12*HBS.gen.calibrationFac
hbs3304<-apply(mf.cval[,237:240],1,sum)*r12*HBS.gen.calibrationFac
hbs3401<-apply(mf.cval[,241:244],1,sum)*r13*HBS.gen.calibrationFac
hbs3402<-apply(mf.cval[,245:248],1,sum)*r13*HBS.gen.calibrationFac
hbs3403<-apply(mf.cval[,249:252],1,sum)*r13*HBS.gen.calibrationFac
hbs3404<-apply(mf.cval[,253:256],1,sum)*r13*HBS.gen.calibrationFac

## CVAL 1 (cars<workers)

#  workers  HHsize  cval  income
hbs0111<-0  #illogical: 0 worker hh cannot be CVAL1 
hbs0112<-0  #illogical: 0 worker hh cannot be CVAL1 
hbs0113<-0  #illogical: 0 worker hh cannot be CVAL1 
hbs0114<-0  #illogical: 0 worker hh cannot be CVAL1 
hbs0211<-0  #illogical: 0 worker hh cannot be CVAL1
hbs0212<-0  #illogical: 0 worker hh cannot be CVAL1
hbs0213<-0  #illogical: 0 worker hh cannot be CVAL1 
hbs0214<-0  #illogical: 0 worker hh cannot be CVAL1 
hbs0311<-0  #illogical: 0 worker hh cannot be CVAL1 
hbs0312<-0  #illogical: 0 worker hh cannot be CVAL1 
hbs0313<-0  #illogical: 0 worker hh cannot be CVAL1 
hbs0314<-0  #illogical: 0 worker hh cannot be CVAL1 
hbs0411<-0  #illogical: 0 worker hh cannot be CVAL1 
hbs0412<-0  #illogical: 0 worker hh cannot be CVAL1 
hbs0413<-0  #illogical: 0 worker hh cannot be CVAL1 
hbs0414<-0  #illogical: 0 worker hh cannot be CVAL1
hbs1111<-0  #illogical: 1 worker hh cannot be CVAL1
hbs1112<-0  #illogical: 1 worker hh cannot be CVAL1
hbs1113<-0  #illogical: 1 worker hh cannot be CVAL1
hbs1114<-0  #illogical: 1 worker hh cannot be CVAL1
hbs1211<-0  #illogical: 1 worker hh cannot be CVAL1
hbs1212<-0  #illogical: 1 worker hh cannot be CVAL1
hbs1213<-0  #illogical: 1 worker hh cannot be CVAL1
hbs1214<-0  #illogical: 1 worker hh cannot be CVAL1
hbs1311<-0  #illogical: 1 worker hh cannot be CVAL1
hbs1312<-0  #illogical: 1 worker hh cannot be CVAL1
hbs1313<-0  #illogical: 1 worker hh cannot be CVAL1
hbs1314<-0  #illogical: 1 worker hh cannot be CVAL1
hbs1411<-0  #illogical: 1 worker hh cannot be CVAL1
hbs1412<-0  #illogical: 1 worker hh cannot be CVAL1
hbs1413<-0  #illogical: 1 worker hh cannot be CVAL1
hbs1414<-0  #illogical: 1 worker hh cannot be CVAL1
hbs2111<-0  #illogical: workers > hh
hbs2112<-0  #illogical: workers > hh
hbs2113<-0  #illogical: workers > hh
hbs2114<-0  #illogical: workers > hh
hbs2211<-apply(mf.cval[,273:276],1,sum)*r9*HBS.gen.calibrationFac
hbs2212<-apply(mf.cval[,277:280],1,sum)*r9*HBS.gen.calibrationFac
hbs2213<-apply(mf.cval[,281:284],1,sum)*r9*HBS.gen.calibrationFac
hbs2214<-apply(mf.cval[,285:288],1,sum)*r9*HBS.gen.calibrationFac
hbs2311<-apply(mf.cval[,289:292],1,sum)*r10*HBS.gen.calibrationFac
hbs2312<-apply(mf.cval[,293:296],1,sum)*r10*HBS.gen.calibrationFac
hbs2313<-apply(mf.cval[,297:300],1,sum)*r10*HBS.gen.calibrationFac
hbs2314<-apply(mf.cval[,301:304],1,sum)*r10*HBS.gen.calibrationFac
hbs2411<-apply(mf.cval[,305:308],1,sum)*r11*HBS.gen.calibrationFac
hbs2412<-apply(mf.cval[,309:312],1,sum)*r11*HBS.gen.calibrationFac
hbs2413<-apply(mf.cval[,313:316],1,sum)*r11*HBS.gen.calibrationFac
hbs2414<-apply(mf.cval[,317:320],1,sum)*r11*HBS.gen.calibrationFac
hbs3111<-0  #illogical: workers > hh
hbs3112<-0  #illogical: workers > hh
hbs3113<-0  #illogical: workers > hh
hbs3114<-0  #illogical: workers > hh
hbs3211<-0  #illogical: workers > hh
hbs3212<-0  #illogical: workers > hh
hbs3213<-0  #illogical: workers > hh
hbs3214<-0  #illogical: workers > hh
hbs3311<-apply(mf.cval[,c(353:356,417:420)],1,sum)*r12*HBS.gen.calibrationFac
hbs3312<-apply(mf.cval[,c(357:360,421:424)],1,sum)*r12*HBS.gen.calibrationFac
hbs3313<-apply(mf.cval[,c(361:364,425:428)],1,sum)*r12*HBS.gen.calibrationFac
hbs3314<-apply(mf.cval[,c(365:368,429:432)],1,sum)*r12*HBS.gen.calibrationFac
hbs3411<-apply(mf.cval[,c(369:372,433:436)],1,sum)*r13*HBS.gen.calibrationFac
hbs3412<-apply(mf.cval[,c(373:376,437:440)],1,sum)*r13*HBS.gen.calibrationFac
hbs3413<-apply(mf.cval[,c(377:380,441:444)],1,sum)*r13*HBS.gen.calibrationFac
hbs3414<-apply(mf.cval[,c(381:384,445:448)],1,sum)*r13*HBS.gen.calibrationFac

## CVAL 2 (cars=workers)

#  workers  HHsize  cval  income
hbs0121<-0  #illogical: 0 worker hh cannot be CVAL2
hbs0122<-0  #illogical: 0 worker hh cannot be CVAL2
hbs0123<-0  #illogical: 0 worker hh cannot be CVAL2
hbs0124<-0  #illogical: 0 worker hh cannot be CVAL2
hbs0221<-0  #illogical: 0 worker hh cannot be CVAL2
hbs0222<-0  #illogical: 0 worker hh cannot be CVAL2
hbs0223<-0  #illogical: 0 worker hh cannot be CVAL2
hbs0224<-0  #illogical: 0 worker hh cannot be CVAL2
hbs0321<-0  #illogical: 0 worker hh cannot be CVAL2
hbs0322<-0  #illogical: 0 worker hh cannot be CVAL2
hbs0323<-0  #illogical: 0 worker hh cannot be CVAL2
hbs0324<-0  #illogical: 0 worker hh cannot be CVAL2
hbs0421<-0  #illogical: 0 worker hh cannot be CVAL2
hbs0422<-0  #illogical: 0 worker hh cannot be CVAL2
hbs0423<-0  #illogical: 0 worker hh cannot be CVAL2
hbs0424<-0  #illogical: 0 worker hh cannot be CVAL2
hbs1121<-apply(mf.cval[,449:452],1,sum)*r5*HBS.gen.calibrationFac
hbs1122<-apply(mf.cval[,453:456],1,sum)*r5*HBS.gen.calibrationFac
hbs1123<-apply(mf.cval[,457:460],1,sum)*r5*HBS.gen.calibrationFac
hbs1124<-apply(mf.cval[,461:464],1,sum)*r5*HBS.gen.calibrationFac
hbs1221<-apply(mf.cval[,465:468],1,sum)*r6*HBS.gen.calibrationFac
hbs1222<-apply(mf.cval[,469:472],1,sum)*r6*HBS.gen.calibrationFac
hbs1223<-apply(mf.cval[,473:476],1,sum)*r6*HBS.gen.calibrationFac
hbs1224<-apply(mf.cval[,477:480],1,sum)*r6*HBS.gen.calibrationFac
hbs1321<-apply(mf.cval[,481:484],1,sum)*r7*HBS.gen.calibrationFac
hbs1322<-apply(mf.cval[,485:488],1,sum)*r7*HBS.gen.calibrationFac
hbs1323<-apply(mf.cval[,489:492],1,sum)*r7*HBS.gen.calibrationFac
hbs1324<-apply(mf.cval[,493:496],1,sum)*r7*HBS.gen.calibrationFac
hbs1421<-apply(mf.cval[,497:500],1,sum)*r8*HBS.gen.calibrationFac
hbs1422<-apply(mf.cval[,501:504],1,sum)*r8*HBS.gen.calibrationFac
hbs1423<-apply(mf.cval[,505:508],1,sum)*r8*HBS.gen.calibrationFac
hbs1424<-apply(mf.cval[,509:512],1,sum)*r8*HBS.gen.calibrationFac
hbs2121<-0  #illogical: workers > hh
hbs2122<-0  #illogical: workers > hh
hbs2123<-0  #illogical: workers > hh
hbs2124<-0  #illogical: workers > hh
hbs2221<-apply(mf.cval[,529:532],1,sum)*r9*HBS.gen.calibrationFac
hbs2222<-apply(mf.cval[,533:536],1,sum)*r9*HBS.gen.calibrationFac
hbs2223<-apply(mf.cval[,537:540],1,sum)*r9*HBS.gen.calibrationFac
hbs2224<-apply(mf.cval[,541:544],1,sum)*r9*HBS.gen.calibrationFac
hbs2321<-apply(mf.cval[,545:548],1,sum)*r10*HBS.gen.calibrationFac
hbs2322<-apply(mf.cval[,549:552],1,sum)*r10*HBS.gen.calibrationFac
hbs2323<-apply(mf.cval[,553:556],1,sum)*r10*HBS.gen.calibrationFac
hbs2324<-apply(mf.cval[,557:560],1,sum)*r10*HBS.gen.calibrationFac
hbs2421<-apply(mf.cval[,561:564],1,sum)*r11*HBS.gen.calibrationFac
hbs2422<-apply(mf.cval[,565:568],1,sum)*r11*HBS.gen.calibrationFac
hbs2423<-apply(mf.cval[,569:572],1,sum)*r11*HBS.gen.calibrationFac
hbs2424<-apply(mf.cval[,573:576],1,sum)*r11*HBS.gen.calibrationFac
hbs3121<-0  #illogical: workers > hh
hbs3122<-0  #illogical: workers > hh
hbs3123<-0  #illogical: workers > hh
hbs3124<-0  #illogical: workers > hh
hbs3221<-0  #illogical: workers > hh
hbs3222<-0  #illogical: workers > hh
hbs3223<-0  #illogical: workers > hh
hbs3224<-0  #illogical: workers > hh
hbs3321<-apply(mf.cval[,609:612],1,sum)*r12*HBS.gen.calibrationFac
hbs3322<-apply(mf.cval[,613:616],1,sum)*r12*HBS.gen.calibrationFac
hbs3323<-apply(mf.cval[,617:620],1,sum)*r12*HBS.gen.calibrationFac
hbs3324<-apply(mf.cval[,621:624],1,sum)*r12*HBS.gen.calibrationFac
hbs3421<-apply(mf.cval[,625:628],1,sum)*r13*HBS.gen.calibrationFac
hbs3422<-apply(mf.cval[,629:632],1,sum)*r13*HBS.gen.calibrationFac
hbs3423<-apply(mf.cval[,633:636],1,sum)*r13*HBS.gen.calibrationFac
hbs3424<-apply(mf.cval[,637:640],1,sum)*r13*HBS.gen.calibrationFac

## CVAL 3 (cars>workers)

#  workers  HHsize  cval  income
hbs0131<-apply(mf.cval[,c(641:644,705:708,833:836)],1,sum)*r1*HBS.gen.calibrationFac
hbs0132<-apply(mf.cval[,c(645:648,709:712,837:840)],1,sum)*r1*HBS.gen.calibrationFac
hbs0133<-apply(mf.cval[,c(649:652,713:716,841:844)],1,sum)*r1*HBS.gen.calibrationFac
hbs0134<-apply(mf.cval[,c(653:656,717:720,845:848)],1,sum)*r1*HBS.gen.calibrationFac
hbs0231<-apply(mf.cval[,c(657:660,721:724,849:852)],1,sum)*r2*HBS.gen.calibrationFac
hbs0232<-apply(mf.cval[,c(661:664,725:728,853:856)],1,sum)*r2*HBS.gen.calibrationFac
hbs0233<-apply(mf.cval[,c(665:668,729:732,857:860)],1,sum)*r2*HBS.gen.calibrationFac
hbs0234<-apply(mf.cval[,c(669:672,733:736,861:864)],1,sum)*r2*HBS.gen.calibrationFac
hbs0331<-apply(mf.cval[,c(673:676,737:740,865:868)],1,sum)*r3*HBS.gen.calibrationFac
hbs0332<-apply(mf.cval[,c(677:680,741:744,869:872)],1,sum)*r3*HBS.gen.calibrationFac
hbs0333<-apply(mf.cval[,c(681:684,745:748,873:876)],1,sum)*r3*HBS.gen.calibrationFac
hbs0334<-apply(mf.cval[,c(685:688,749:752,877:880)],1,sum)*r3*HBS.gen.calibrationFac
hbs0431<-apply(mf.cval[,c(689:692,753:756,881:884)],1,sum)*r4*HBS.gen.calibrationFac
hbs0432<-apply(mf.cval[,c(693:696,757:760,885:888)],1,sum)*r4*HBS.gen.calibrationFac
hbs0433<-apply(mf.cval[,c(697:700,761:764,889:892)],1,sum)*r4*HBS.gen.calibrationFac
hbs0434<-apply(mf.cval[,c(701:704,765:768,893:896)],1,sum)*r4*HBS.gen.calibrationFac
hbs1131<-apply(mf.cval[,c(769:772,897:900)],1,sum)*r5*HBS.gen.calibrationFac
hbs1132<-apply(mf.cval[,c(773:776,901:904)],1,sum)*r5*HBS.gen.calibrationFac
hbs1133<-apply(mf.cval[,c(777:780,905:908)],1,sum)*r5*HBS.gen.calibrationFac
hbs1134<-apply(mf.cval[,c(781:784,909:912)],1,sum)*r5*HBS.gen.calibrationFac
hbs1231<-apply(mf.cval[,c(785:788,913:916)],1,sum)*r6*HBS.gen.calibrationFac
hbs1232<-apply(mf.cval[,c(789:792,917:920)],1,sum)*r6*HBS.gen.calibrationFac
hbs1233<-apply(mf.cval[,c(793:796,921:924)],1,sum)*r6*HBS.gen.calibrationFac
hbs1234<-apply(mf.cval[,c(797:800,925:928)],1,sum)*r6*HBS.gen.calibrationFac
hbs1331<-apply(mf.cval[,c(801:804,929:932)],1,sum)*r7*HBS.gen.calibrationFac
hbs1332<-apply(mf.cval[,c(805:808,933:936)],1,sum)*r7*HBS.gen.calibrationFac
hbs1333<-apply(mf.cval[,c(809:812,937:940)],1,sum)*r7*HBS.gen.calibrationFac
hbs1334<-apply(mf.cval[,c(813:816,941:944)],1,sum)*r7*HBS.gen.calibrationFac
hbs1431<-apply(mf.cval[,c(817:820,945:948)],1,sum)*r8*HBS.gen.calibrationFac
hbs1432<-apply(mf.cval[,c(821:824,949:952)],1,sum)*r8*HBS.gen.calibrationFac
hbs1433<-apply(mf.cval[,c(825:828,953:956)],1,sum)*r8*HBS.gen.calibrationFac
hbs1434<-apply(mf.cval[,c(829:832,957:960)],1,sum)*r8*HBS.gen.calibrationFac
hbs2131<-0  #illogical: workers > hh
hbs2132<-0  #illogical: workers > hh
hbs2133<-0  #illogical: workers > hh
hbs2134<-0  #illogical: workers > hh
hbs2231<-apply(mf.cval[,977:980],1,sum)*r9*HBS.gen.calibrationFac
hbs2232<-apply(mf.cval[,981:984],1,sum)*r9*HBS.gen.calibrationFac
hbs2233<-apply(mf.cval[,985:988],1,sum)*r9*HBS.gen.calibrationFac
hbs2234<-apply(mf.cval[,989:992],1,sum)*r9*HBS.gen.calibrationFac
hbs2331<-apply(mf.cval[,993:996],1,sum)*r10*HBS.gen.calibrationFac
hbs2332<-apply(mf.cval[,997:1000],1,sum)*r10*HBS.gen.calibrationFac
hbs2333<-apply(mf.cval[,1001:1004],1,sum)*r10*HBS.gen.calibrationFac
hbs2334<-apply(mf.cval[,1005:1008],1,sum)*r10*HBS.gen.calibrationFac
hbs2431<-apply(mf.cval[,1009:1012],1,sum)*r11*HBS.gen.calibrationFac
hbs2432<-apply(mf.cval[,1013:1016],1,sum)*r11*HBS.gen.calibrationFac
hbs2433<-apply(mf.cval[,1017:1020],1,sum)*r11*HBS.gen.calibrationFac
hbs2434<-apply(mf.cval[,1021:1024],1,sum)*r11*HBS.gen.calibrationFac
hbs3131<-0  #illogical: workers > hh
hbs3132<-0  #illogical: workers > hh
hbs3133<-0  #illogical: workers > hh
hbs3134<-0  #illogical: workers > hh
hbs3231<-0  #illogical: workers > hh
hbs3232<-0  #illogical: workers > hh
hbs3233<-0  #illogical: workers > hh
hbs3234<-0  #illogical: workers > hh
hbs3331<-0  #more than 3 cars not allowed
hbs3332<-0  #more than 3 cars not allowed
hbs3333<-0  #more than 3 cars not allowed
hbs3334<-0  #more than 3 cars not allowed
hbs3431<-0  #more than 3 cars not allowed
hbs3432<-0  #more than 3 cars not allowed
hbs3433<-0  #more than 3 cars not allowed
hbs3434<-0  #more than 3 cars not allowed 

#########################################

# TOTAL PRODUCTIONS

# Low Income Productions (income bin 1)
ma.hbsprl <- hbs0101+hbs0201+hbs0301+hbs0401+hbs1101+hbs1201+hbs1301+hbs1401+
             hbs2101+hbs2201+hbs2301+hbs2401+hbs3101+hbs3201+hbs3301+hbs3401+
             hbs0111+hbs0211+hbs0311+hbs0411+hbs1111+hbs1211+hbs1311+hbs1411+
             hbs2111+hbs2211+hbs2311+hbs2411+hbs3111+hbs3211+hbs3311+hbs3411+
             hbs0121+hbs0221+hbs0321+hbs0421+hbs1121+hbs1221+hbs1321+hbs1421+
             hbs2121+hbs2221+hbs2321+hbs2421+hbs3121+hbs3221+hbs3321+hbs3421+
             hbs0131+hbs0231+hbs0331+hbs0431+hbs1131+hbs1231+hbs1331+hbs1431+
             hbs2131+hbs2231+hbs2331+hbs2431+hbs3131+hbs3231+hbs3331+hbs3431

# Middle Income Productions (income bins 2 & 3)
ma.hbsprm <- hbs0102+hbs0202+hbs0302+hbs0402+hbs1102+hbs1202+hbs1302+hbs1402+
             hbs2102+hbs2202+hbs2302+hbs2402+hbs3102+hbs3202+hbs3302+hbs3402+
             hbs0112+hbs0212+hbs0312+hbs0412+hbs1112+hbs1212+hbs1312+hbs1412+
             hbs2112+hbs2212+hbs2312+hbs2412+hbs3112+hbs3212+hbs3312+hbs3412+
             hbs0122+hbs0222+hbs0322+hbs0422+hbs1122+hbs1222+hbs1322+hbs1422+
             hbs2122+hbs2222+hbs2322+hbs2422+hbs3122+hbs3222+hbs3322+hbs3422+
             hbs0132+hbs0232+hbs0332+hbs0432+hbs1132+hbs1232+hbs1332+hbs1432+
             hbs2132+hbs2232+hbs2332+hbs2432+hbs3132+hbs3232+hbs3332+hbs3432+
             hbs0103+hbs0203+hbs0303+hbs0403+hbs1103+hbs1203+hbs1303+hbs1403+
             hbs2103+hbs2203+hbs2303+hbs2403+hbs3103+hbs3203+hbs3303+hbs3403+
             hbs0113+hbs0213+hbs0313+hbs0413+hbs1113+hbs1213+hbs1313+hbs1413+
             hbs2113+hbs2213+hbs2313+hbs2413+hbs3113+hbs3213+hbs3313+hbs3413+
             hbs0123+hbs0223+hbs0323+hbs0423+hbs1123+hbs1223+hbs1323+hbs1423+
             hbs2123+hbs2223+hbs2323+hbs2423+hbs3123+hbs3223+hbs3323+hbs3423+
             hbs0133+hbs0233+hbs0333+hbs0433+hbs1133+hbs1233+hbs1333+hbs1433+
             hbs2133+hbs2233+hbs2333+hbs2433+hbs3133+hbs3233+hbs3333+hbs3433

# High Income Productions (income bin 4)
ma.hbsprh <- hbs0104+hbs0204+hbs0304+hbs0404+hbs1104+hbs1204+hbs1304+hbs1404+
             hbs2104+hbs2204+hbs2304+hbs2404+hbs3104+hbs3204+hbs3304+hbs3404+
             hbs0114+hbs0214+hbs0314+hbs0414+hbs1114+hbs1214+hbs1314+hbs1414+
             hbs2114+hbs2214+hbs2314+hbs2414+hbs3114+hbs3214+hbs3314+hbs3414+
             hbs0124+hbs0224+hbs0324+hbs0424+hbs1124+hbs1224+hbs1324+hbs1424+
             hbs2124+hbs2224+hbs2324+hbs2424+hbs3124+hbs3224+hbs3324+hbs3424+
             hbs0134+hbs0234+hbs0334+hbs0434+hbs1134+hbs1234+hbs1334+hbs1434+
             hbs2134+hbs2234+hbs2334+hbs2434+hbs3134+hbs3234+hbs3334+hbs3434

# Total Productions (All Incomes)
ma.hbspr <- ma.hbsprl + ma.hbsprm + ma.hbsprh

#############################################

# Calculate Percentage Productions by worker, hh size, cval, and income

hbsLowInc.m<-ma.hbsprl
hbsLowInc.m[hbsLowInc.m==0]<-1
hbsMedInc.m<-ma.hbsprm
hbsMedInc.m[hbsMedInc.m==0]<-1
hbsHiInc.m<-ma.hbsprh
hbsHiInc.m[hbsHiInc.m==0]<-1

# A=1 HH      #=CVAL    l=low income
# B=2 HH                m=mid income
# C=3,4+ HH             h=high income

malist.hbs<-list(
md.hbsA0l=(hbs0101+hbs1101+hbs2101+hbs3101)/hbsLowInc.m,
md.hbsB0l=(hbs0201+hbs1201+hbs2201+hbs3201)/hbsLowInc.m,
md.hbsA0m=(hbs0102+hbs1102+hbs2102+hbs3102+
           hbs0103+hbs1103+hbs2103+hbs3103)/hbsMedInc.m,
md.hbsB0m=(hbs0202+hbs1202+hbs2202+hbs3202+
           hbs0203+hbs1203+hbs2203+hbs3203)/hbsMedInc.m,
md.hbsA0h=(hbs0104+hbs1104+hbs2104+hbs3104)/hbsHiInc.m,
md.hbsB0h=(hbs0204+hbs1204+hbs2204+hbs3204)/hbsHiInc.m,
md.hbsA1l=(hbs0111+hbs1111+hbs2111+hbs3111)/hbsLowInc.m,
md.hbsB1l=(hbs0211+hbs1211+hbs2211+hbs3211)/hbsLowInc.m,
md.hbsA1m=(hbs0112+hbs1112+hbs2112+hbs3112+
           hbs0113+hbs1113+hbs2113+hbs3113)/hbsMedInc.m,
md.hbsB1m=(hbs0212+hbs1212+hbs2212+hbs3212+
           hbs0213+hbs1213+hbs2213+hbs3213)/hbsMedInc.m,
md.hbsA1h=(hbs0114+hbs1114+hbs2114+hbs3114)/hbsHiInc.m,
md.hbsB1h=(hbs0214+hbs1214+hbs2214+hbs3214)/hbsHiInc.m,
md.hbsA2l=(hbs0121+hbs1121+hbs2121+hbs3121)/hbsLowInc.m,
md.hbsB2l=(hbs0221+hbs1221+hbs2221+hbs3221)/hbsLowInc.m,
md.hbsA2m=(hbs0122+hbs1122+hbs2122+hbs3122+
           hbs0123+hbs1123+hbs2123+hbs3123)/hbsMedInc.m,
md.hbsB2m=(hbs0222+hbs1222+hbs2222+hbs3222+
           hbs0223+hbs1223+hbs2223+hbs3223)/hbsMedInc.m,
md.hbsA2h=(hbs0124+hbs1124+hbs2124+hbs3124)/hbsHiInc.m,
md.hbsB2h=(hbs0224+hbs1224+hbs2224+hbs3224)/hbsHiInc.m,
md.hbsA3l=(hbs0131+hbs1131+hbs2131+hbs3131)/hbsLowInc.m,
md.hbsB3l=(hbs0231+hbs1231+hbs2231+hbs3231)/hbsLowInc.m,
md.hbsA3m=(hbs0132+hbs1132+hbs2132+hbs3132+
           hbs0133+hbs1133+hbs2133+hbs3133)/hbsMedInc.m,
md.hbsB3m=(hbs0232+hbs1232+hbs2232+hbs3232+
           hbs0233+hbs1233+hbs2233+hbs3233)/hbsMedInc.m,
md.hbsA3h=(hbs0134+hbs1134+hbs2134+hbs3134)/hbsHiInc.m,
md.hbsB3h=(hbs0234+hbs1234+hbs2234+hbs3234)/hbsHiInc.m,
md.hbsC0l=(hbs0301+hbs0401+hbs1301+hbs1401+hbs2301+hbs2401+hbs3301+hbs3401)/hbsLowInc.m,
md.hbsC0m=(hbs0302+hbs0402+hbs1302+hbs1402+hbs2302+hbs2402+hbs3302+hbs3402+
           hbs0303+hbs0403+hbs1303+hbs1403+hbs2303+hbs2403+hbs3303+hbs3403)/hbsMedInc.m,
md.hbsC0h=(hbs0304+hbs0404+hbs1304+hbs1404+hbs2304+hbs2404+hbs3304+hbs3404)/hbsHiInc.m,
md.hbsC1l=(hbs0311+hbs0411+hbs1311+hbs1411+hbs2311+hbs2411+hbs3311+hbs3411)/hbsLowInc.m,
md.hbsC1m=(hbs0312+hbs0412+hbs1312+hbs1412+hbs2312+hbs2412+hbs3312+hbs3412+
           hbs0313+hbs0413+hbs1313+hbs1413+hbs2313+hbs2413+hbs3313+hbs3413)/hbsMedInc.m,
md.hbsC1h=(hbs0314+hbs0414+hbs1314+hbs1414+hbs2314+hbs2414+hbs3314+hbs3414)/hbsHiInc.m,
md.hbsC2l=(hbs0321+hbs0421+hbs1321+hbs1421+hbs2321+hbs2421+hbs3321+hbs3421)/hbsLowInc.m,
md.hbsC2m=(hbs0322+hbs0422+hbs1322+hbs1422+hbs2322+hbs2422+hbs3322+hbs3422+
           hbs0323+hbs0423+hbs1323+hbs1423+hbs2323+hbs2423+hbs3323+hbs3423)/hbsMedInc.m,
md.hbsC2h=(hbs0324+hbs0424+hbs1324+hbs1424+hbs2324+hbs2424+hbs3324+hbs3424)/hbsHiInc.m,
md.hbsC3l=(hbs0331+hbs0431+hbs1331+hbs1431+hbs2331+hbs2431+hbs3331+hbs3431)/hbsLowInc.m,
md.hbsC3m=(hbs0332+hbs0432+hbs1332+hbs1432+hbs2332+hbs2432+hbs3332+hbs3432+
           hbs0333+hbs0433+hbs1333+hbs1433+hbs2333+hbs2433+hbs3333+hbs3433)/hbsMedInc.m,
md.hbsC3h=(hbs0334+hbs0434+hbs1334+hbs1434+hbs2334+hbs2434+hbs3334+hbs3434)/hbsHiInc.m,
ma.hbspr=ma.hbspr, ma.hbsprl=ma.hbsprl, ma.hbsprm=ma.hbsprm, ma.hbsprh=ma.hbsprh)

save(malist.hbs,file="malist.hbs.dat")

rm(hbsLowInc.m,hbsMedInc.m,hbsHiInc.m,
   hbs0101,hbs0102,hbs0103,hbs0104,hbs0201,hbs0202,hbs0203,hbs0204,hbs0301,hbs0302,hbs0303,hbs0304,hbs0401,hbs0402,hbs0403,hbs0404,
   hbs1101,hbs1102,hbs1103,hbs1104,hbs1201,hbs1202,hbs1203,hbs1204,hbs1301,hbs1302,hbs1303,hbs1304,hbs1401,hbs1402,hbs1403,hbs1404,
   hbs2101,hbs2102,hbs2103,hbs2104,hbs2201,hbs2202,hbs2203,hbs2204,hbs2301,hbs2302,hbs2303,hbs2304,hbs2401,hbs2402,hbs2403,hbs2404,
   hbs3101,hbs3102,hbs3103,hbs3104,hbs3201,hbs3202,hbs3203,hbs3204,hbs3301,hbs3302,hbs3303,hbs3304,hbs3401,hbs3402,hbs3403,hbs3404,
   hbs0111,hbs0112,hbs0113,hbs0114,hbs0211,hbs0212,hbs0213,hbs0214,hbs0311,hbs0312,hbs0313,hbs0314,hbs0411,hbs0412,hbs0413,hbs0414,
   hbs1111,hbs1112,hbs1113,hbs1114,hbs1211,hbs1212,hbs1213,hbs1214,hbs1311,hbs1312,hbs1313,hbs1314,hbs1411,hbs1412,hbs1413,hbs1414,
   hbs2111,hbs2112,hbs2113,hbs2114,hbs2211,hbs2212,hbs2213,hbs2214,hbs2311,hbs2312,hbs2313,hbs2314,hbs2411,hbs2412,hbs2413,hbs2414,
   hbs3111,hbs3112,hbs3113,hbs3114,hbs3211,hbs3212,hbs3213,hbs3214,hbs3311,hbs3312,hbs3313,hbs3314,hbs3411,hbs3412,hbs3413,hbs3414,
   hbs0121,hbs0122,hbs0123,hbs0124,hbs0221,hbs0222,hbs0223,hbs0224,hbs0321,hbs0322,hbs0323,hbs0324,hbs0421,hbs0422,hbs0423,hbs0424,
   hbs1121,hbs1122,hbs1123,hbs1124,hbs1221,hbs1222,hbs1223,hbs1224,hbs1321,hbs1322,hbs1323,hbs1324,hbs1421,hbs1422,hbs1423,hbs1424,
   hbs2121,hbs2122,hbs2123,hbs2124,hbs2221,hbs2222,hbs2223,hbs2224,hbs2321,hbs2322,hbs2323,hbs2324,hbs2421,hbs2422,hbs2423,hbs2424,
   hbs3121,hbs3122,hbs3123,hbs3124,hbs3221,hbs3222,hbs3223,hbs3224,hbs3321,hbs3322,hbs3323,hbs3324,hbs3421,hbs3422,hbs3423,hbs3424,
   hbs0131,hbs0132,hbs0133,hbs0134,hbs0231,hbs0232,hbs0233,hbs0234,hbs0331,hbs0332,hbs0333,hbs0334,hbs0431,hbs0432,hbs0433,hbs0434,
   hbs1131,hbs1132,hbs1133,hbs1134,hbs1231,hbs1232,hbs1233,hbs1234,hbs1331,hbs1332,hbs1333,hbs1334,hbs1431,hbs1432,hbs1433,hbs1434,
   hbs2131,hbs2132,hbs2133,hbs2134,hbs2231,hbs2232,hbs2233,hbs2234,hbs2331,hbs2332,hbs2333,hbs2334,hbs2431,hbs2432,hbs2433,hbs2434,
   hbs3131,hbs3132,hbs3133,hbs3134,hbs3231,hbs3232,hbs3233,hbs3234,hbs3331,hbs3332,hbs3333,hbs3334,hbs3431,hbs3432,hbs3433,hbs3434)

