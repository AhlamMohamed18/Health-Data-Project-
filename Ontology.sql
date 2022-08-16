---Sorting ICD9 scores---
USE HAP464
Select * from dbo.lrnew where icd9 like 'I003.%'
Order by icd9 asc

---Dropping the last digit and creating icd9short---
Select icd9
,iif(stuff(icd9,7,1,'') is null, icd9,stuff(icd9,7,1,'')) as icd9short
,iif(stuff(icd9,6,2,'') is null, icd9,stuff(icd9,6,2,'')) as icd9short2
,iif(stuff(icd9,5,3,'') is null, icd9,stuff(icd9,5,3,'')) as icd9shortperiod
,iif(stuff(icd9,4,4,'') is null, icd9,stuff(icd9,4,4,'')) as icd9short4
,iif(stuff(icd9,3,5,'') is null, icd9,stuff(icd9,3,5,'')) as icd9short5
,iif(stuff(icd9,2,6,'') is null, icd9,stuff(icd9,2,6,'')) as icd9short6
,a,b,c,d,[a+b] 
into #drop1
from dbo.lrnew
Select * from dbo.lrnew
order by LR desc, icd9 desc
--10,761 rows affected

---Calculating sums of all icd9short columns
-- Total # of dead patients is 102747 and total # of alive patients is 726878
Select icd9short
, sum(a) as SumA
, sum(b) as SumB
, 102747-sum(a) as SumC
, 726878-sum(b) as SumD
, sum([a+b]) as SumAB
into #sum1
from #drop1
group by icd9short
--5534 rows affected

Select icd9short2
, sum(a) as SumA
, sum(b) as SumB
, 102747-sum(a) as SumC
, 726878-sum(b) as SumD
, sum([a+b]) as SumAB
into #sum2
from #drop1
group by icd9short2
--1170 rows affected

Select icd9shortperiod
, sum(a) as SumA
, sum(b) as SumB
, 102747-sum(a) as SumC
, 726878-sum(b) as SumD
, sum([a+b]) as SumAB
into #sum3
from #drop1
group by icd9shortperiod
--986 rows affected

Select icd9short4
, sum(a) as SumA
, sum(b) as SumB
, 102747-sum(a) as SumC
, 726878-sum(b) as SumD
, sum([a+b]) as SumAB
into #sum4
from #drop1
group by icd9short4
--112 rows affected

Select icd9short5
, sum(a) as SumA
, sum(b) as SumB
, 102747-sum(a) as SumC
, 726878-sum(b) as SumD
, sum([a+b]) as SumAB
into #sum5
from #drop1
group by icd9short5
--12 rows affected

---Merging of tables, threshold is 100
Select icd9, iif([a+b] > 100, a, iif(b.SumAB > 100, b.SumA, iif(c.SumAB > 100, c.SumA, iif(d.SumAB > 100, d.SumA, iif(e.SumAB > 100, e.SumA, e.SumA))))) as [newA]
, iif([a+b] > 100, b, iif(b.SumAB > 100, b.SumB, iif(c.SumAB > 100, c.SumB, iif(d.SumAB > 100, d.SumB, iif(e.SumAB > 100, e.SumAB, e.SumB))))) as [newB]
into #new1
from dbo.lrnew a left join #sum1 b on iif(stuff(icd9, 7, 1, '') is null, icd9, stuff(icd9, 7, 1, '')) = icd9short
left join #sum2 c on iif(stuff(icd9, 6, 2, '') is null, icd9, stuff(icd9, 6, 2, '')) = icd9short2
left join #sum4 d on iif(stuff(icd9, 4, 4, '') is null, icd9, stuff(icd9, 4, 4, '')) = icd9short4
left join #sum5 e on iif(stuff(icd9, 3, 5, '') is null, icd9, stuff(icd9, 3, 5, '')) = icd9short5
--10761 rows affected

---Creating newC and newD
Select *, 102747 - newA as newC, 726878 - newB as newD
into #newCD
from #new1
--10761 rows affected

---Creating  newAC, newBD, newAB
Select *, newA + newC as newAC, newB + newD as newBD, newA + newB as newAB
into #adjustedlr
from #newCD
--10761 rows affected

---Calculating likelihood ratio
Select icd9,newA,newB,newC,newD,newAB,newAC,newBD,
case	
	when newA<1. then 1.0/(newAB + 1.0)
	when newB<1. then newAB + 1.0
	else (newA/newB)*((newB+newD)/(newA+newC))
end as LR
into dbo.adjustedlr from #adjustedlr

Select * from dbo.adjustedlr 
order by LR desc
		