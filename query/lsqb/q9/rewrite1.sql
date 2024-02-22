create or replace view aggView7539785690206959022 as select PersonId as v4, COUNT(*) as annot from Person_hasInterest_Tag as Person_hasInterest_Tag group by PersonId;
create or replace view aggJoin1765528892078045313 as select Person1Id as v4, annot from Person_knows_Person as pkp3, aggView7539785690206959022 where pkp3.Person1Id=aggView7539785690206959022.v4;
create or replace view aggView8479562175236726062 as select v4, SUM(annot) as annot from aggJoin1765528892078045313 group by v4;
create or replace view aggJoin3813763183987085180 as select Person1Id as v2, Person2Id as v4, annot from Person_knows_Person as pkp2, aggView8479562175236726062 where pkp2.Person2Id=aggView8479562175236726062.v4;
create or replace view aggView7558878546383368612 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
create or replace view aggJoin253657434823046243 as select aggJoin3813763183987085180.annot * aggView7558878546383368612.annot as annot from aggJoin3813763183987085180 join aggView7558878546383368612 using(v2) where v1 < v4;
select SUM(annot) as v9 from aggJoin253657434823046243;
