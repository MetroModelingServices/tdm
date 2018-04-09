#k.hbrgen.R

# HBR Trip Production Rates
r1 <- 0.2772414  #  Worker<Size, 1 PerHH
r2 <- 0.5582865  #  Worker<Size, 2 PerHH
r3 <- 0.7933884  #  Worker<Size, 3 PerHH
r4 <- 1.43126    #  Worker<Size, 4+ PerHH
r5 <- 0.1783567  #  Worker=Size, 1 PerHH
r6 <- 0.4122894  #  Worker=Size, 2 PerHH
r7 <- 0.5462963  #  Worker=Size, 3 PerHH

## CVAL 0 (cars=0)

#  workers  HHsize  cval  income
hbr0101<-apply(mf.cval[,1:4],1,sum)*r1*HBR.gen.calibrationFac
hbr0102<-apply(mf.cval[,5:8],1,sum)*r1*HBR.gen.calibrationFac
hbr0103<-apply(mf.cval[,9:12],1,sum)*r1*HBR.gen.calibrationFac
hbr0104<-apply(mf.cval[,13:16],1,sum)*r1*HBR.gen.calibrationFac
hbr0201<-apply(mf.cval[,17:20],1,sum)*r2*HBR.gen.calibrationFac
hbr0202<-apply(mf.cval[,21:24],1,sum)*r2*HBR.gen.calibrationFac
hbr0203<-apply(mf.cval[,25:28],1,sum)*r2*HBR.gen.calibrationFac
hbr0204<-apply(mf.cval[,29:32],1,sum)*r2*HBR.gen.calibrationFac
hbr0301<-apply(mf.cval[,33:36],1,sum)*r3*HBR.gen.calibrationFac
hbr0302<-apply(mf.cval[,37:40],1,sum)*r3*HBR.gen.calibrationFac
hbr0303<-apply(mf.cval[,41:44],1,sum)*r3*HBR.gen.calibrationFac
hbr0304<-apply(mf.cval[,45:48],1,sum)*r3*HBR.gen.calibrationFac
hbr0401<-apply(mf.cval[,49:52],1,sum)*r4*HBR.gen.calibrationFac
hbr0402<-apply(mf.cval[,53:56],1,sum)*r4*HBR.gen.calibrationFac
hbr0403<-apply(mf.cval[,57:60],1,sum)*r4*HBR.gen.calibrationFac
hbr0404<-apply(mf.cval[,61:64],1,sum)*r4*HBR.gen.calibrationFac
hbr1101<-apply(mf.cval[,65:68],1,sum)*r5*HBR.gen.calibrationFac
hbr1102<-apply(mf.cval[,69:72],1,sum)*r5*HBR.gen.calibrationFac
hbr1103<-apply(mf.cval[,73:76],1,sum)*r5*HBR.gen.calibrationFac
hbr1104<-apply(mf.cval[,77:80],1,sum)*r5*HBR.gen.calibrationFac
hbr1201<-apply(mf.cval[,81:84],1,sum)*r2*HBR.gen.calibrationFac
hbr1202<-apply(mf.cval[,85:88],1,sum)*r2*HBR.gen.calibrationFac
hbr1203<-apply(mf.cval[,89:92],1,sum)*r2*HBR.gen.calibrationFac
hbr1204<-apply(mf.cval[,93:96],1,sum)*r2*HBR.gen.calibrationFac
hbr1301<-apply(mf.cval[,97:100],1,sum)*r3*HBR.gen.calibrationFac
hbr1302<-apply(mf.cval[,101:104],1,sum)*r3*HBR.gen.calibrationFac
hbr1303<-apply(mf.cval[,105:108],1,sum)*r3*HBR.gen.calibrationFac
hbr1304<-apply(mf.cval[,109:112],1,sum)*r3*HBR.gen.calibrationFac
hbr1401<-apply(mf.cval[,113:116],1,sum)*r4*HBR.gen.calibrationFac
hbr1402<-apply(mf.cval[,117:120],1,sum)*r4*HBR.gen.calibrationFac
hbr1403<-apply(mf.cval[,121:124],1,sum)*r4*HBR.gen.calibrationFac
hbr1404<-apply(mf.cval[,125:128],1,sum)*r4*HBR.gen.calibrationFac
hbr2101<-0  #illogical: workers > hh
hbr2102<-0  #illogical: workers > hh
hbr2103<-0  #illogical: workers > hh
hbr2104<-0  #illogical: workers > hh
hbr2201<-apply(mf.cval[,145:148],1,sum)*r6*HBR.gen.calibrationFac
hbr2202<-apply(mf.cval[,149:152],1,sum)*r6*HBR.gen.calibrationFac
hbr2203<-apply(mf.cval[,153:156],1,sum)*r6*HBR.gen.calibrationFac
hbr2204<-apply(mf.cval[,157:160],1,sum)*r6*HBR.gen.calibrationFac
hbr2301<-apply(mf.cval[,161:164],1,sum)*r3*HBR.gen.calibrationFac
hbr2302<-apply(mf.cval[,165:168],1,sum)*r3*HBR.gen.calibrationFac
hbr2303<-apply(mf.cval[,169:172],1,sum)*r3*HBR.gen.calibrationFac
hbr2304<-apply(mf.cval[,173:176],1,sum)*r3*HBR.gen.calibrationFac
hbr2401<-apply(mf.cval[,177:180],1,sum)*r4*HBR.gen.calibrationFac
hbr2402<-apply(mf.cval[,181:184],1,sum)*r4*HBR.gen.calibrationFac
hbr2403<-apply(mf.cval[,185:188],1,sum)*r4*HBR.gen.calibrationFac
hbr2404<-apply(mf.cval[,189:192],1,sum)*r4*HBR.gen.calibrationFac
hbr3101<-0  #illogical: workers > hh
hbr3102<-0  #illogical: workers > hh
hbr3103<-0  #illogical: workers > hh
hbr3104<-0  #illogical: workers > hh
hbr3201<-0  #illogical: workers > hh
hbr3202<-0  #illogical: workers > hh
hbr3203<-0  #illogical: workers > hh
hbr3204<-0  #illogical: workers > hh
hbr3301<-apply(mf.cval[,225:228],1,sum)*r7*HBR.gen.calibrationFac
hbr3302<-apply(mf.cval[,229:232],1,sum)*r7*HBR.gen.calibrationFac
hbr3303<-apply(mf.cval[,233:236],1,sum)*r7*HBR.gen.calibrationFac
hbr3304<-apply(mf.cval[,237:240],1,sum)*r7*HBR.gen.calibrationFac
hbr3401<-apply(mf.cval[,241:244],1,sum)*r4*HBR.gen.calibrationFac
hbr3402<-apply(mf.cval[,245:248],1,sum)*r4*HBR.gen.calibrationFac
hbr3403<-apply(mf.cval[,249:252],1,sum)*r4*HBR.gen.calibrationFac
hbr3404<-apply(mf.cval[,253:256],1,sum)*r4*HBR.gen.calibrationFac

## CVAL 1 (cars<workers)

#  workers  HHsize  cval  income
hbr0111<-0  #illogical: 0 worker hh cannot be CVAL1 
hbr0112<-0  #illogical: 0 worker hh cannot be CVAL1 
hbr0113<-0  #illogical: 0 worker hh cannot be CVAL1 
hbr0114<-0  #illogical: 0 worker hh cannot be CVAL1 
hbr0211<-0  #illogical: 0 worker hh cannot be CVAL1
hbr0212<-0  #illogical: 0 worker hh cannot be CVAL1
hbr0213<-0  #illogical: 0 worker hh cannot be CVAL1 
hbr0214<-0  #illogical: 0 worker hh cannot be CVAL1 
hbr0311<-0  #illogical: 0 worker hh cannot be CVAL1 
hbr0312<-0  #illogical: 0 worker hh cannot be CVAL1 
hbr0313<-0  #illogical: 0 worker hh cannot be CVAL1 
hbr0314<-0  #illogical: 0 worker hh cannot be CVAL1 
hbr0411<-0  #illogical: 0 worker hh cannot be CVAL1 
hbr0412<-0  #illogical: 0 worker hh cannot be CVAL1 
hbr0413<-0  #illogical: 0 worker hh cannot be CVAL1 
hbr0414<-0  #illogical: 0 worker hh cannot be CVAL1
hbr1111<-0  #illogical: 1 worker hh cannot be CVAL1
hbr1112<-0  #illogical: 1 worker hh cannot be CVAL1
hbr1113<-0  #illogical: 1 worker hh cannot be CVAL1
hbr1114<-0  #illogical: 1 worker hh cannot be CVAL1
hbr1211<-0  #illogical: 1 worker hh cannot be CVAL1
hbr1212<-0  #illogical: 1 worker hh cannot be CVAL1
hbr1213<-0  #illogical: 1 worker hh cannot be CVAL1
hbr1214<-0  #illogical: 1 worker hh cannot be CVAL1
hbr1311<-0  #illogical: 1 worker hh cannot be CVAL1
hbr1312<-0  #illogical: 1 worker hh cannot be CVAL1
hbr1313<-0  #illogical: 1 worker hh cannot be CVAL1
hbr1314<-0  #illogical: 1 worker hh cannot be CVAL1
hbr1411<-0  #illogical: 1 worker hh cannot be CVAL1
hbr1412<-0  #illogical: 1 worker hh cannot be CVAL1
hbr1413<-0  #illogical: 1 worker hh cannot be CVAL1
hbr1414<-0  #illogical: 1 worker hh cannot be CVAL1
hbr2111<-0  #illogical: workers > hh
hbr2112<-0  #illogical: workers > hh
hbr2113<-0  #illogical: workers > hh
hbr2114<-0  #illogical: workers > hh
hbr2211<-apply(mf.cval[,273:276],1,sum)*r6*HBR.gen.calibrationFac
hbr2212<-apply(mf.cval[,277:280],1,sum)*r6*HBR.gen.calibrationFac
hbr2213<-apply(mf.cval[,281:284],1,sum)*r6*HBR.gen.calibrationFac
hbr2214<-apply(mf.cval[,285:288],1,sum)*r6*HBR.gen.calibrationFac
hbr2311<-apply(mf.cval[,289:292],1,sum)*r3*HBR.gen.calibrationFac
hbr2312<-apply(mf.cval[,293:296],1,sum)*r3*HBR.gen.calibrationFac
hbr2313<-apply(mf.cval[,297:300],1,sum)*r3*HBR.gen.calibrationFac
hbr2314<-apply(mf.cval[,301:304],1,sum)*r3*HBR.gen.calibrationFac
hbr2411<-apply(mf.cval[,305:308],1,sum)*r4*HBR.gen.calibrationFac
hbr2412<-apply(mf.cval[,309:312],1,sum)*r4*HBR.gen.calibrationFac
hbr2413<-apply(mf.cval[,313:316],1,sum)*r4*HBR.gen.calibrationFac
hbr2414<-apply(mf.cval[,317:320],1,sum)*r4*HBR.gen.calibrationFac
hbr3111<-0  #illogical: workers > hh
hbr3112<-0  #illogical: workers > hh
hbr3113<-0  #illogical: workers > hh
hbr3114<-0  #illogical: workers > hh
hbr3211<-0  #illogical: workers > hh
hbr3212<-0  #illogical: workers > hh
hbr3213<-0  #illogical: workers > hh
hbr3214<-0  #illogical: workers > hh
hbr3311<-apply(mf.cval[,c(353:356,417:420)],1,sum)*r7*HBR.gen.calibrationFac
hbr3312<-apply(mf.cval[,c(357:360,421:424)],1,sum)*r7*HBR.gen.calibrationFac
hbr3313<-apply(mf.cval[,c(361:364,425:428)],1,sum)*r7*HBR.gen.calibrationFac
hbr3314<-apply(mf.cval[,c(365:368,429:432)],1,sum)*r7*HBR.gen.calibrationFac
hbr3411<-apply(mf.cval[,c(369:372,433:436)],1,sum)*r4*HBR.gen.calibrationFac
hbr3412<-apply(mf.cval[,c(373:376,437:440)],1,sum)*r4*HBR.gen.calibrationFac
hbr3413<-apply(mf.cval[,c(377:380,441:444)],1,sum)*r4*HBR.gen.calibrationFac
hbr3414<-apply(mf.cval[,c(381:384,445:448)],1,sum)*r4*HBR.gen.calibrationFac

## CVAL 2 (cars=workers)

#  workers  HHsize  cval  income
hbr0121<-0  #illogical: 0 worker hh cannot be CVAL2
hbr0122<-0  #illogical: 0 worker hh cannot be CVAL2
hbr0123<-0  #illogical: 0 worker hh cannot be CVAL2
hbr0124<-0  #illogical: 0 worker hh cannot be CVAL2
hbr0221<-0  #illogical: 0 worker hh cannot be CVAL2
hbr0222<-0  #illogical: 0 worker hh cannot be CVAL2
hbr0223<-0  #illogical: 0 worker hh cannot be CVAL2
hbr0224<-0  #illogical: 0 worker hh cannot be CVAL2
hbr0321<-0  #illogical: 0 worker hh cannot be CVAL2
hbr0322<-0  #illogical: 0 worker hh cannot be CVAL2
hbr0323<-0  #illogical: 0 worker hh cannot be CVAL2
hbr0324<-0  #illogical: 0 worker hh cannot be CVAL2
hbr0421<-0  #illogical: 0 worker hh cannot be CVAL2
hbr0422<-0  #illogical: 0 worker hh cannot be CVAL2
hbr0423<-0  #illogical: 0 worker hh cannot be CVAL2
hbr0424<-0  #illogical: 0 worker hh cannot be CVAL2
hbr1121<-apply(mf.cval[,449:452],1,sum)*r5*HBR.gen.calibrationFac
hbr1122<-apply(mf.cval[,453:456],1,sum)*r5*HBR.gen.calibrationFac
hbr1123<-apply(mf.cval[,457:460],1,sum)*r5*HBR.gen.calibrationFac
hbr1124<-apply(mf.cval[,461:464],1,sum)*r5*HBR.gen.calibrationFac
hbr1221<-apply(mf.cval[,465:468],1,sum)*r2*HBR.gen.calibrationFac
hbr1222<-apply(mf.cval[,469:472],1,sum)*r2*HBR.gen.calibrationFac
hbr1223<-apply(mf.cval[,473:476],1,sum)*r2*HBR.gen.calibrationFac
hbr1224<-apply(mf.cval[,477:480],1,sum)*r2*HBR.gen.calibrationFac
hbr1321<-apply(mf.cval[,481:484],1,sum)*r3*HBR.gen.calibrationFac
hbr1322<-apply(mf.cval[,485:488],1,sum)*r3*HBR.gen.calibrationFac
hbr1323<-apply(mf.cval[,489:492],1,sum)*r3*HBR.gen.calibrationFac
hbr1324<-apply(mf.cval[,493:496],1,sum)*r3*HBR.gen.calibrationFac
hbr1421<-apply(mf.cval[,497:500],1,sum)*r4*HBR.gen.calibrationFac
hbr1422<-apply(mf.cval[,501:504],1,sum)*r4*HBR.gen.calibrationFac
hbr1423<-apply(mf.cval[,505:508],1,sum)*r4*HBR.gen.calibrationFac
hbr1424<-apply(mf.cval[,509:512],1,sum)*r4*HBR.gen.calibrationFac
hbr2121<-0  #illogical: workers > hh
hbr2122<-0  #illogical: workers > hh
hbr2123<-0  #illogical: workers > hh
hbr2124<-0  #illogical: workers > hh
hbr2221<-apply(mf.cval[,529:532],1,sum)*r6*HBR.gen.calibrationFac
hbr2222<-apply(mf.cval[,533:536],1,sum)*r6*HBR.gen.calibrationFac
hbr2223<-apply(mf.cval[,537:540],1,sum)*r6*HBR.gen.calibrationFac
hbr2224<-apply(mf.cval[,541:544],1,sum)*r6*HBR.gen.calibrationFac
hbr2321<-apply(mf.cval[,545:548],1,sum)*r3*HBR.gen.calibrationFac
hbr2322<-apply(mf.cval[,549:552],1,sum)*r3*HBR.gen.calibrationFac
hbr2323<-apply(mf.cval[,553:556],1,sum)*r3*HBR.gen.calibrationFac
hbr2324<-apply(mf.cval[,557:560],1,sum)*r3*HBR.gen.calibrationFac
hbr2421<-apply(mf.cval[,561:564],1,sum)*r4*HBR.gen.calibrationFac
hbr2422<-apply(mf.cval[,565:568],1,sum)*r4*HBR.gen.calibrationFac
hbr2423<-apply(mf.cval[,569:572],1,sum)*r4*HBR.gen.calibrationFac
hbr2424<-apply(mf.cval[,573:576],1,sum)*r4*HBR.gen.calibrationFac
hbr3121<-0  #illogical: workers > hh
hbr3122<-0  #illogical: workers > hh
hbr3123<-0  #illogical: workers > hh
hbr3124<-0  #illogical: workers > hh
hbr3221<-0  #illogical: workers > hh
hbr3222<-0  #illogical: workers > hh
hbr3223<-0  #illogical: workers > hh
hbr3224<-0  #illogical: workers > hh
hbr3321<-apply(mf.cval[,609:612],1,sum)*r7*HBR.gen.calibrationFac
hbr3322<-apply(mf.cval[,613:616],1,sum)*r7*HBR.gen.calibrationFac
hbr3323<-apply(mf.cval[,617:620],1,sum)*r7*HBR.gen.calibrationFac
hbr3324<-apply(mf.cval[,621:624],1,sum)*r7*HBR.gen.calibrationFac
hbr3421<-apply(mf.cval[,625:628],1,sum)*r4*HBR.gen.calibrationFac
hbr3422<-apply(mf.cval[,629:632],1,sum)*r4*HBR.gen.calibrationFac
hbr3423<-apply(mf.cval[,633:636],1,sum)*r4*HBR.gen.calibrationFac
hbr3424<-apply(mf.cval[,637:640],1,sum)*r4*HBR.gen.calibrationFac

## CVAL 3 (cars>workers)

#  workers  HHsize  cval  income
hbr0131<-apply(mf.cval[,c(641:644,705:708,833:836)],1,sum)*r1*HBR.gen.calibrationFac
hbr0132<-apply(mf.cval[,c(645:648,709:712,837:840)],1,sum)*r1*HBR.gen.calibrationFac
hbr0133<-apply(mf.cval[,c(649:652,713:716,841:844)],1,sum)*r1*HBR.gen.calibrationFac
hbr0134<-apply(mf.cval[,c(653:656,717:720,845:848)],1,sum)*r1*HBR.gen.calibrationFac
hbr0231<-apply(mf.cval[,c(657:660,721:724,849:852)],1,sum)*r2*HBR.gen.calibrationFac
hbr0232<-apply(mf.cval[,c(661:664,725:728,853:856)],1,sum)*r2*HBR.gen.calibrationFac
hbr0233<-apply(mf.cval[,c(665:668,729:732,857:860)],1,sum)*r2*HBR.gen.calibrationFac
hbr0234<-apply(mf.cval[,c(669:672,733:736,861:864)],1,sum)*r2*HBR.gen.calibrationFac
hbr0331<-apply(mf.cval[,c(673:676,737:740,865:868)],1,sum)*r3*HBR.gen.calibrationFac
hbr0332<-apply(mf.cval[,c(677:680,741:744,869:872)],1,sum)*r3*HBR.gen.calibrationFac
hbr0333<-apply(mf.cval[,c(681:684,745:748,873:876)],1,sum)*r3*HBR.gen.calibrationFac
hbr0334<-apply(mf.cval[,c(685:688,749:752,877:880)],1,sum)*r3*HBR.gen.calibrationFac
hbr0431<-apply(mf.cval[,c(689:692,753:756,881:884)],1,sum)*r4*HBR.gen.calibrationFac
hbr0432<-apply(mf.cval[,c(693:696,757:760,885:888)],1,sum)*r4*HBR.gen.calibrationFac
hbr0433<-apply(mf.cval[,c(697:700,761:764,889:892)],1,sum)*r4*HBR.gen.calibrationFac
hbr0434<-apply(mf.cval[,c(701:704,765:768,893:896)],1,sum)*r4*HBR.gen.calibrationFac
hbr1131<-apply(mf.cval[,c(769:772,897:900)],1,sum)*r5*HBR.gen.calibrationFac
hbr1132<-apply(mf.cval[,c(773:776,901:904)],1,sum)*r5*HBR.gen.calibrationFac
hbr1133<-apply(mf.cval[,c(777:780,905:908)],1,sum)*r5*HBR.gen.calibrationFac
hbr1134<-apply(mf.cval[,c(781:784,909:912)],1,sum)*r5*HBR.gen.calibrationFac
hbr1231<-apply(mf.cval[,c(785:788,913:916)],1,sum)*r2*HBR.gen.calibrationFac
hbr1232<-apply(mf.cval[,c(789:792,917:920)],1,sum)*r2*HBR.gen.calibrationFac
hbr1233<-apply(mf.cval[,c(793:796,921:924)],1,sum)*r2*HBR.gen.calibrationFac
hbr1234<-apply(mf.cval[,c(797:800,925:928)],1,sum)*r2*HBR.gen.calibrationFac
hbr1331<-apply(mf.cval[,c(801:804,929:932)],1,sum)*r3*HBR.gen.calibrationFac
hbr1332<-apply(mf.cval[,c(805:808,933:936)],1,sum)*r3*HBR.gen.calibrationFac
hbr1333<-apply(mf.cval[,c(809:812,937:940)],1,sum)*r3*HBR.gen.calibrationFac
hbr1334<-apply(mf.cval[,c(813:816,941:944)],1,sum)*r3*HBR.gen.calibrationFac
hbr1431<-apply(mf.cval[,c(817:820,945:948)],1,sum)*r4*HBR.gen.calibrationFac
hbr1432<-apply(mf.cval[,c(821:824,949:952)],1,sum)*r4*HBR.gen.calibrationFac
hbr1433<-apply(mf.cval[,c(825:828,953:956)],1,sum)*r4*HBR.gen.calibrationFac
hbr1434<-apply(mf.cval[,c(829:832,957:960)],1,sum)*r4*HBR.gen.calibrationFac
hbr2131<-0  #illogical: workers > hh
hbr2132<-0  #illogical: workers > hh
hbr2133<-0  #illogical: workers > hh
hbr2134<-0  #illogical: workers > hh
hbr2231<-apply(mf.cval[,977:980],1,sum)*r6*HBR.gen.calibrationFac
hbr2232<-apply(mf.cval[,981:984],1,sum)*r6*HBR.gen.calibrationFac
hbr2233<-apply(mf.cval[,985:988],1,sum)*r6*HBR.gen.calibrationFac
hbr2234<-apply(mf.cval[,989:992],1,sum)*r6*HBR.gen.calibrationFac
hbr2331<-apply(mf.cval[,993:996],1,sum)*r3*HBR.gen.calibrationFac
hbr2332<-apply(mf.cval[,997:1000],1,sum)*r3*HBR.gen.calibrationFac
hbr2333<-apply(mf.cval[,1001:1004],1,sum)*r3*HBR.gen.calibrationFac
hbr2334<-apply(mf.cval[,1005:1008],1,sum)*r3*HBR.gen.calibrationFac
hbr2431<-apply(mf.cval[,1009:1012],1,sum)*r4*HBR.gen.calibrationFac
hbr2432<-apply(mf.cval[,1013:1016],1,sum)*r4*HBR.gen.calibrationFac
hbr2433<-apply(mf.cval[,1017:1020],1,sum)*r4*HBR.gen.calibrationFac
hbr2434<-apply(mf.cval[,1021:1024],1,sum)*r4*HBR.gen.calibrationFac
hbr3131<-0  #illogical: workers > hh
hbr3132<-0  #illogical: workers > hh
hbr3133<-0  #illogical: workers > hh
hbr3134<-0  #illogical: workers > hh
hbr3231<-0  #illogical: workers > hh
hbr3232<-0  #illogical: workers > hh
hbr3233<-0  #illogical: workers > hh
hbr3234<-0  #illogical: workers > hh
hbr3331<-0  #more than 3 cars not allowed
hbr3332<-0  #more than 3 cars not allowed
hbr3333<-0  #more than 3 cars not allowed
hbr3334<-0  #more than 3 cars not allowed
hbr3431<-0  #more than 3 cars not allowed
hbr3432<-0  #more than 3 cars not allowed
hbr3433<-0  #more than 3 cars not allowed
hbr3434<-0  #more than 3 cars not allowed 

#########################################

# TOTAL PRODUCTIONS

# Low Income Productions (income bin 1)
ma.hbrprl <- hbr0101+hbr0201+hbr0301+hbr0401+hbr1101+hbr1201+hbr1301+hbr1401+
             hbr2101+hbr2201+hbr2301+hbr2401+hbr3101+hbr3201+hbr3301+hbr3401+
             hbr0111+hbr0211+hbr0311+hbr0411+hbr1111+hbr1211+hbr1311+hbr1411+
             hbr2111+hbr2211+hbr2311+hbr2411+hbr3111+hbr3211+hbr3311+hbr3411+
             hbr0121+hbr0221+hbr0321+hbr0421+hbr1121+hbr1221+hbr1321+hbr1421+
             hbr2121+hbr2221+hbr2321+hbr2421+hbr3121+hbr3221+hbr3321+hbr3421+
             hbr0131+hbr0231+hbr0331+hbr0431+hbr1131+hbr1231+hbr1331+hbr1431+
             hbr2131+hbr2231+hbr2331+hbr2431+hbr3131+hbr3231+hbr3331+hbr3431

# Middle Income Productions (income bins 2 & 3)
ma.hbrprm <- hbr0102+hbr0202+hbr0302+hbr0402+hbr1102+hbr1202+hbr1302+hbr1402+
             hbr2102+hbr2202+hbr2302+hbr2402+hbr3102+hbr3202+hbr3302+hbr3402+
             hbr0112+hbr0212+hbr0312+hbr0412+hbr1112+hbr1212+hbr1312+hbr1412+
             hbr2112+hbr2212+hbr2312+hbr2412+hbr3112+hbr3212+hbr3312+hbr3412+
             hbr0122+hbr0222+hbr0322+hbr0422+hbr1122+hbr1222+hbr1322+hbr1422+
             hbr2122+hbr2222+hbr2322+hbr2422+hbr3122+hbr3222+hbr3322+hbr3422+
             hbr0132+hbr0232+hbr0332+hbr0432+hbr1132+hbr1232+hbr1332+hbr1432+
             hbr2132+hbr2232+hbr2332+hbr2432+hbr3132+hbr3232+hbr3332+hbr3432+
             hbr0103+hbr0203+hbr0303+hbr0403+hbr1103+hbr1203+hbr1303+hbr1403+
             hbr2103+hbr2203+hbr2303+hbr2403+hbr3103+hbr3203+hbr3303+hbr3403+
             hbr0113+hbr0213+hbr0313+hbr0413+hbr1113+hbr1213+hbr1313+hbr1413+
             hbr2113+hbr2213+hbr2313+hbr2413+hbr3113+hbr3213+hbr3313+hbr3413+
             hbr0123+hbr0223+hbr0323+hbr0423+hbr1123+hbr1223+hbr1323+hbr1423+
             hbr2123+hbr2223+hbr2323+hbr2423+hbr3123+hbr3223+hbr3323+hbr3423+
             hbr0133+hbr0233+hbr0333+hbr0433+hbr1133+hbr1233+hbr1333+hbr1433+
             hbr2133+hbr2233+hbr2333+hbr2433+hbr3133+hbr3233+hbr3333+hbr3433

# High Income Productions (income bin 4)
ma.hbrprh <- hbr0104+hbr0204+hbr0304+hbr0404+hbr1104+hbr1204+hbr1304+hbr1404+
             hbr2104+hbr2204+hbr2304+hbr2404+hbr3104+hbr3204+hbr3304+hbr3404+
             hbr0114+hbr0214+hbr0314+hbr0414+hbr1114+hbr1214+hbr1314+hbr1414+
             hbr2114+hbr2214+hbr2314+hbr2414+hbr3114+hbr3214+hbr3314+hbr3414+
             hbr0124+hbr0224+hbr0324+hbr0424+hbr1124+hbr1224+hbr1324+hbr1424+
             hbr2124+hbr2224+hbr2324+hbr2424+hbr3124+hbr3224+hbr3324+hbr3424+
             hbr0134+hbr0234+hbr0334+hbr0434+hbr1134+hbr1234+hbr1334+hbr1434+
             hbr2134+hbr2234+hbr2334+hbr2434+hbr3134+hbr3234+hbr3334+hbr3434

# Total Productions (All Incomes)
ma.hbrpr <- ma.hbrprl + ma.hbrprm + ma.hbrprh

#############################################

# Calculate Percentage Productions by worker, hh size, cval, and income

hbrLowInc.m<-ma.hbrprl
hbrLowInc.m[hbrLowInc.m==0]<-1
hbrMedInc.m<-ma.hbrprm
hbrMedInc.m[hbrMedInc.m==0]<-1
hbrHiInc.m<-ma.hbrprh
hbrHiInc.m[hbrHiInc.m==0]<-1

# A=1 HH      #=CVAL    l=low income
# B=2 HH                m=mid income
# C=3,4+ HH             h=high income

malist.hbr<-list(
md.hbrA0l=(hbr0101+hbr1101+hbr2101+hbr3101)/hbrLowInc.m,
md.hbrB0l=(hbr0201+hbr1201+hbr2201+hbr3201)/hbrLowInc.m,
md.hbrA0m=(hbr0102+hbr1102+hbr2102+hbr3102+
           hbr0103+hbr1103+hbr2103+hbr3103)/hbrMedInc.m,
md.hbrB0m=(hbr0202+hbr1202+hbr2202+hbr3202+
           hbr0203+hbr1203+hbr2203+hbr3203)/hbrMedInc.m,
md.hbrA0h=(hbr0104+hbr1104+hbr2104+hbr3104)/hbrHiInc.m,
md.hbrB0h=(hbr0204+hbr1204+hbr2204+hbr3204)/hbrHiInc.m,
md.hbrA1l=(hbr0111+hbr1111+hbr2111+hbr3111)/hbrLowInc.m,
md.hbrB1l=(hbr0211+hbr1211+hbr2211+hbr3211)/hbrLowInc.m,
md.hbrA1m=(hbr0112+hbr1112+hbr2112+hbr3112+
           hbr0113+hbr1113+hbr2113+hbr3113)/hbrMedInc.m,
md.hbrB1m=(hbr0212+hbr1212+hbr2212+hbr3212+
           hbr0213+hbr1213+hbr2213+hbr3213)/hbrMedInc.m,
md.hbrA1h=(hbr0114+hbr1114+hbr2114+hbr3114)/hbrHiInc.m,
md.hbrB1h=(hbr0214+hbr1214+hbr2214+hbr3214)/hbrHiInc.m,
md.hbrA2l=(hbr0121+hbr1121+hbr2121+hbr3121)/hbrLowInc.m,
md.hbrB2l=(hbr0221+hbr1221+hbr2221+hbr3221)/hbrLowInc.m,
md.hbrA2m=(hbr0122+hbr1122+hbr2122+hbr3122+
           hbr0123+hbr1123+hbr2123+hbr3123)/hbrMedInc.m,
md.hbrB2m=(hbr0222+hbr1222+hbr2222+hbr3222+
           hbr0223+hbr1223+hbr2223+hbr3223)/hbrMedInc.m,
md.hbrA2h=(hbr0124+hbr1124+hbr2124+hbr3124)/hbrHiInc.m,
md.hbrB2h=(hbr0224+hbr1224+hbr2224+hbr3224)/hbrHiInc.m,
md.hbrA3l=(hbr0131+hbr1131+hbr2131+hbr3131)/hbrLowInc.m,
md.hbrB3l=(hbr0231+hbr1231+hbr2231+hbr3231)/hbrLowInc.m,
md.hbrA3m=(hbr0132+hbr1132+hbr2132+hbr3132+
           hbr0133+hbr1133+hbr2133+hbr3133)/hbrMedInc.m,
md.hbrB3m=(hbr0232+hbr1232+hbr2232+hbr3232+
           hbr0233+hbr1233+hbr2233+hbr3233)/hbrMedInc.m,
md.hbrA3h=(hbr0134+hbr1134+hbr2134+hbr3134)/hbrHiInc.m,
md.hbrB3h=(hbr0234+hbr1234+hbr2234+hbr3234)/hbrHiInc.m,
md.hbrC0l=(hbr0301+hbr0401+hbr1301+hbr1401+hbr2301+hbr2401+hbr3301+hbr3401)/hbrLowInc.m,
md.hbrC0m=(hbr0302+hbr0402+hbr1302+hbr1402+hbr2302+hbr2402+hbr3302+hbr3402+
           hbr0303+hbr0403+hbr1303+hbr1403+hbr2303+hbr2403+hbr3303+hbr3403)/hbrMedInc.m,
md.hbrC0h=(hbr0304+hbr0404+hbr1304+hbr1404+hbr2304+hbr2404+hbr3304+hbr3404)/hbrHiInc.m,
md.hbrC1l=(hbr0311+hbr0411+hbr1311+hbr1411+hbr2311+hbr2411+hbr3311+hbr3411)/hbrLowInc.m,
md.hbrC1m=(hbr0312+hbr0412+hbr1312+hbr1412+hbr2312+hbr2412+hbr3312+hbr3412+
           hbr0313+hbr0413+hbr1313+hbr1413+hbr2313+hbr2413+hbr3313+hbr3413)/hbrMedInc.m,
md.hbrC1h=(hbr0314+hbr0414+hbr1314+hbr1414+hbr2314+hbr2414+hbr3314+hbr3414)/hbrHiInc.m,
md.hbrC2l=(hbr0321+hbr0421+hbr1321+hbr1421+hbr2321+hbr2421+hbr3321+hbr3421)/hbrLowInc.m,
md.hbrC2m=(hbr0322+hbr0422+hbr1322+hbr1422+hbr2322+hbr2422+hbr3322+hbr3422+
           hbr0323+hbr0423+hbr1323+hbr1423+hbr2323+hbr2423+hbr3323+hbr3423)/hbrMedInc.m,
md.hbrC2h=(hbr0324+hbr0424+hbr1324+hbr1424+hbr2324+hbr2424+hbr3324+hbr3424)/hbrHiInc.m,
md.hbrC3l=(hbr0331+hbr0431+hbr1331+hbr1431+hbr2331+hbr2431+hbr3331+hbr3431)/hbrLowInc.m,
md.hbrC3m=(hbr0332+hbr0432+hbr1332+hbr1432+hbr2332+hbr2432+hbr3332+hbr3432+
           hbr0333+hbr0433+hbr1333+hbr1433+hbr2333+hbr2433+hbr3333+hbr3433)/hbrMedInc.m,
md.hbrC3h=(hbr0334+hbr0434+hbr1334+hbr1434+hbr2334+hbr2434+hbr3334+hbr3434)/hbrHiInc.m,
ma.hbrpr=ma.hbrpr, ma.hbrprl=ma.hbrprl, ma.hbrprm=ma.hbrprm, ma.hbrprh=ma.hbrprh)

save(malist.hbr,file="malist.hbr.dat")

rm(hbrLowInc.m,hbrMedInc.m,hbrHiInc.m,
   hbr0101,hbr0102,hbr0103,hbr0104,hbr0201,hbr0202,hbr0203,hbr0204,hbr0301,hbr0302,hbr0303,hbr0304,hbr0401,hbr0402,hbr0403,hbr0404,
   hbr1101,hbr1102,hbr1103,hbr1104,hbr1201,hbr1202,hbr1203,hbr1204,hbr1301,hbr1302,hbr1303,hbr1304,hbr1401,hbr1402,hbr1403,hbr1404,
   hbr2101,hbr2102,hbr2103,hbr2104,hbr2201,hbr2202,hbr2203,hbr2204,hbr2301,hbr2302,hbr2303,hbr2304,hbr2401,hbr2402,hbr2403,hbr2404,
   hbr3101,hbr3102,hbr3103,hbr3104,hbr3201,hbr3202,hbr3203,hbr3204,hbr3301,hbr3302,hbr3303,hbr3304,hbr3401,hbr3402,hbr3403,hbr3404,
   hbr0111,hbr0112,hbr0113,hbr0114,hbr0211,hbr0212,hbr0213,hbr0214,hbr0311,hbr0312,hbr0313,hbr0314,hbr0411,hbr0412,hbr0413,hbr0414,
   hbr1111,hbr1112,hbr1113,hbr1114,hbr1211,hbr1212,hbr1213,hbr1214,hbr1311,hbr1312,hbr1313,hbr1314,hbr1411,hbr1412,hbr1413,hbr1414,
   hbr2111,hbr2112,hbr2113,hbr2114,hbr2211,hbr2212,hbr2213,hbr2214,hbr2311,hbr2312,hbr2313,hbr2314,hbr2411,hbr2412,hbr2413,hbr2414,
   hbr3111,hbr3112,hbr3113,hbr3114,hbr3211,hbr3212,hbr3213,hbr3214,hbr3311,hbr3312,hbr3313,hbr3314,hbr3411,hbr3412,hbr3413,hbr3414,
   hbr0121,hbr0122,hbr0123,hbr0124,hbr0221,hbr0222,hbr0223,hbr0224,hbr0321,hbr0322,hbr0323,hbr0324,hbr0421,hbr0422,hbr0423,hbr0424,
   hbr1121,hbr1122,hbr1123,hbr1124,hbr1221,hbr1222,hbr1223,hbr1224,hbr1321,hbr1322,hbr1323,hbr1324,hbr1421,hbr1422,hbr1423,hbr1424,
   hbr2121,hbr2122,hbr2123,hbr2124,hbr2221,hbr2222,hbr2223,hbr2224,hbr2321,hbr2322,hbr2323,hbr2324,hbr2421,hbr2422,hbr2423,hbr2424,
   hbr3121,hbr3122,hbr3123,hbr3124,hbr3221,hbr3222,hbr3223,hbr3224,hbr3321,hbr3322,hbr3323,hbr3324,hbr3421,hbr3422,hbr3423,hbr3424,
   hbr0131,hbr0132,hbr0133,hbr0134,hbr0231,hbr0232,hbr0233,hbr0234,hbr0331,hbr0332,hbr0333,hbr0334,hbr0431,hbr0432,hbr0433,hbr0434,
   hbr1131,hbr1132,hbr1133,hbr1134,hbr1231,hbr1232,hbr1233,hbr1234,hbr1331,hbr1332,hbr1333,hbr1334,hbr1431,hbr1432,hbr1433,hbr1434,
   hbr2131,hbr2132,hbr2133,hbr2134,hbr2231,hbr2232,hbr2233,hbr2234,hbr2331,hbr2332,hbr2333,hbr2334,hbr2431,hbr2432,hbr2433,hbr2434,
   hbr3131,hbr3132,hbr3133,hbr3134,hbr3231,hbr3232,hbr3233,hbr3234,hbr3331,hbr3332,hbr3333,hbr3334,hbr3431,hbr3432,hbr3433,hbr3434)

