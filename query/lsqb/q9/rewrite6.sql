create or replace view aggView2016221110736943856 as select PersonId as v4, COUNT(*) as annot from Person_hasInterest_Tag as Person_hasInterest_Tag group by PersonId;
create or replace view aggJoin2896766089476116290 as select Person1Id as v4, annot from Person_knows_Person as pkp3, aggView2016221110736943856 where pkp3.Person1Id=aggView2016221110736943856.v4;
create or replace view aggView2990481328214274503 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
create or replace view aggJoin2901513150305454108 as select Person2Id as v4, annot from Person_knows_Person as pkp2, aggView2990481328214274503 where pkp2.Person1Id=aggView2990481328214274503.v2 and v1<Person2Id;
create or replace view aggView2724327023351321021 as select v4, SUM(annot) as annot from aggJoin2901513150305454108 group by v4;
create or replace view aggJoin3116150537201240696 as select aggJoin2896766089476116290.annot * aggView2724327023351321021.annot as annot from aggJoin2896766089476116290 join aggView2724327023351321021 using(v4);
select SUM(annot) as v9 from aggJoin3116150537201240696;
