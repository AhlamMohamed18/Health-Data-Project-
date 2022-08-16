USE HAP464

---Remove duplicate diagnoses
select id, icd9,
iif(max(ageatdeath) is null, 0.,
iif(max(ageatdeath) - max(ageatdx) > .5, 1., 0.)) as dead
into #data from dbo.cleaned
group by id, icd9
--10262068 rows affected

-- Removing duplicate ids
select id, max(dead) as dead2
into #data3 from #data
group by id
--829625 rows affected

--Calculate total number od dead patients and alive patients
select sum(dead2) as [a+c],
sum(1-dead2) as [b+d]
into #temp1 from #data3
select * from #temp1
--a+c = 102747.0
--b+d = 726878.0

--Calculate a,b,c,d,a+b
select icd9, [a+c], [b+d],
sum(dead) + sum(1-dead)as [a+b]
,sum(dead) as [a],
sum(1-dead) as [b],
[a+c] - sum(dead) as [c],
[b+d] - sum(1-dead) as [d]
into #temp2 from #data cross join #temp1
group by icd9, [a+c], [b+d]
--10761 rows affected

--Calculate Likelihood Ratio
select icd9, a,b,c,d,[a+c],[b+d],
case 
	when [a]<1. then 1.0/([a+b] + 1.0)
	when [b]<1. then [a+b] + 1.0
	else (a/b)*((b+d)/(a+c))
	end as lr
into dbo.lr from #temp2
--10761 rows affected

select * from dbo.lr
order by lr desc

