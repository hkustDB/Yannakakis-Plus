create or replace view aggView8947765934948981741 as select PersonId as v4, COUNT(*) as annot from Person_hasInterest_Tag as Person_hasInterest_Tag group by PersonId;
create or replace view aggJoin336133527742985738 as select Person1Id as v2, Person2Id as v4, annot from Person_knows_Person as pkp2, aggView8947765934948981741 where pkp2.Person2Id=aggView8947765934948981741.v4;
create or replace view aggView177023015387324495 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
create or replace view aggJoin2789367080233050316 as select v4, aggJoin336133527742985738.annot * aggView177023015387324495.annot as annot from aggJoin336133527742985738 join aggView177023015387324495 using(v2) where v1 < v4;
create or replace view aggView4980172411457801036 as select v4, SUM(annot) as annot from aggJoin2789367080233050316 group by v4;
create or replace view aggJoin6571890323202387885 as select annot from Person_knows_Person as pkp3, aggView4980172411457801036 where pkp3.Person1Id=aggView4980172411457801036.v4;
select SUM(annot) as v9 from aggJoin6571890323202387885;
