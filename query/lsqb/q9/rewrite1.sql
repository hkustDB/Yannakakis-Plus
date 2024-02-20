## AggReduce Phase: 

# AggReduce3
# 1. aggView
create or replace view aggView59706204835686343 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
# 2. aggJoin
create or replace view aggJoin2389445522361230927 as select Person2Id as v4, annot from Person_knows_Person as pkp2, aggView59706204835686343 where pkp2.Person1Id=aggView59706204835686343.v2 and v1<Person2Id;

# AggReduce4
# 1. aggView
create or replace view aggView6261091350568131544 as select v4, SUM(annot) as annot from aggJoin2389445522361230927 group by v4;
# 2. aggJoin
create or replace view aggJoin1569687142505312090 as select Person1Id as v4, annot from Person_knows_Person as pkp3, aggView6261091350568131544 where pkp3.Person1Id=aggView6261091350568131544.v4;

# AggReduce5
# 1. aggView
create or replace view aggView7966239521592312890 as select v4, SUM(annot) as annot from aggJoin1569687142505312090 group by v4;
# 2. aggJoin
create or replace view aggJoin8938779501441906732 as select annot from Person_hasInterest_Tag as Person_hasInterest_Tag, aggView7966239521592312890 where Person_hasInterest_Tag.PersonId=aggView7966239521592312890.v4;
# Final result: 
select SUM(annot) as v9 from aggJoin8938779501441906732;

# drop view aggView59706204835686343, aggJoin2389445522361230927, aggView6261091350568131544, aggJoin1569687142505312090, aggView7966239521592312890, aggJoin8938779501441906732;
