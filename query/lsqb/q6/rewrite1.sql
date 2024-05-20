create or replace view aggView4957457414589280924 as select PersonId as v5, COUNT(*) as annot from Person_hasInterest_Tag as Person_hasInterest_Tag group by PersonId;
create or replace view aggJoin7026965550707931238 as select Person1Id as v2, Person2Id as v5, annot from Person_knows_Person as pkp2, aggView4957457414589280924 where pkp2.Person2Id=aggView4957457414589280924.v5;
create or replace view aggView2991749768286744492 as select v2, SUM(annot) as annot, v5 from aggJoin7026965550707931238 group by v2,v5;
create or replace view aggJoin4444158527331738780 as select Person1Id as v1, v5, annot from Person_knows_Person as pkp1, aggView2991749768286744492 where pkp1.Person2Id=aggView2991749768286744492.v2 and Person1Id<v5;
select SUM(annot) as v7 from aggJoin4444158527331738780;
