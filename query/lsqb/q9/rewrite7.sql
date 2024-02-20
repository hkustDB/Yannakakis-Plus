## AggReduce Phase: 

# AggReduce21
# 1. aggView
create or replace view aggView9052514459385453313 as select Person1Id as v4, COUNT(*) as annot from Person_knows_Person as pkp3 group by Person1Id;
# 2. aggJoin
create or replace view aggJoin2766064707924337378 as select PersonId as v4, annot from Person_hasInterest_Tag as Person_hasInterest_Tag, aggView9052514459385453313 where Person_hasInterest_Tag.PersonId=aggView9052514459385453313.v4;

# AggReduce22
# 1. aggView
create or replace view aggView2548070616199895800 as select v4, SUM(annot) as annot from aggJoin2766064707924337378 group by v4;
# 2. aggJoin
create or replace view aggJoin2640244441535218962 as select Person1Id as v2, Person2Id as v4, annot from Person_knows_Person as pkp2, aggView2548070616199895800 where pkp2.Person2Id=aggView2548070616199895800.v4;

# AggReduce23
# 1. aggView
create or replace view aggView3850694122964933559 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
# 2. aggJoin
create or replace view aggJoin5785764003086456594 as select aggJoin2640244441535218962.annot * aggView3850694122964933559.annot as annot from aggJoin2640244441535218962 join aggView3850694122964933559 using(v2) where v1 < v4;
# Final result: 
select SUM(annot) as v9 from aggJoin5785764003086456594;

# drop view aggView9052514459385453313, aggJoin2766064707924337378, aggView2548070616199895800, aggJoin2640244441535218962, aggView3850694122964933559, aggJoin5785764003086456594;
