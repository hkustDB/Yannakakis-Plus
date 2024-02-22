create or replace view aggView8771824763226982966 as select Person1Id as v4, COUNT(*) as annot from Person_knows_Person as pkp3 group by Person1Id;
create or replace view aggJoin1907124085301756077 as select Person1Id as v2, Person2Id as v4, annot from Person_knows_Person as pkp2, aggView8771824763226982966 where pkp2.Person2Id=aggView8771824763226982966.v4;
create or replace view aggView4621945013173778929 as select PersonId as v4, COUNT(*) as annot from Person_hasInterest_Tag as Person_hasInterest_Tag group by PersonId;
create or replace view aggJoin2679577319993442155 as select v2, v4, aggJoin1907124085301756077.annot * aggView4621945013173778929.annot as annot from aggJoin1907124085301756077 join aggView4621945013173778929 using(v4);
create or replace view aggView8015789045393276642 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
create or replace view aggJoin4079194653513324755 as select aggJoin2679577319993442155.annot * aggView8015789045393276642.annot as annot from aggJoin2679577319993442155 join aggView8015789045393276642 using(v2) where v1 < v4;
select SUM(annot) as v9 from aggJoin4079194653513324755;
