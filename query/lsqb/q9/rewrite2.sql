create or replace view aggView8594773449693900794 as select Person1Id as v4, COUNT(*) as annot from Person_knows_Person as pkp3 group by Person1Id;
create or replace view aggJoin2991482733577280989 as select PersonId as v4, annot from Person_hasInterest_Tag as Person_hasInterest_Tag, aggView8594773449693900794 where Person_hasInterest_Tag.PersonId=aggView8594773449693900794.v4;
create or replace view aggView342228640842324938 as select v4, SUM(annot) as annot from aggJoin2991482733577280989 group by v4;
create or replace view aggJoin8888306619318308639 as select Person1Id as v2, Person2Id as v4, annot from Person_knows_Person as pkp2, aggView342228640842324938 where pkp2.Person2Id=aggView342228640842324938.v4;
create or replace view aggView2700914455146285645 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
create or replace view aggJoin5587284304550271475 as select aggJoin8888306619318308639.annot * aggView2700914455146285645.annot as annot from aggJoin8888306619318308639 join aggView2700914455146285645 using(v2) where v1 < v4;
select SUM(annot) as v9 from aggJoin5587284304550271475;
