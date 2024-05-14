create or replace view aggView4808252816452629832 as select Person1Id as v4, COUNT(*) as annot from Person_knows_Person as pkp3 group by Person1Id;
create or replace view aggJoin7591339070058033191 as select PersonId as v4, annot from Person_hasInterest_Tag as Person_hasInterest_Tag, aggView4808252816452629832 where Person_hasInterest_Tag.PersonId=aggView4808252816452629832.v4;
create or replace view aggView9080290375427004121 as select Person2Id as v2, COUNT(*) as annot, Person1Id as v1 from Person_knows_Person as pkp1 group by Person2Id,Person1Id;
create or replace view aggJoin1064582889947280138 as select Person2Id as v4, v1, annot from Person_knows_Person as pkp2, aggView9080290375427004121 where pkp2.Person1Id=aggView9080290375427004121.v2 and v1<Person2Id;
create or replace view aggView2199047390259944605 as select v4, SUM(annot) as annot from aggJoin1064582889947280138 group by v4;
create or replace view aggJoin814635292345607663 as select v4, aggJoin7591339070058033191.annot * aggView2199047390259944605.annot as annot from aggJoin7591339070058033191 join aggView2199047390259944605 using(v4);
select SUM(annot) as v9 from aggJoin814635292345607663;
