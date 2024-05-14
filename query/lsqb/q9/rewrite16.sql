create or replace view aggView4424973919776697878 as select PersonId as v4, COUNT(*) as annot from Person_hasInterest_Tag as Person_hasInterest_Tag group by PersonId;
create or replace view aggJoin5702795058042871152 as select Person1Id as v4, annot from Person_knows_Person as pkp3, aggView4424973919776697878 where pkp3.Person1Id=aggView4424973919776697878.v4;
create or replace view aggView4474095100293061882 as select v4, SUM(annot) as annot from aggJoin5702795058042871152 group by v4;
create or replace view aggJoin3857407202955581909 as select Person1Id as v2, Person2Id as v4, annot from Person_knows_Person as pkp2, aggView4474095100293061882 where pkp2.Person2Id=aggView4474095100293061882.v4;
create or replace view aggView1162224654486667270 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
create or replace view aggJoin2013685950888197671 as select aggJoin3857407202955581909.annot * aggView1162224654486667270.annot as annot from aggJoin3857407202955581909 join aggView1162224654486667270 using(v2) where v1 < v4;
select SUM(annot) as v9 from aggJoin2013685950888197671;
