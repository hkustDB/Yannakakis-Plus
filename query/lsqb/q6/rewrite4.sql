create or replace view aggView2053056463808884570 as select PersonId as v5, COUNT(*) as annot from Person_hasInterest_Tag as Person_hasInterest_Tag group by PersonId;
create or replace view aggJoin7164468120740622407 as select Person1Id as v2, Person2Id as v5, annot from Person_knows_Person as pkp2, aggView2053056463808884570 where pkp2.Person2Id=aggView2053056463808884570.v5;
create or replace view aggView1316897431042499384 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
create or replace view aggJoin6132896051371865290 as select aggJoin7164468120740622407.annot * aggView1316897431042499384.annot as annot from aggJoin7164468120740622407 join aggView1316897431042499384 using(v2) where v1 < v5;
select SUM(annot) as v7 from aggJoin6132896051371865290;
