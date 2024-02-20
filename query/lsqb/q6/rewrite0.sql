## AggReduce Phase: 

# AggReduce0
# 1. aggView
create or replace view aggView6226424588509629222 as select PersonId as v5, COUNT(*) as annot from Person_hasInterest_Tag as Person_hasInterest_Tag group by PersonId;
# 2. aggJoin
create or replace view aggJoin2467842473127425389 as select Person1Id as v2, Person2Id as v5, annot from Person_knows_Person as pkp2, aggView6226424588509629222 where pkp2.Person2Id=aggView6226424588509629222.v5;

# AggReduce1
# 1. aggView
create or replace view aggView1626119710559765842 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
# 2. aggJoin
create or replace view aggJoin8663869318138923647 as select aggJoin2467842473127425389.annot * aggView1626119710559765842.annot as annot from aggJoin2467842473127425389 join aggView1626119710559765842 using(v2) where v1 < v5;
# Final result: 
select SUM(annot) as v7 from aggJoin8663869318138923647;

# drop view aggView6226424588509629222, aggJoin2467842473127425389, aggView1626119710559765842, aggJoin8663869318138923647;
