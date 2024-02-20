## AggReduce Phase: 

# AggReduce15
# 1. aggView
create or replace view aggView419713050984824329 as select Person1Id as v4, COUNT(*) as annot from Person_knows_Person as pkp3 group by Person1Id;
# 2. aggJoin
create or replace view aggJoin6215651657719214054 as select PersonId as v4, annot from Person_hasInterest_Tag as Person_hasInterest_Tag, aggView419713050984824329 where Person_hasInterest_Tag.PersonId=aggView419713050984824329.v4;

# AggReduce16
# 1. aggView
create or replace view aggView7967864634185684595 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
# 2. aggJoin
create or replace view aggJoin8002885205181354436 as select Person2Id as v4, annot from Person_knows_Person as pkp2, aggView7967864634185684595 where pkp2.Person1Id=aggView7967864634185684595.v2 and v1<Person2Id;

# AggReduce17
# 1. aggView
create or replace view aggView7564321928063164182 as select v4, SUM(annot) as annot from aggJoin8002885205181354436 group by v4;
# 2. aggJoin
create or replace view aggJoin2126624173449862335 as select aggJoin6215651657719214054.annot * aggView7564321928063164182.annot as annot from aggJoin6215651657719214054 join aggView7564321928063164182 using(v4);
# Final result: 
select SUM(annot) as v9 from aggJoin2126624173449862335;

# drop view aggView419713050984824329, aggJoin6215651657719214054, aggView7967864634185684595, aggJoin8002885205181354436, aggView7564321928063164182, aggJoin2126624173449862335;
