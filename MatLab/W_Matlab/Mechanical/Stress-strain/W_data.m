function W_data ()
global sig_u_W sig_u_KWRe eps_u_W eps_u_KWRe eps_t_KWRe eps_t_W ...
sig_u_W_chenHR sig_y_W_chenHR RA_W RA_KWRe Skoro_y Streichen Drury ...
Kravchenko_10mu  Kravchenko_63mu Nogami_u_L Nogami_u_T Nogami_u_S...
Kavchenko_500 Kavchenko_1000 Kavchenko_1500 F_S F_T


%%%%%%%  Nagomi Data  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sig_u_W=[
    300.271140718899	855.095791291404;
369.255312769123	899.235469917241;
464.928714140722	754.358220605928;
560.659772088950	631.467345848985;
663.720902812559	539.374966996275;
765.321400261577	581.395080043193;
868.509375453769	537.672725210097;
979.010126448354	518.152953914924;
1169.22493840374	487.833282151835;
1375.67584233775	428.970859406324;
];

sig_u_KWRe=[301.274588640841	1222.05617271241;
370.628185616160	1115.51874312909;
468.931905531752	868.259460942790;
564.173107407749	850.706058053051;
672.879542999287	843.559442352244;
767.969173550990	768.206841131491;
870.450820995215	716.584498135834;
973.103471984799	730.171507103372;
1175.72065005019	663.971667072259;
1372.29958929048	624.433574615235;
1571.14303002536	516.727990942849;
];

eps_u_W=[367.835592151591	0;
472.526642970666	2.69549423390355;
566.722526480841	4.98372819677923;
677.662117376052	3.88537589459891;
767.527301953485	1.50561257320821;
861.252383943787	1.23102449766312;
975.782842811940	0.773377705087995;
1178.97155417090	0.819142384345518;
1373.50256805741	1.00220110137557;
1567.33848084324	25.7608925796903
];

eps_t_W=[356.249903167992	0;
464.349492908984	16.9978350762473;
568.541868562953	21.7124768781292;
657.105387868826	14.0841808665260;
762.600168218468	13.2430731558272;
862.885329785413	10.6196022215287;
1165.04321918192	10.7736157124429;
1372.12556579418	16.2936778122122;
1562.27665136268	61.8027127219777
];

eps_u_KWRe=[305.879418590115	13.9244105734671;
372.482391521315	7.25398468547064;
475.676811930773	10.6545939617041;
579.500422901919	8.47471622052880;
673.085579209334	4.59453384123674;
764.355158494048	6.12044826005947;
877.936680538322	3.02502186759053;
973.728812196570	2.15307077112041;
1163.93904238594	1.93508299700286;
1369.03842457008	1.71709522288535;
1577.32637129984	0.845144126415206
];

eps_t_KWRe=[288.019489303485	19.1643911413667;
354.972078579181	6.31455568458438;
442.803079070242	14.9251120247103;
537.105824564566	21.0978834566763;
627.491152940329	15.0867924483952;
726.492810683252	16.3851445414397;
823.521461728077	11.3103887382560;
920.807479271604	11.2968131049579;
1107.23025752618	13.1453234897918;
1288.71105517226	15.0882497197661;
1478.74622358397	23.1221867879456
];

RA_W=[372.604425674265	2.22581518800209;
462.396903877854	37.8183332427227;
579.289503946309	70.7389523793280;
678.979521530078	69.2683020089877;
769.990830295126	77.8335784813669;
874.286201140431	78.2039350921776;
973.571265247755	66.2912700792090;
1176.04403333834	84.6426386514866;
1380.67258317118	100.126721089073;
1582.41484695132	99.6415142275893];

RA_KWRe=[298.852791121842	9.16991915620675;
569.809226967004	42.1930805512062;
777.929763982899	68.2251497553220;
976.650041466161	74.3858389092880;
1173.20538779500	80.3524884845917;
1578.82205274088	80.9796762186822];
%%%%%%%%%%%%%%%%%%  Chen Data Celsius %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sig_u_W_chenHR=[22.2193935901989	597.417034272888;
146.542639830661	783.224131417895;
197.812803440166	738.401084472512;
245.969352585436	654.842093961172;
294.068117999140	591.357171795486;
344.858986192361	552.983408404159;
395.596198063414	533.249851333797;
447.304382995228	496.316141081255;
496.178069523312	483.739511906149;
21.5474190542089	517.450862479705;
146.619425447167	762.597948488952;
194.976459122727	697.681852250978;
242.425487352901	638.312081023956;
293.894612299194	576.887160838369;
345.323781010267	529.343036768370;
396.221032339967	511.639627629242;
443.544198429197	495.994364166319;
497.561532276674	479.005971856461];


sig_y_W_chenHR=[19.5099535490354	595.421048978075;
146.763090505097	785.168274196755;
195.773575732996	686.395667322258;
245.573796118086	610.242224055392;
298.429094993085	512.160563649332;
345.536557805838	480.551629365082;
395.965694552473	482.885799313317;
446.958175711237	438.000699095636;
494.864946228541	425.685425466191;
20.7459500540519	513.216377260668;
146.477956254231	764.413755612531;
196.675419046152	652.092361102784;
246.467526021104	568.809143992248;
296.626074654596	470.006528120714;
347.846835686685	449.321058638505;
398.760246930442	423.626472207416;
446.979933651840	439.472317519679;
498.453276397435	442.822394180872;
];

Skoro_y=[1962.194579	51.98632687;
2015.20941	46.93492428;
2072.02438	42.33081753;
2132.625355	37.31938637;
2231.178584	33.81009083;
2292.530702	28.35092896;
2373.683791	27.6513384;
2473.004317	24.67102102;
2573.097525	22.54525142;
1719.556262	85.38173776;
1772.407427	80.58165633;
1825.258593	73.24819859;
1924.354529	63.91470692;
2018.495668	54.44787965;
2117.591604	44.31437441;
2229.900331	36.31423869;
2325.693069	31.24748607;
2429.743801	27.24741821;
2527.188138	23.11401476;
2621.329277	20.58063845;
2667.574047	19.64728928;
];

Drury=[
1374.591187	474.3583886;
1637.749082	242.1028424;
1916.206854	70.39471793;
2200.784578	35.39011095;
2479.24235	24.62141786;
];

Streichen=[321.9596083	1290.896024;
471.8984088	909.9715108;
661.6168911	710.6977349;
863.5752754	580.6282746;
1080.833537	483.4177317;
1258.312118	432.9866118;
];

Kravchenko_10mu=[754.040530712453	483.125931700104;
1253.00586644594	427.461395973047;
1758.40219308643	289.043809493195];

 Kravchenko_63mu=[753.546302732720	320.225978712034;
1252.27657881731	282.206587295529;
1758.14302475560	108.498712194573];

 Nogami_u_L=[288.202392625330	863.686011302631;
360.364296856780	906.530387939919;
468.162560327567	773.137754495416;
569.247126719221	635.850625311992;
669.794045911520	549.447963210432;
869.109512790556	544.952799355014;
965.699900028623	513.358641129148;
1165.24283303046	487.335433508327;
1373.51908656543	433.888279913051;
1572.24865585542	165.195153227798];

 Nogami_u_T=[288.503640180167	522.399223708398;
362.720603802077	583.548418371919;
568.207238067964	663.359390068737;
758.512113456784	624.715590472472;
970.952395750310	564.846714558490;
1166.82466136062	517.722466862370;
1374.05529738263	432.476129497032;
1563.19005193508	158.953729530604];

 Nogami_u_S=[289.901310043143	199.592924064231;
569.627434518521	490.092544392856;
764.781616545909	576.918126279534;
966.410156557487	526.806712744448;
1163.54973996355	425.728235578449;
1567.41218784893	149.257978812462];

 Kavchenko_1500=[8.63989546483093	283.949823118845;
6.38321063199159	199.673008891864;
5.64183956401186	207.959766708098;
5.14676355292093	195.748886126781;
0.964400675654142	55.7997514102688];

 Kavchenko_1000=[8.64595085572235	413.554565446028;
5.59575485228033	397.599464575964;
4.24565764732129	313.198967396501;
3.80418778085859	272.331121522134;
0.801287567326386	92.6572712496415];

 Kavchenko_500=[8.62128310545941	473.585773018453;
4.93756573286165	422.246103834019;
4.30404436370590	386.861535519648;
1.02132135003346	98.0843292857827];

 %%%%%%%%%%%%%%%%%%  Transverse and Across Yield Factors  %%%%%%%%%%%%%%%%%%
F_S=[297.7201409	0.230971308;
568.0981837	0.768395895;
681.7301893	0.997315999;
774.2003509	1.015775369;
983.5122796	1.030057437;
1173.597899	0.885279142;
1576.495538	0.97398703;
];

F_T=[305.7420807	0.607742804;
373.3503064	0.653002433;
575.2419969	1.029599496;
778.5998096	1.089186812;
975.3267514	1.113297732;
1178.53462	1.081042944;
1381.575883	0.955372541;
1565.940749	0.949798447;
]

end