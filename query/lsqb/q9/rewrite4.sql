## AggReduce Phase: 

# AggReduce12
# 1. aggView
create or replace view aggView8606523538706091616 as select PersonId as v4, COUNT(*) as annot from Person_hasInterest_Tag as Person_hasInterest_Tag group by PersonId;
# 2. aggJoin
create or replace view aggJoin2906454103972934282 as select Person1Id as v4, annot from Person_knows_Person as pkp3, aggView8606523538706091616 where pkp3.Person1Id=aggView8606523538706091616.v4;

# AggReduce13
# 1. aggView
create or replace view aggView1891409077767923216 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
# 2. aggJoin
create or replace view aggJoin678777229574849877 as select Person2Id as v4, annot from Person_knows_Person as pkp2, aggView1891409077767923216 where pkp2.Person1Id=aggView1891409077767923216.v2 and v1<Person2Id;

# AggReduce14
# 1. aggView
create or replace view aggView6585728560853105223 as select v4, SUM(annot) as annot from aggJoin678777229574849877 group by v4;
# 2. aggJoin
create or replace view aggJoin4625689432884089907 as select aggJoin2906454103972934282.annot * aggView6585728560853105223.annot as annot from aggJoin2906454103972934282 join aggView6585728560853105223 using(v4);
# Final result: 
select SUM(annot) as v9 from aggJoin4625689432884089907;

# drop view aggView8606523538706091616, aggJoin2906454103972934282, aggView1891409077767923216, aggJoin678777229574849877, aggView6585728560853105223, aggJoin4625689432884089907;
