## AggReduce Phase: 

# AggReduce30
# 1. aggView
create or replace view aggView3460282984147591656 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
# 2. aggJoin
create or replace view aggJoin7179953043181337413 as select Person2Id as v4, annot from Person_knows_Person as pkp2, aggView3460282984147591656 where pkp2.Person1Id=aggView3460282984147591656.v2 and v1<Person2Id;

# AggReduce31
# 1. aggView
create or replace view aggView2253510451214057411 as select v4, SUM(annot) as annot from aggJoin7179953043181337413 group by v4;
# 2. aggJoin
create or replace view aggJoin6408098624909172096 as select PersonId as v4, annot from Person_hasInterest_Tag as Person_hasInterest_Tag, aggView2253510451214057411 where Person_hasInterest_Tag.PersonId=aggView2253510451214057411.v4;

# AggReduce32
# 1. aggView
create or replace view aggView8310500290700449835 as select v4, SUM(annot) as annot from aggJoin6408098624909172096 group by v4;
# 2. aggJoin
create or replace view aggJoin2320289982294880530 as select annot from Person_knows_Person as pkp3, aggView8310500290700449835 where pkp3.Person1Id=aggView8310500290700449835.v4;
# Final result: 
select SUM(annot) as v9 from aggJoin2320289982294880530;

# drop view aggView3460282984147591656, aggJoin7179953043181337413, aggView2253510451214057411, aggJoin6408098624909172096, aggView8310500290700449835, aggJoin2320289982294880530;
