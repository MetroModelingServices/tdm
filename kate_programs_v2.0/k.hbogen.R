#k.hbogen.R

# HBO Trip Production Rates
r1 <- 1.187586   #  Worker<Size, 1 PerHH
r2 <- 2.076545   #  Worker<Size, 2 PerHH
r3 <- 2.613932   #  Worker<Size, 3 PerHH
r4 <- 4.027823   #  Worker<Size, 4+ PerHH
r5 <- 0.6723447  #  Worker=Size, 1 PerHH
r6 <- 1.421209   #  Worker=Size, 2 PerHH
r7 <- 1.916667   #  Worker=Size, 3 PerHH

## CVAL 0 (cars=0)

#  workers  HHsize  cval  income
hbo0101<-apply(mf.cval[,1:4],1,sum)*r1*HBO.gen.calibrationFac
hbo0102<-apply(mf.cval[,5:8],1,sum)*r1*HBO.gen.calibrationFac
hbo0103<-apply(mf.cval[,9:12],1,sum)*r1*HBO.gen.calibrationFac
hbo0104<-apply(mf.cval[,13:16],1,sum)*r1*HBO.gen.calibrationFac
hbo0201<-apply(mf.cval[,17:20],1,sum)*r2*HBO.gen.calibrationFac
hbo0202<-apply(mf.cval[,21:24],1,sum)*r2*HBO.gen.calibrationFac
hbo0203<-apply(mf.cval[,25:28],1,sum)*r2*HBO.gen.calibrationFac
hbo0204<-apply(mf.cval[,29:32],1,sum)*r2*HBO.gen.calibrationFac
hbo0301<-apply(mf.cval[,33:36],1,sum)*r3*HBO.gen.calibrationFac
hbo0302<-apply(mf.cval[,37:40],1,sum)*r3*HBO.gen.calibrationFac
hbo0303<-apply(mf.cval[,41:44],1,sum)*r3*HBO.gen.calibrationFac
hbo0304<-apply(mf.cval[,45:48],1,sum)*r3*HBO.gen.calibrationFac
hbo0401<-apply(mf.cval[,49:52],1,sum)*r4*HBO.gen.calibrationFac
hbo0402<-apply(mf.cval[,53:56],1,sum)*r4*HBO.gen.calibrationFac
hbo0403<-apply(mf.cval[,57:60],1,sum)*r4*HBO.gen.calibrationFac
hbo0404<-apply(mf.cval[,61:64],1,sum)*r4*HBO.gen.calibrationFac
hbo1101<-apply(mf.cval[,65:68],1,sum)*r5*HBO.gen.calibrationFac
hbo1102<-apply(mf.cval[,69:72],1,sum)*r5*HBO.gen.calibrationFac
hbo1103<-apply(mf.cval[,73:76],1,sum)*r5*HBO.gen.calibrationFac
hbo1104<-apply(mf.cval[,77:80],1,sum)*r5*HBO.gen.calibrationFac
hbo1201<-apply(mf.cval[,81:84],1,sum)*r2*HBO.gen.calibrationFac
hbo1202<-apply(mf.cval[,85:88],1,sum)*r2*HBO.gen.calibrationFac
hbo1203<-apply(mf.cval[,89:92],1,sum)*r2*HBO.gen.calibrationFac
hbo1204<-apply(mf.cval[,93:96],1,sum)*r2*HBO.gen.calibrationFac
hbo1301<-apply(mf.cval[,97:100],1,sum)*r3*HBO.gen.calibrationFac
hbo1302<-apply(mf.cval[,101:104],1,sum)*r3*HBO.gen.calibrationFac
hbo1303<-apply(mf.cval[,105:108],1,sum)*r3*HBO.gen.calibrationFac
hbo1304<-apply(mf.cval[,109:112],1,sum)*r3*HBO.gen.calibrationFac
hbo1401<-apply(mf.cval[,113:116],1,sum)*r4*HBO.gen.calibrationFac
hbo1402<-apply(mf.cval[,117:120],1,sum)*r4*HBO.gen.calibrationFac
hbo1403<-apply(mf.cval[,121:124],1,sum)*r4*HBO.gen.calibrationFac
hbo1404<-apply(mf.cval[,125:128],1,sum)*r4*HBO.gen.calibrationFac
hbo2101<-0  #illogical: workers > hh
hbo2102<-0  #illogical: workers > hh
hbo2103<-0  #illogical: workers > hh
hbo2104<-0  #illogical: workers > hh
hbo2201<-apply(mf.cval[,145:148],1,sum)*r6*HBO.gen.calibrationFac
hbo2202<-apply(mf.cval[,149:152],1,sum)*r6*HBO.gen.calibrationFac
hbo2203<-apply(mf.cval[,153:156],1,sum)*r6*HBO.gen.calibrationFac
hbo2204<-apply(mf.cval[,157:160],1,sum)*r6*HBO.gen.calibrationFac
hbo2301<-apply(mf.cval[,161:164],1,sum)*r3*HBO.gen.calibrationFac
hbo2302<-apply(mf.cval[,165:168],1,sum)*r3*HBO.gen.calibrationFac
hbo2303<-apply(mf.cval[,169:172],1,sum)*r3*HBO.gen.calibrationFac
hbo2304<-apply(mf.cval[,173:176],1,sum)*r3*HBO.gen.calibrationFac
hbo2401<-apply(mf.cval[,177:180],1,sum)*r4*HBO.gen.calibrationFac
hbo2402<-apply(mf.cval[,181:184],1,sum)*r4*HBO.gen.calibrationFac
hbo2403<-apply(mf.cval[,185:188],1,sum)*r4*HBO.gen.calibrationFac
hbo2404<-apply(mf.cval[,189:192],1,sum)*r4*HBO.gen.calibrationFac
hbo3101<-0  #illogical: workers > hh
hbo3102<-0  #illogical: workers > hh
hbo3103<-0  #illogical: workers > hh
hbo3104<-0  #illogical: workers > hh
hbo3201<-0  #illogical: workers > hh
hbo3202<-0  #illogical: workers > hh
hbo3203<-0  #illogical: workers > hh
hbo3204<-0  #illogical: workers > hh
hbo3301<-apply(mf.cval[,225:228],1,sum)*r7*HBO.gen.calibrationFac
hbo3302<-apply(mf.cval[,229:232],1,sum)*r7*HBO.gen.calibrationFac
hbo3303<-apply(mf.cval[,233:236],1,sum)*r7*HBO.gen.calibrationFac
hbo3304<-apply(mf.cval[,237:240],1,sum)*r7*HBO.gen.calibrationFac
hbo3401<-apply(mf.cval[,241:244],1,sum)*r4*HBO.gen.calibrationFac
hbo3402<-apply(mf.cval[,245:248],1,sum)*r4*HBO.gen.calibrationFac
hbo3403<-apply(mf.cval[,249:252],1,sum)*r4*HBO.gen.calibrationFac
hbo3404<-apply(mf.cval[,253:256],1,sum)*r4*HBO.gen.calibrationFac

## CVAL 1 (cars<workers)

#  workers  HHsize  cval  income
hbo0111<-0  #illogical: 0 worker hh cannot be CVAL1 
hbo0112<-0  #illogical: 0 worker hh cannot be CVAL1 
hbo0113<-0  #illogical: 0 worker hh cannot be CVAL1 
hbo0114<-0  #illogical: 0 worker hh cannot be CVAL1 
hbo0211<-0  #illogical: 0 worker hh cannot be CVAL1
hbo0212<-0  #illogical: 0 worker hh cannot be CVAL1
hbo0213<-0  #illogical: 0 worker hh cannot be CVAL1 
hbo0214<-0  #illogical: 0 worker hh cannot be CVAL1 
hbo0311<-0  #illogical: 0 worker hh cannot be CVAL1 
hbo0312<-0  #illogical: 0 worker hh cannot be CVAL1 
hbo0313<-0  #illogical: 0 worker hh cannot be CVAL1 
hbo0314<-0  #illogical: 0 worker hh cannot be CVAL1 
hbo0411<-0  #illogical: 0 worker hh cannot be CVAL1 
hbo0412<-0  #illogical: 0 worker hh cannot be CVAL1 
hbo0413<-0  #illogical: 0 worker hh cannot be CVAL1 
hbo0414<-0  #illogical: 0 worker hh cannot be CVAL1
hbo1111<-0  #illogical: 1 worker hh cannot be CVAL1
hbo1112<-0  #illogical: 1 worker hh cannot be CVAL1
hbo1113<-0  #illogical: 1 worker hh cannot be CVAL1
hbo1114<-0  #illogical: 1 worker hh cannot be CVAL1
hbo1211<-0  #illogical: 1 worker hh cannot be CVAL1
hbo1212<-0  #illogical: 1 worker hh cannot be CVAL1
hbo1213<-0  #illogical: 1 worker hh cannot be CVAL1
hbo1214<-0  #illogical: 1 worker hh cannot be CVAL1
hbo1311<-0  #illogical: 1 worker hh cannot be CVAL1
hbo1312<-0  #illogical: 1 worker hh cannot be CVAL1
hbo1313<-0  #illogical: 1 worker hh cannot be CVAL1
hbo1314<-0  #illogical: 1 worker hh cannot be CVAL1
hbo1411<-0  #illogical: 1 worker hh cannot be CVAL1
hbo1412<-0  #illogical: 1 worker hh cannot be CVAL1
hbo1413<-0  #illogical: 1 worker hh cannot be CVAL1
hbo1414<-0  #illogical: 1 worker hh cannot be CVAL1
hbo2111<-0  #illogical: workers > hh
hbo2112<-0  #illogical: workers > hh
hbo2113<-0  #illogical: workers > hh
hbo2114<-0  #illogical: workers > hh
hbo2211<-apply(mf.cval[,273:276],1,sum)*r6*HBO.gen.calibrationFac
hbo2212<-apply(mf.cval[,277:280],1,sum)*r6*HBO.gen.calibrationFac
hbo2213<-apply(mf.cval[,281:284],1,sum)*r6*HBO.gen.calibrationFac
hbo2214<-apply(mf.cval[,285:288],1,sum)*r6*HBO.gen.calibrationFac
hbo2311<-apply(mf.cval[,289:292],1,sum)*r3*HBO.gen.calibrationFac
hbo2312<-apply(mf.cval[,293:296],1,sum)*r3*HBO.gen.calibrationFac
hbo2313<-apply(mf.cval[,297:300],1,sum)*r3*HBO.gen.calibrationFac
hbo2314<-apply(mf.cval[,301:304],1,sum)*r3*HBO.gen.calibrationFac
hbo2411<-apply(mf.cval[,305:308],1,sum)*r4*HBO.gen.calibrationFac
hbo2412<-apply(mf.cval[,309:312],1,sum)*r4*HBO.gen.calibrationFac
hbo2413<-apply(mf.cval[,313:316],1,sum)*r4*HBO.gen.calibrationFac
hbo2414<-apply(mf.cval[,317:320],1,sum)*r4*HBO.gen.calibrationFac
hbo3111<-0  #illogical: workers > hh
hbo3112<-0  #illogical: workers > hh
hbo3113<-0  #illogical: workers > hh
hbo3114<-0  #illogical: workers > hh
hbo3211<-0  #illogical: workers > hh
hbo3212<-0  #illogical: workers > hh
hbo3213<-0  #illogical: workers > hh
hbo3214<-0  #illogical: workers > hh
hbo3311<-apply(mf.cval[,c(353:356,417:420)],1,sum)*r7*HBO.gen.calibrationFac
hbo3312<-apply(mf.cval[,c(357:360,421:424)],1,sum)*r7*HBO.gen.calibrationFac
hbo3313<-apply(mf.cval[,c(361:364,425:428)],1,sum)*r7*HBO.gen.calibrationFac
hbo3314<-apply(mf.cval[,c(365:368,429:432)],1,sum)*r7*HBO.gen.calibrationFac
hbo3411<-apply(mf.cval[,c(369:372,433:436)],1,sum)*r4*HBO.gen.calibrationFac
hbo3412<-apply(mf.cval[,c(373:376,437:440)],1,sum)*r4*HBO.gen.calibrationFac
hbo3413<-apply(mf.cval[,c(377:380,441:444)],1,sum)*r4*HBO.gen.calibrationFac
hbo3414<-apply(mf.cval[,c(381:384,445:448)],1,sum)*r4*HBO.gen.calibrationFac

## CVAL 2 (cars=workers)

#  workers  HHsize  cval  income
hbo0121<-0  #illogical: 0 worker hh cannot be CVAL2
hbo0122<-0  #illogical: 0 worker hh cannot be CVAL2
hbo0123<-0  #illogical: 0 worker hh cannot be CVAL2
hbo0124<-0  #illogical: 0 worker hh cannot be CVAL2
hbo0221<-0  #illogical: 0 worker hh cannot be CVAL2
hbo0222<-0  #illogical: 0 worker hh cannot be CVAL2
hbo0223<-0  #illogical: 0 worker hh cannot be CVAL2
hbo0224<-0  #illogical: 0 worker hh cannot be CVAL2
hbo0321<-0  #illogical: 0 worker hh cannot be CVAL2
hbo0322<-0  #illogical: 0 worker hh cannot be CVAL2
hbo0323<-0  #illogical: 0 worker hh cannot be CVAL2
hbo0324<-0  #illogical: 0 worker hh cannot be CVAL2
hbo0421<-0  #illogical: 0 worker hh cannot be CVAL2
hbo0422<-0  #illogical: 0 worker hh cannot be CVAL2
hbo0423<-0  #illogical: 0 worker hh cannot be CVAL2
hbo0424<-0  #illogical: 0 worker hh cannot be CVAL2
hbo1121<-apply(mf.cval[,449:452],1,sum)*r5*HBO.gen.calibrationFac
hbo1122<-apply(mf.cval[,453:456],1,sum)*r5*HBO.gen.calibrationFac
hbo1123<-apply(mf.cval[,457:460],1,sum)*r5*HBO.gen.calibrationFac
hbo1124<-apply(mf.cval[,461:464],1,sum)*r5*HBO.gen.calibrationFac
hbo1221<-apply(mf.cval[,465:468],1,sum)*r2*HBO.gen.calibrationFac
hbo1222<-apply(mf.cval[,469:472],1,sum)*r2*HBO.gen.calibrationFac
hbo1223<-apply(mf.cval[,473:476],1,sum)*r2*HBO.gen.calibrationFac
hbo1224<-apply(mf.cval[,477:480],1,sum)*r2*HBO.gen.calibrationFac
hbo1321<-apply(mf.cval[,481:484],1,sum)*r3*HBO.gen.calibrationFac
hbo1322<-apply(mf.cval[,485:488],1,sum)*r3*HBO.gen.calibrationFac
hbo1323<-apply(mf.cval[,489:492],1,sum)*r3*HBO.gen.calibrationFac
hbo1324<-apply(mf.cval[,493:496],1,sum)*r3*HBO.gen.calibrationFac
hbo1421<-apply(mf.cval[,497:500],1,sum)*r4*HBO.gen.calibrationFac
hbo1422<-apply(mf.cval[,501:504],1,sum)*r4*HBO.gen.calibrationFac
hbo1423<-apply(mf.cval[,505:508],1,sum)*r4*HBO.gen.calibrationFac
hbo1424<-apply(mf.cval[,509:512],1,sum)*r4*HBO.gen.calibrationFac
hbo2121<-0  #illogical: workers > hh
hbo2122<-0  #illogical: workers > hh
hbo2123<-0  #illogical: workers > hh
hbo2124<-0  #illogical: workers > hh
hbo2221<-apply(mf.cval[,529:532],1,sum)*r6*HBO.gen.calibrationFac
hbo2222<-apply(mf.cval[,533:536],1,sum)*r6*HBO.gen.calibrationFac
hbo2223<-apply(mf.cval[,537:540],1,sum)*r6*HBO.gen.calibrationFac
hbo2224<-apply(mf.cval[,541:544],1,sum)*r6*HBO.gen.calibrationFac
hbo2321<-apply(mf.cval[,545:548],1,sum)*r3*HBO.gen.calibrationFac
hbo2322<-apply(mf.cval[,549:552],1,sum)*r3*HBO.gen.calibrationFac
hbo2323<-apply(mf.cval[,553:556],1,sum)*r3*HBO.gen.calibrationFac
hbo2324<-apply(mf.cval[,557:560],1,sum)*r3*HBO.gen.calibrationFac
hbo2421<-apply(mf.cval[,561:564],1,sum)*r4*HBO.gen.calibrationFac
hbo2422<-apply(mf.cval[,565:568],1,sum)*r4*HBO.gen.calibrationFac
hbo2423<-apply(mf.cval[,569:572],1,sum)*r4*HBO.gen.calibrationFac
hbo2424<-apply(mf.cval[,573:576],1,sum)*r4*HBO.gen.calibrationFac
hbo3121<-0  #illogical: workers > hh
hbo3122<-0  #illogical: workers > hh
hbo3123<-0  #illogical: workers > hh
hbo3124<-0  #illogical: workers > hh
hbo3221<-0  #illogical: workers > hh
hbo3222<-0  #illogical: workers > hh
hbo3223<-0  #illogical: workers > hh
hbo3224<-0  #illogical: workers > hh
hbo3321<-apply(mf.cval[,609:612],1,sum)*r7*HBO.gen.calibrationFac
hbo3322<-apply(mf.cval[,613:616],1,sum)*r7*HBO.gen.calibrationFac
hbo3323<-apply(mf.cval[,617:620],1,sum)*r7*HBO.gen.calibrationFac
hbo3324<-apply(mf.cval[,621:624],1,sum)*r7*HBO.gen.calibrationFac
hbo3421<-apply(mf.cval[,625:628],1,sum)*r4*HBO.gen.calibrationFac
hbo3422<-apply(mf.cval[,629:632],1,sum)*r4*HBO.gen.calibrationFac
hbo3423<-apply(mf.cval[,633:636],1,sum)*r4*HBO.gen.calibrationFac
hbo3424<-apply(mf.cval[,637:640],1,sum)*r4*HBO.gen.calibrationFac

## CVAL 3 (cars>workers)

#  workers  HHsize  cval  income
hbo0131<-apply(mf.cval[,c(641:644,705:708,833:836)],1,sum)*r1*HBO.gen.calibrationFac
hbo0132<-apply(mf.cval[,c(645:648,709:712,837:840)],1,sum)*r1*HBO.gen.calibrationFac
hbo0133<-apply(mf.cval[,c(649:652,713:716,841:844)],1,sum)*r1*HBO.gen.calibrationFac
hbo0134<-apply(mf.cval[,c(653:656,717:720,845:848)],1,sum)*r1*HBO.gen.calibrationFac
hbo0231<-apply(mf.cval[,c(657:660,721:724,849:852)],1,sum)*r2*HBO.gen.calibrationFac
hbo0232<-apply(mf.cval[,c(661:664,725:728,853:856)],1,sum)*r2*HBO.gen.calibrationFac
hbo0233<-apply(mf.cval[,c(665:668,729:732,857:860)],1,sum)*r2*HBO.gen.calibrationFac
hbo0234<-apply(mf.cval[,c(669:672,733:736,861:864)],1,sum)*r2*HBO.gen.calibrationFac
hbo0331<-apply(mf.cval[,c(673:676,737:740,865:868)],1,sum)*r3*HBO.gen.calibrationFac
hbo0332<-apply(mf.cval[,c(677:680,741:744,869:872)],1,sum)*r3*HBO.gen.calibrationFac
hbo0333<-apply(mf.cval[,c(681:684,745:748,873:876)],1,sum)*r3*HBO.gen.calibrationFac
hbo0334<-apply(mf.cval[,c(685:688,749:752,877:880)],1,sum)*r3*HBO.gen.calibrationFac
hbo0431<-apply(mf.cval[,c(689:692,753:756,881:884)],1,sum)*r4*HBO.gen.calibrationFac
hbo0432<-apply(mf.cval[,c(693:696,757:760,885:888)],1,sum)*r4*HBO.gen.calibrationFac
hbo0433<-apply(mf.cval[,c(697:700,761:764,889:892)],1,sum)*r4*HBO.gen.calibrationFac
hbo0434<-apply(mf.cval[,c(701:704,765:768,893:896)],1,sum)*r4*HBO.gen.calibrationFac
hbo1131<-apply(mf.cval[,c(769:772,897:900)],1,sum)*r5*HBO.gen.calibrationFac
hbo1132<-apply(mf.cval[,c(773:776,901:904)],1,sum)*r5*HBO.gen.calibrationFac
hbo1133<-apply(mf.cval[,c(777:780,905:908)],1,sum)*r5*HBO.gen.calibrationFac
hbo1134<-apply(mf.cval[,c(781:784,909:912)],1,sum)*r5*HBO.gen.calibrationFac
hbo1231<-apply(mf.cval[,c(785:788,913:916)],1,sum)*r2*HBO.gen.calibrationFac
hbo1232<-apply(mf.cval[,c(789:792,917:920)],1,sum)*r2*HBO.gen.calibrationFac
hbo1233<-apply(mf.cval[,c(793:796,921:924)],1,sum)*r2*HBO.gen.calibrationFac
hbo1234<-apply(mf.cval[,c(797:800,925:928)],1,sum)*r2*HBO.gen.calibrationFac
hbo1331<-apply(mf.cval[,c(801:804,929:932)],1,sum)*r3*HBO.gen.calibrationFac
hbo1332<-apply(mf.cval[,c(805:808,933:936)],1,sum)*r3*HBO.gen.calibrationFac
hbo1333<-apply(mf.cval[,c(809:812,937:940)],1,sum)*r3*HBO.gen.calibrationFac
hbo1334<-apply(mf.cval[,c(813:816,941:944)],1,sum)*r3*HBO.gen.calibrationFac
hbo1431<-apply(mf.cval[,c(817:820,945:948)],1,sum)*r4*HBO.gen.calibrationFac
hbo1432<-apply(mf.cval[,c(821:824,949:952)],1,sum)*r4*HBO.gen.calibrationFac
hbo1433<-apply(mf.cval[,c(825:828,953:956)],1,sum)*r4*HBO.gen.calibrationFac
hbo1434<-apply(mf.cval[,c(829:832,957:960)],1,sum)*r4*HBO.gen.calibrationFac
hbo2131<-0  #illogical: workers > hh
hbo2132<-0  #illogical: workers > hh
hbo2133<-0  #illogical: workers > hh
hbo2134<-0  #illogical: workers > hh
hbo2231<-apply(mf.cval[,977:980],1,sum)*r6*HBO.gen.calibrationFac
hbo2232<-apply(mf.cval[,981:984],1,sum)*r6*HBO.gen.calibrationFac
hbo2233<-apply(mf.cval[,985:988],1,sum)*r6*HBO.gen.calibrationFac
hbo2234<-apply(mf.cval[,989:992],1,sum)*r6*HBO.gen.calibrationFac
hbo2331<-apply(mf.cval[,993:996],1,sum)*r3*HBO.gen.calibrationFac
hbo2332<-apply(mf.cval[,997:1000],1,sum)*r3*HBO.gen.calibrationFac
hbo2333<-apply(mf.cval[,1001:1004],1,sum)*r3*HBO.gen.calibrationFac
hbo2334<-apply(mf.cval[,1005:1008],1,sum)*r3*HBO.gen.calibrationFac
hbo2431<-apply(mf.cval[,1009:1012],1,sum)*r4*HBO.gen.calibrationFac
hbo2432<-apply(mf.cval[,1013:1016],1,sum)*r4*HBO.gen.calibrationFac
hbo2433<-apply(mf.cval[,1017:1020],1,sum)*r4*HBO.gen.calibrationFac
hbo2434<-apply(mf.cval[,1021:1024],1,sum)*r4*HBO.gen.calibrationFac
hbo3131<-0  #illogical: workers > hh
hbo3132<-0  #illogical: workers > hh
hbo3133<-0  #illogical: workers > hh
hbo3134<-0  #illogical: workers > hh
hbo3231<-0  #illogical: workers > hh
hbo3232<-0  #illogical: workers > hh
hbo3233<-0  #illogical: workers > hh
hbo3234<-0  #illogical: workers > hh
hbo3331<-0  #more than 3 cars not allowed
hbo3332<-0  #more than 3 cars not allowed
hbo3333<-0  #more than 3 cars not allowed
hbo3334<-0  #more than 3 cars not allowed
hbo3431<-0  #more than 3 cars not allowed
hbo3432<-0  #more than 3 cars not allowed
hbo3433<-0  #more than 3 cars not allowed
hbo3434<-0  #more than 3 cars not allowed 

#########################################

# TOTAL PRODUCTIONS

# Low Income Productions (income bin 1)
ma.hboprl <- hbo0101+hbo0201+hbo0301+hbo0401+hbo1101+hbo1201+hbo1301+hbo1401+
             hbo2101+hbo2201+hbo2301+hbo2401+hbo3101+hbo3201+hbo3301+hbo3401+
             hbo0111+hbo0211+hbo0311+hbo0411+hbo1111+hbo1211+hbo1311+hbo1411+
             hbo2111+hbo2211+hbo2311+hbo2411+hbo3111+hbo3211+hbo3311+hbo3411+
             hbo0121+hbo0221+hbo0321+hbo0421+hbo1121+hbo1221+hbo1321+hbo1421+
             hbo2121+hbo2221+hbo2321+hbo2421+hbo3121+hbo3221+hbo3321+hbo3421+
             hbo0131+hbo0231+hbo0331+hbo0431+hbo1131+hbo1231+hbo1331+hbo1431+
             hbo2131+hbo2231+hbo2331+hbo2431+hbo3131+hbo3231+hbo3331+hbo3431

# Middle Income Productions (income bins 2 & 3)
ma.hboprm <- hbo0102+hbo0202+hbo0302+hbo0402+hbo1102+hbo1202+hbo1302+hbo1402+
             hbo2102+hbo2202+hbo2302+hbo2402+hbo3102+hbo3202+hbo3302+hbo3402+
             hbo0112+hbo0212+hbo0312+hbo0412+hbo1112+hbo1212+hbo1312+hbo1412+
             hbo2112+hbo2212+hbo2312+hbo2412+hbo3112+hbo3212+hbo3312+hbo3412+
             hbo0122+hbo0222+hbo0322+hbo0422+hbo1122+hbo1222+hbo1322+hbo1422+
             hbo2122+hbo2222+hbo2322+hbo2422+hbo3122+hbo3222+hbo3322+hbo3422+
             hbo0132+hbo0232+hbo0332+hbo0432+hbo1132+hbo1232+hbo1332+hbo1432+
             hbo2132+hbo2232+hbo2332+hbo2432+hbo3132+hbo3232+hbo3332+hbo3432+
             hbo0103+hbo0203+hbo0303+hbo0403+hbo1103+hbo1203+hbo1303+hbo1403+
             hbo2103+hbo2203+hbo2303+hbo2403+hbo3103+hbo3203+hbo3303+hbo3403+
             hbo0113+hbo0213+hbo0313+hbo0413+hbo1113+hbo1213+hbo1313+hbo1413+
             hbo2113+hbo2213+hbo2313+hbo2413+hbo3113+hbo3213+hbo3313+hbo3413+
             hbo0123+hbo0223+hbo0323+hbo0423+hbo1123+hbo1223+hbo1323+hbo1423+
             hbo2123+hbo2223+hbo2323+hbo2423+hbo3123+hbo3223+hbo3323+hbo3423+
             hbo0133+hbo0233+hbo0333+hbo0433+hbo1133+hbo1233+hbo1333+hbo1433+
             hbo2133+hbo2233+hbo2333+hbo2433+hbo3133+hbo3233+hbo3333+hbo3433

# High Income Productions (income bin 4)
ma.hboprh <- hbo0104+hbo0204+hbo0304+hbo0404+hbo1104+hbo1204+hbo1304+hbo1404+
             hbo2104+hbo2204+hbo2304+hbo2404+hbo3104+hbo3204+hbo3304+hbo3404+
             hbo0114+hbo0214+hbo0314+hbo0414+hbo1114+hbo1214+hbo1314+hbo1414+
             hbo2114+hbo2214+hbo2314+hbo2414+hbo3114+hbo3214+hbo3314+hbo3414+
             hbo0124+hbo0224+hbo0324+hbo0424+hbo1124+hbo1224+hbo1324+hbo1424+
             hbo2124+hbo2224+hbo2324+hbo2424+hbo3124+hbo3224+hbo3324+hbo3424+
             hbo0134+hbo0234+hbo0334+hbo0434+hbo1134+hbo1234+hbo1334+hbo1434+
             hbo2134+hbo2234+hbo2334+hbo2434+hbo3134+hbo3234+hbo3334+hbo3434

# Total Productions (All Incomes)
ma.hbopr <- ma.hboprl + ma.hboprm + ma.hboprh

#############################################

# Calculate Percentage Productions by worker, hh size, cval, and income

hboLowInc.m<-ma.hboprl
hboLowInc.m[hboLowInc.m==0]<-1
hboMedInc.m<-ma.hboprm
hboMedInc.m[hboMedInc.m==0]<-1
hboHiInc.m<-ma.hboprh
hboHiInc.m[hboHiInc.m==0]<-1

# A=1 HH      #=CVAL    l=low income
# B=2 HH                m=mid income
# C=3,4+ HH             h=high income

malist.hbo<-list(
md.hboA0l=(hbo0101+hbo1101+hbo2101+hbo3101)/hboLowInc.m,
md.hboB0l=(hbo0201+hbo1201+hbo2201+hbo3201)/hboLowInc.m,
md.hboA0m=(hbo0102+hbo1102+hbo2102+hbo3102+
           hbo0103+hbo1103+hbo2103+hbo3103)/hboMedInc.m,
md.hboB0m=(hbo0202+hbo1202+hbo2202+hbo3202+
           hbo0203+hbo1203+hbo2203+hbo3203)/hboMedInc.m,
md.hboA0h=(hbo0104+hbo1104+hbo2104+hbo3104)/hboHiInc.m,
md.hboB0h=(hbo0204+hbo1204+hbo2204+hbo3204)/hboHiInc.m,
md.hboA1l=(hbo0111+hbo1111+hbo2111+hbo3111)/hboLowInc.m,
md.hboB1l=(hbo0211+hbo1211+hbo2211+hbo3211)/hboLowInc.m,
md.hboA1m=(hbo0112+hbo1112+hbo2112+hbo3112+
           hbo0113+hbo1113+hbo2113+hbo3113)/hboMedInc.m,
md.hboB1m=(hbo0212+hbo1212+hbo2212+hbo3212+
           hbo0213+hbo1213+hbo2213+hbo3213)/hboMedInc.m,
md.hboA1h=(hbo0114+hbo1114+hbo2114+hbo3114)/hboHiInc.m,
md.hboB1h=(hbo0214+hbo1214+hbo2214+hbo3214)/hboHiInc.m,
md.hboA2l=(hbo0121+hbo1121+hbo2121+hbo3121)/hboLowInc.m,
md.hboB2l=(hbo0221+hbo1221+hbo2221+hbo3221)/hboLowInc.m,
md.hboA2m=(hbo0122+hbo1122+hbo2122+hbo3122+
           hbo0123+hbo1123+hbo2123+hbo3123)/hboMedInc.m,
md.hboB2m=(hbo0222+hbo1222+hbo2222+hbo3222+
           hbo0223+hbo1223+hbo2223+hbo3223)/hboMedInc.m,
md.hboA2h=(hbo0124+hbo1124+hbo2124+hbo3124)/hboHiInc.m,
md.hboB2h=(hbo0224+hbo1224+hbo2224+hbo3224)/hboHiInc.m,
md.hboA3l=(hbo0131+hbo1131+hbo2131+hbo3131)/hboLowInc.m,
md.hboB3l=(hbo0231+hbo1231+hbo2231+hbo3231)/hboLowInc.m,
md.hboA3m=(hbo0132+hbo1132+hbo2132+hbo3132+
           hbo0133+hbo1133+hbo2133+hbo3133)/hboMedInc.m,
md.hboB3m=(hbo0232+hbo1232+hbo2232+hbo3232+
           hbo0233+hbo1233+hbo2233+hbo3233)/hboMedInc.m,
md.hboA3h=(hbo0134+hbo1134+hbo2134+hbo3134)/hboHiInc.m,
md.hboB3h=(hbo0234+hbo1234+hbo2234+hbo3234)/hboHiInc.m,
md.hboC0l=(hbo0301+hbo0401+hbo1301+hbo1401+hbo2301+hbo2401+hbo3301+hbo3401)/hboLowInc.m,
md.hboC0m=(hbo0302+hbo0402+hbo1302+hbo1402+hbo2302+hbo2402+hbo3302+hbo3402+
           hbo0303+hbo0403+hbo1303+hbo1403+hbo2303+hbo2403+hbo3303+hbo3403)/hboMedInc.m,
md.hboC0h=(hbo0304+hbo0404+hbo1304+hbo1404+hbo2304+hbo2404+hbo3304+hbo3404)/hboHiInc.m,
md.hboC1l=(hbo0311+hbo0411+hbo1311+hbo1411+hbo2311+hbo2411+hbo3311+hbo3411)/hboLowInc.m,
md.hboC1m=(hbo0312+hbo0412+hbo1312+hbo1412+hbo2312+hbo2412+hbo3312+hbo3412+
           hbo0313+hbo0413+hbo1313+hbo1413+hbo2313+hbo2413+hbo3313+hbo3413)/hboMedInc.m,
md.hboC1h=(hbo0314+hbo0414+hbo1314+hbo1414+hbo2314+hbo2414+hbo3314+hbo3414)/hboHiInc.m,
md.hboC2l=(hbo0321+hbo0421+hbo1321+hbo1421+hbo2321+hbo2421+hbo3321+hbo3421)/hboLowInc.m,
md.hboC2m=(hbo0322+hbo0422+hbo1322+hbo1422+hbo2322+hbo2422+hbo3322+hbo3422+
           hbo0323+hbo0423+hbo1323+hbo1423+hbo2323+hbo2423+hbo3323+hbo3423)/hboMedInc.m,
md.hboC2h=(hbo0324+hbo0424+hbo1324+hbo1424+hbo2324+hbo2424+hbo3324+hbo3424)/hboHiInc.m,
md.hboC3l=(hbo0331+hbo0431+hbo1331+hbo1431+hbo2331+hbo2431+hbo3331+hbo3431)/hboLowInc.m,
md.hboC3m=(hbo0332+hbo0432+hbo1332+hbo1432+hbo2332+hbo2432+hbo3332+hbo3432+
           hbo0333+hbo0433+hbo1333+hbo1433+hbo2333+hbo2433+hbo3333+hbo3433)/hboMedInc.m,
md.hboC3h=(hbo0334+hbo0434+hbo1334+hbo1434+hbo2334+hbo2434+hbo3334+hbo3434)/hboHiInc.m,
ma.hbopr=ma.hbopr, ma.hboprl=ma.hboprl, ma.hboprm=ma.hboprm, ma.hboprh=ma.hboprh)

save(malist.hbo,file="malist.hbo.dat")

rm(hboLowInc.m,hboMedInc.m,hboHiInc.m,
   hbo0101,hbo0102,hbo0103,hbo0104,hbo0201,hbo0202,hbo0203,hbo0204,hbo0301,hbo0302,hbo0303,hbo0304,hbo0401,hbo0402,hbo0403,hbo0404,
   hbo1101,hbo1102,hbo1103,hbo1104,hbo1201,hbo1202,hbo1203,hbo1204,hbo1301,hbo1302,hbo1303,hbo1304,hbo1401,hbo1402,hbo1403,hbo1404,
   hbo2101,hbo2102,hbo2103,hbo2104,hbo2201,hbo2202,hbo2203,hbo2204,hbo2301,hbo2302,hbo2303,hbo2304,hbo2401,hbo2402,hbo2403,hbo2404,
   hbo3101,hbo3102,hbo3103,hbo3104,hbo3201,hbo3202,hbo3203,hbo3204,hbo3301,hbo3302,hbo3303,hbo3304,hbo3401,hbo3402,hbo3403,hbo3404,
   hbo0111,hbo0112,hbo0113,hbo0114,hbo0211,hbo0212,hbo0213,hbo0214,hbo0311,hbo0312,hbo0313,hbo0314,hbo0411,hbo0412,hbo0413,hbo0414,
   hbo1111,hbo1112,hbo1113,hbo1114,hbo1211,hbo1212,hbo1213,hbo1214,hbo1311,hbo1312,hbo1313,hbo1314,hbo1411,hbo1412,hbo1413,hbo1414,
   hbo2111,hbo2112,hbo2113,hbo2114,hbo2211,hbo2212,hbo2213,hbo2214,hbo2311,hbo2312,hbo2313,hbo2314,hbo2411,hbo2412,hbo2413,hbo2414,
   hbo3111,hbo3112,hbo3113,hbo3114,hbo3211,hbo3212,hbo3213,hbo3214,hbo3311,hbo3312,hbo3313,hbo3314,hbo3411,hbo3412,hbo3413,hbo3414,
   hbo0121,hbo0122,hbo0123,hbo0124,hbo0221,hbo0222,hbo0223,hbo0224,hbo0321,hbo0322,hbo0323,hbo0324,hbo0421,hbo0422,hbo0423,hbo0424,
   hbo1121,hbo1122,hbo1123,hbo1124,hbo1221,hbo1222,hbo1223,hbo1224,hbo1321,hbo1322,hbo1323,hbo1324,hbo1421,hbo1422,hbo1423,hbo1424,
   hbo2121,hbo2122,hbo2123,hbo2124,hbo2221,hbo2222,hbo2223,hbo2224,hbo2321,hbo2322,hbo2323,hbo2324,hbo2421,hbo2422,hbo2423,hbo2424,
   hbo3121,hbo3122,hbo3123,hbo3124,hbo3221,hbo3222,hbo3223,hbo3224,hbo3321,hbo3322,hbo3323,hbo3324,hbo3421,hbo3422,hbo3423,hbo3424,
   hbo0131,hbo0132,hbo0133,hbo0134,hbo0231,hbo0232,hbo0233,hbo0234,hbo0331,hbo0332,hbo0333,hbo0334,hbo0431,hbo0432,hbo0433,hbo0434,
   hbo1131,hbo1132,hbo1133,hbo1134,hbo1231,hbo1232,hbo1233,hbo1234,hbo1331,hbo1332,hbo1333,hbo1334,hbo1431,hbo1432,hbo1433,hbo1434,
   hbo2131,hbo2132,hbo2133,hbo2134,hbo2231,hbo2232,hbo2233,hbo2234,hbo2331,hbo2332,hbo2333,hbo2334,hbo2431,hbo2432,hbo2433,hbo2434,
   hbo3131,hbo3132,hbo3133,hbo3134,hbo3231,hbo3232,hbo3233,hbo3234,hbo3331,hbo3332,hbo3333,hbo3334,hbo3431,hbo3432,hbo3433,hbo3434)

