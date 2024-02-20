## AggReduce Phase: 

# AggReduce9
# 1. aggView
create or replace view aggView6067111693183980951 as select Person1Id as v4, COUNT(*) as annot from Person_knows_Person as pkp3 group by Person1Id;
# 2. aggJoin
create or replace view aggJoin150502177168785359 as select PersonId as v4, annot from Person_hasInterest_Tag as Person_hasInterest_Tag, aggView6067111693183980951 where Person_hasInterest_Tag.PersonId=aggView6067111693183980951.v4;

# AggReduce10
# 1. aggView
create or replace view aggView4109768627830821886 as select v4, SUM(annot) as annot from aggJoin150502177168785359 group by v4;
# 2. aggJoin
create or replace view aggJoin6707088402463217591 as select Person1Id as v2, Person2Id as v4, annot from Person_knows_Person as pkp2, aggView4109768627830821886 where pkp2.Person2Id=aggView4109768627830821886.v4;

# AggReduce11
# 1. aggView
create or replace view aggView47999535925313342 as select v2, SUM(annot) as annot, v4 from aggJoin6707088402463217591 group by v2,v4;
# 2. aggJoin
create or replace view aggJoin1508450345483709083 as select annot from Person_knows_Person as pkp1, aggView47999535925313342 where pkp1.Person2Id=aggView47999535925313342.v2 and Person1Id<v4;
# Final result: 
select SUM(annot) as v9 from aggJoin1508450345483709083;

# drop view aggView6067111693183980951, aggJoin150502177168785359, aggView4109768627830821886, aggJoin6707088402463217591, aggView47999535925313342, aggJoin1508450345483709083;
