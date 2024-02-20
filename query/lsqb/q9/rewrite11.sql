## AggReduce Phase: 

# AggReduce33
# 1. aggView
create or replace view aggView4529743708161193775 as select PersonId as v4, COUNT(*) as annot from Person_hasInterest_Tag as Person_hasInterest_Tag group by PersonId;
# 2. aggJoin
create or replace view aggJoin808430422563648372 as select Person1Id as v4, annot from Person_knows_Person as pkp3, aggView4529743708161193775 where pkp3.Person1Id=aggView4529743708161193775.v4;

# AggReduce34
# 1. aggView
create or replace view aggView2691098818657568543 as select v4, SUM(annot) as annot from aggJoin808430422563648372 group by v4;
# 2. aggJoin
create or replace view aggJoin7500424036910953205 as select Person1Id as v2, Person2Id as v4, annot from Person_knows_Person as pkp2, aggView2691098818657568543 where pkp2.Person2Id=aggView2691098818657568543.v4;

# AggReduce35
# 1. aggView
create or replace view aggView6219738258798091045 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
# 2. aggJoin
create or replace view aggJoin3222784416343759099 as select aggJoin7500424036910953205.annot * aggView6219738258798091045.annot as annot from aggJoin7500424036910953205 join aggView6219738258798091045 using(v2) where v1 < v4;
# Final result: 
select SUM(annot) as v9 from aggJoin3222784416343759099;

# drop view aggView4529743708161193775, aggJoin808430422563648372, aggView2691098818657568543, aggJoin7500424036910953205, aggView6219738258798091045, aggJoin3222784416343759099;
