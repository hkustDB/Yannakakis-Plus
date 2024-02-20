## AggReduce Phase: 

# AggReduce6
# 1. aggView
create or replace view aggView4139105499526560940 as select Person1Id as v4, COUNT(*) as annot from Person_knows_Person as pkp3 group by Person1Id;
# 2. aggJoin
create or replace view aggJoin2581724893850481520 as select Person1Id as v2, Person2Id as v4, annot from Person_knows_Person as pkp2, aggView4139105499526560940 where pkp2.Person2Id=aggView4139105499526560940.v4;

# AggReduce7
# 1. aggView
create or replace view aggView4771990403535257663 as select PersonId as v4, COUNT(*) as annot from Person_hasInterest_Tag as Person_hasInterest_Tag group by PersonId;
# 2. aggJoin
create or replace view aggJoin6168539209693316571 as select v2, v4, aggJoin2581724893850481520.annot * aggView4771990403535257663.annot as annot from aggJoin2581724893850481520 join aggView4771990403535257663 using(v4);

# AggReduce8
# 1. aggView
create or replace view aggView5831980599545618565 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
# 2. aggJoin
create or replace view aggJoin5530826721039274758 as select aggJoin6168539209693316571.annot * aggView5831980599545618565.annot as annot from aggJoin6168539209693316571 join aggView5831980599545618565 using(v2) where v1 < v4;
# Final result: 
select SUM(annot) as v9 from aggJoin5530826721039274758;

# drop view aggView4139105499526560940, aggJoin2581724893850481520, aggView4771990403535257663, aggJoin6168539209693316571, aggView5831980599545618565, aggJoin5530826721039274758;
