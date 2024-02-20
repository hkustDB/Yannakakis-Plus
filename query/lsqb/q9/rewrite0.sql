## AggReduce Phase: 

# AggReduce0
# 1. aggView
create or replace view aggView4699666272087705861 as select Person1Id as v4, COUNT(*) as annot from Person_knows_Person as pkp3 group by Person1Id;
# 2. aggJoin
create or replace view aggJoin552312829630208999 as select Person1Id as v2, Person2Id as v4, annot from Person_knows_Person as pkp2, aggView4699666272087705861 where pkp2.Person2Id=aggView4699666272087705861.v4;

# AggReduce1
# 1. aggView
create or replace view aggView3588602113577757554 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
# 2. aggJoin
create or replace view aggJoin4412566371581572225 as select v4, aggJoin552312829630208999.annot * aggView3588602113577757554.annot as annot from aggJoin552312829630208999 join aggView3588602113577757554 using(v2) where v1 < v4;

# AggReduce2
# 1. aggView
create or replace view aggView2281505783650667497 as select v4, SUM(annot) as annot from aggJoin4412566371581572225 group by v4;
# 2. aggJoin
create or replace view aggJoin5943472727953028883 as select annot from Person_hasInterest_Tag as Person_hasInterest_Tag, aggView2281505783650667497 where Person_hasInterest_Tag.PersonId=aggView2281505783650667497.v4;
# Final result: 
select SUM(annot) as v9 from aggJoin5943472727953028883;

# drop view aggView4699666272087705861, aggJoin552312829630208999, aggView3588602113577757554, aggJoin4412566371581572225, aggView2281505783650667497, aggJoin5943472727953028883;
