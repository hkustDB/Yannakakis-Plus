## AggReduce Phase: 

# AggReduce2
# 1. aggView
create or replace view aggView5298080346098043668 as select PersonId as v5, COUNT(*) as annot from Person_hasInterest_Tag as Person_hasInterest_Tag group by PersonId;
# 2. aggJoin
create or replace view aggJoin998944164289207624 as select Person1Id as v2, Person2Id as v5, annot from Person_knows_Person as pkp2, aggView5298080346098043668 where pkp2.Person2Id=aggView5298080346098043668.v5;

# AggReduce3
# 1. aggView
create or replace view aggView5786384858869854789 as select v2, SUM(annot) as annot, v5 from aggJoin998944164289207624 group by v2,v5;
# 2. aggJoin
create or replace view aggJoin5335721763584391917 as select annot from Person_knows_Person as pkp1, aggView5786384858869854789 where pkp1.Person2Id=aggView5786384858869854789.v2 and Person1Id<v5;
# Final result: 
select SUM(annot) as v7 from aggJoin5335721763584391917;

# drop view aggView5298080346098043668, aggJoin998944164289207624, aggView5786384858869854789, aggJoin5335721763584391917;
