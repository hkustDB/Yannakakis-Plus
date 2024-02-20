## AggReduce Phase: 

# AggReduce18
# 1. aggView
create or replace view aggView2194784601567813552 as select Person1Id as v4, COUNT(*) as annot from Person_knows_Person as pkp3 group by Person1Id;
# 2. aggJoin
create or replace view aggJoin5913114051852652752 as select Person1Id as v2, Person2Id as v4, annot from Person_knows_Person as pkp2, aggView2194784601567813552 where pkp2.Person2Id=aggView2194784601567813552.v4;

# AggReduce19
# 1. aggView
create or replace view aggView8299698037171583056 as select PersonId as v4, COUNT(*) as annot from Person_hasInterest_Tag as Person_hasInterest_Tag group by PersonId;
# 2. aggJoin
create or replace view aggJoin6259962695001431427 as select v2, v4, aggJoin5913114051852652752.annot * aggView8299698037171583056.annot as annot from aggJoin5913114051852652752 join aggView8299698037171583056 using(v4);

# AggReduce20
# 1. aggView
create or replace view aggView1090380915830979542 as select v2, SUM(annot) as annot, v4 from aggJoin6259962695001431427 group by v2,v4;
# 2. aggJoin
create or replace view aggJoin1699462547295355915 as select annot from Person_knows_Person as pkp1, aggView1090380915830979542 where pkp1.Person2Id=aggView1090380915830979542.v2 and Person1Id<v4;
# Final result: 
select SUM(annot) as v9 from aggJoin1699462547295355915;

# drop view aggView2194784601567813552, aggJoin5913114051852652752, aggView8299698037171583056, aggJoin6259962695001431427, aggView1090380915830979542, aggJoin1699462547295355915;
