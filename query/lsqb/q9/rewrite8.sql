## AggReduce Phase: 

# AggReduce24
# 1. aggView
create or replace view aggView4193876929077246326 as select PersonId as v4, COUNT(*) as annot from Person_hasInterest_Tag as Person_hasInterest_Tag group by PersonId;
# 2. aggJoin
create or replace view aggJoin1855482513039264159 as select Person1Id as v4, annot from Person_knows_Person as pkp3, aggView4193876929077246326 where pkp3.Person1Id=aggView4193876929077246326.v4;

# AggReduce25
# 1. aggView
create or replace view aggView4266062350851134509 as select v4, SUM(annot) as annot from aggJoin1855482513039264159 group by v4;
# 2. aggJoin
create or replace view aggJoin6495471562799797623 as select Person1Id as v2, Person2Id as v4, annot from Person_knows_Person as pkp2, aggView4266062350851134509 where pkp2.Person2Id=aggView4266062350851134509.v4;

# AggReduce26
# 1. aggView
create or replace view aggView325132011575581434 as select v2, SUM(annot) as annot, v4 from aggJoin6495471562799797623 group by v2,v4;
# 2. aggJoin
create or replace view aggJoin7141051740303669033 as select annot from Person_knows_Person as pkp1, aggView325132011575581434 where pkp1.Person2Id=aggView325132011575581434.v2 and Person1Id<v4;
# Final result: 
select SUM(annot) as v9 from aggJoin7141051740303669033;

# drop view aggView4193876929077246326, aggJoin1855482513039264159, aggView4266062350851134509, aggJoin6495471562799797623, aggView325132011575581434, aggJoin7141051740303669033;
