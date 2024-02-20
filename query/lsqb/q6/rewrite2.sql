## AggReduce Phase: 

# AggReduce4
# 1. aggView
create or replace view aggView3278213956801238347 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
# 2. aggJoin
create or replace view aggJoin6947465269054177949 as select Person2Id as v5, annot from Person_knows_Person as pkp2, aggView3278213956801238347 where pkp2.Person1Id=aggView3278213956801238347.v2 and v1<Person2Id;

# AggReduce5
# 1. aggView
create or replace view aggView5463012057242031742 as select v5, SUM(annot) as annot from aggJoin6947465269054177949 group by v5;
# 2. aggJoin
create or replace view aggJoin7696995925858184397 as select annot from Person_hasInterest_Tag as Person_hasInterest_Tag, aggView5463012057242031742 where Person_hasInterest_Tag.PersonId=aggView5463012057242031742.v5;
# Final result: 
select SUM(annot) as v7 from aggJoin7696995925858184397;

# drop view aggView3278213956801238347, aggJoin6947465269054177949, aggView5463012057242031742, aggJoin7696995925858184397;
