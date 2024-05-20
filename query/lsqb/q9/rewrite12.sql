create or replace view aggView3125993302036173874 as select Person1Id as v4, COUNT(*) as annot from Person_knows_Person as pkp3 group by Person1Id;
create or replace view aggJoin1273513611520041029 as select PersonId as v4, annot from Person_hasInterest_Tag as Person_hasInterest_Tag, aggView3125993302036173874 where Person_hasInterest_Tag.PersonId=aggView3125993302036173874.v4;
create or replace view aggView6370359608810151704 as select v4, SUM(annot) as annot from aggJoin1273513611520041029 group by v4;
create or replace view aggJoin8699339352820720923 as select Person1Id as v2, Person2Id as v4, annot from Person_knows_Person as pkp2, aggView6370359608810151704 where pkp2.Person2Id=aggView6370359608810151704.v4;
create or replace view aggView6566540404678910513 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
create or replace view aggJoin6080795601208929798 as select v4, aggJoin8699339352820720923.annot * aggView6566540404678910513.annot as annot, v1 from aggJoin8699339352820720923 join aggView6566540404678910513 using(v2) where v1 < v4;
select SUM(annot) as v9 from aggJoin6080795601208929798;
