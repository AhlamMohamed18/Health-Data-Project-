USE HAP464
select a.*, iif(isnumeric(LR)=1,
convert(float, LR), 1.0) as LR
, left(a.icd9, 4) as body
into #data from dbo.cleaned a 
left join dbo.adjustLR b 
on a.icd9= b.icd9 
---17431402 rows affected

--Infectious and parasitic diseases
select *
, iif(body in ('I001','I002','I003','I004','I005','I006','I007','I008','I009','I010','I011','I012','I013',
'I014','I015','I016','I017','I018','I019','I020','I021','I022','I023','I024','I025','I026','I027','I028',
'I029','I030','I031','I032','I033','I034','I035','I036','I037','I038','I039','I040','I041','I042','I043',
'I044','I045','I046','I047','I048','I049','I050','I051','I052','I053','I054','I055','I056','I057','I058',
'I059','I060','I061','I062','I063','I064','I065','I066','I067','I068','I069','I070','I071','I072','I073',
'I074','I075','I076','I077','I078','I079','I080','I081','I082','I083','I084','I085','I086','I087','I088',
'I089','I090','I091','I092','I093','I094','I095','I096','I097','I098','I099','I100','I101','I102','I103',
'I104','I105','I106','I107','I108','I109','I110','I111','I112','I113','I114','I115','I116','I117','I118',
'I119','I120','I121','I122','I123','I124','I125','I126','I127','I128','I129','I130','I131','I132','I133',
'I134','I135','I136','I137','I138',
'I139'),LR, 1) as Infections

--Neoplasms
, iif(body in ('I140','I141','I142','I143','I144','I145','I146','I147','I148','I149','I150','I151','I152',
'I153','I154','I155','I156','I157','I158','I159','I160','I161','I162','I163','I164','I165','I166','I167',
'I168','I169','I170','I171','I172','I173','I174','I175','I176','I177','I178','I179','I180','I181','I182',
'I183','I184','I185','I186','I187','I188','I189','I190','I191','I192','I193','I194','I195','I196','I197',
'I198','I199','I200','I201','I202','I203','I204','I205','I206','I207','I208','I209','I210','I211','I212',
'I213','I214','I215','I216','I217','I218','I219','I220','I221','I222','I223','I224','I225',
'I226','I227','I228','I229','I230','I231','I232','I233','I234','I235','I236','I237','I238','I239'),
LR, 1) as Neoplasms


--Endocrine, nutritional and metabolic diseases, and immunity disorders
, iif(body in ('I240','I241','I242','I243','I244','I245','I246','I247','I248','I249',
'I250','I251','I252','I253','I254','I255','I256','I257','I258','I259','I260','I261',
'I262','I263','I264','I265','I266','I267','I268','I269','I270','I271','I272',
'I273','I274','I275','I276','I277','I278','I279'),
LR, 1) as Endocrine

--Diseases of the blood and blood-forming organs
, iif (body in ('I280','I281','I282','I283','I284',
'I285','I286','I287','I288','I289'),
LR, 1) as BloodDiseases


--Mental Disorders
, iif (body in ('I290','I291','I292','I293','I294','I295','I296','I297',
'I298','I299','I300','I301','I302','I303','I304','I305','I306','I307','I308',
'I309','I310','I311','I312','I313','I314','I315','I316','I317','I318','I319'),
LR, 1) as MentalDisorders


--Diseases of the nervous system
, iif (body in ('I320','I321','I322','I323','I324','I325','I326','I327','I328','I329','I330',
'I331','I332','I333','I334','I335','I336','I337','I338','I339','I340','I341','I342','I343',
'I344','I345','I346','I347','I348','I349','I350','I351','I352','I353','I354','I355','I356','I357','I358','I359'),
LR, 1) as NervousSystem

--Diseases of the sense organs
, iif (body in ('I360','I361','I362','I363','I364','I365','I366','I367','I368','I369','I370',
'I371','I372','I373','I374','I375','I376','I377','I378','I379','I380','I381',
'I382','I383','I384','I385','I386','I387','I388','I389'),
LR, 1) as SenseOrgan


--Diseases of the circulatory system
, iif (body in ('I390','I391','I392','I393','I394','I395','I396','I397','I398','I399',
'I400','I401','I402','I403','I404','I405','I406','I407','I408','I409','I410','I411',
'I412','I413','I414','I415','I416','I417','I418','I419','I420','I421','I422','I423','I424',
'I425','I426','I427','I428','I429','I430','I431','I432','I433','I434','I435','I436','I437',
'I438','I439','I440','I441','I442','I443','I444','I445','I446','I447','I448','I449',
'I450','I451','I452','I453','I454','I455','I456','I457','I458','I459'),
LR, 1) as CirculatoryDiseases


--Diseases of the respiratory system
, iif( body in ('I460','I461','I462','I463','I464','I465','I466','I467','I468','I469','I470','I471',
'I472','I473','I474','I475','I476','I477','I478','I479','I480','I481','I482','I483','I484','I485',
'I486','I487','I488','I489','I490','I491','I492','I493','I494','I495','I496','I497','I498','I499',
'I500','I501','I502','I503','I504','I505','I506','I507','I508','I509','I510','I511','I512',
'I513','I514','I515','I516','I517','I518','I519'),
LR, 1) as RespiratoryDiseases

--Diseases of the digestive system
, iif( body in ('I520','I521','I522','I523','I524','I525','I526','I527','I528','I529',
'I530','I531','I532','I533','I534','I535','I536','I537','I538','I539','I540','I541','I542',
'I543','I544','I545','I546','I547','I548','I549','I550','I551','I552','I553','I554','I555','I556',
'I557','I558','I559','I560','I561','I562','I563','I564','I565','I566','I567','I568','I569',
'I570','I571','I572','I573','I574','I575','I576','I577','I578','I579'), 
LR, 1) as DigestiveDiseases
--Diseases of the genitourinary system
, iif( body in ('I580','I581','I582','I583','I584','I585','I586','I587','I588','I589',
'I590','I591','I592','I593','I594','I595','I596','I597','I598','I599','I600','I601','I602','I603',
'I604','I605','I606','I607','I608','I609','I610','I611','I612','I613','I614','I615','I616',
'I617','I618','I619','I620','I621','I622','I623','I624','I625','I626','I627','I628','I629'),
LR, 1) as GenitourinaryDiseases

--Complications of pregnancy, childbirth, and the puerperium
,iif (body in('I630','I631','I632','I633','I634','I635','I636','I637','I638','I639',
'I640','I641','I642','I643','I644','I645','I646','I647','I648','I649','I650','I651',
'I652','I653','I654','I655','I656','I657','I658','I659','I660','I661','I662','I663',
'I664','I665','I666','I667','I668','I669','I670','I671','I672','I673','I674','I675','I676'),
LR, 1) as PregnancyComplications

--Diseases of the skin and subcutaneous tissue
,iif (body in('I680','I681','I682','I683','I684','I685','I686','I687','I688',
'I689','I690','I691','I692','I693','I694','I695','I696','I697','I698','I699',
'I700','I701','I702','I703','I704','I705','I706','I707','I708','I709'),
LR, 1) as SkinDiseases


--Diseases of the musculoskeletal system and connective tissue
,iif (body in('I710','I711','I712','I713','I714','I715','I716','I717',
'I718','I719','I720','I721','I722','I723','I724','I725','I726','I727',
'I728','I729','I730','I731','I732','I733','I734','I735','I736','I737','I738','I739'),
LR, 1) as MusculoSkeletalDiseases


--Congenital anomalies
,iif (body in('I740','I741','I742','I743','I744','I745','I746','I747','I748',
'I749','I750','I751','I752','I753','I754','I755','I756','I757','I758','I759'),
LR, 1) as CongenitalAnomalies



--Certain conditions originating in the perinatal period
,iif (body in('I760','I761','I762','I763','I764','I765','I766','I767',
'I768','I769','I770','I771','I772','I773','I774','I775','I776','I777','I778','I779'),
LR, 1) as PerinatalConditions


--Symptoms, signs, and ill-defined conditions
,iif (body in('I780','I781','I782','I783','I784','I785','I786','I787','I788','I789','I790',
'I791','I792','I793','I794','I795','I796','I797','I798','I799'),
LR, 1) as Symptoms


--Injury and poisoning
,iif (body in('I800','I801','I802','I803','I804','I805','I806','I807','I808','I809','I810',
'I811','I812','I813','I814','I815','I816','I817','I818','I819','I820','I821','I822','I823',
'I824','I825','I826','I827','I828','I829','I830','I831','I832','I833','I834','I835','I836',
'I837','I838','I839','I840','I841','I842','I843','I844','I845','I846','I847','I848','I849','I850','I851',
'I852','I853','I854','I855','I856','I857','I858','I859','I860','I861','I862','I863','I864',
'I865','I866','I867','I868','I869','I870','I871','I872','I873','I874','I875','I876','I877',
'I878','I879','I880','I881','I882','I883','I884','I885','I886','I887','I888','I889','I890',
'I891','I892','I893','I894','I895','I896','I897','I898','I899','I900','I901','I902','I903',
'I904','I905','I906','I907','I908','I909','I910','I911','I912','I913','I914','I915','I916',
'I917','I918','I919','I920','I921','I922','I923','I924','I925','I926','I927','I928','I929',
'I930','I931','I932','I933','I934','I935','I936','I937','I938','I939','I940','I941','I942','I943',
'I944','I945','I946','I947','I948','I949','I950','I951','I952','I953','I954','I955','I956','I957',
'I958','I959','I960','I961','I962','I963','I964','I965','I966','I967','I968','I969','I970',
'I971','I972','I973','I974','I975','I976','I977','I978','I979','I980','I981','I982','I983','I984','I985',
'I986','I987','I988','I989','I990','I991','I992','I993','I994','I995','I996','I997','I998','I999'),
LR, 1) as Injury
, iif (body like '%v%', LR, 1) as Vcodes
, iif (body like '%E%', LR, 1) as Ecodes
into #bodysystem
from #data

select id, max(Infections)*max(Neoplasms)*max(Endocrine)*max(BloodDiseases)*max(MentalDisorders)
*max(NervousSystem)*max(SenseOrgan)*max(CirculatoryDiseases)*max(RespiratoryDiseases)*max(DigestiveDiseases)
*max(GenitourinaryDiseases)*max(PregnancyComplications)*max(SkinDiseases)*max(MusculoskeletalDiseases)
*max(CongenitalAnomalies)*max(PerinatalConditions)*max(symptoms)*max(injury)*max(Vcodes)*max(Ecodes)
as Predicted
into #bodysystem2
from #bodysystem
group by id

select * from #bodysystem2
order by predicted desc
