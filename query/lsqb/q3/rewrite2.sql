create or replace view bag671 as select PersonB.PersonId as v14, CityB.isPartOf_CountryId as v4 from City as CityB, Person as PersonB where CityB.CityId=PersonB.isLocatedIn_CityId;
create or replace view bag670 as select pkp1.Person2Id as v14, pkp2.Person2Id as v16, CityA.isPartOf_CountryId as v4 from City as CityA, Person as PersonA, Person_knows_Person as pkp1, Person_knows_Person as pkp2, Person_knows_Person as pkp3 where CityA.CityId=PersonA.isLocatedIn_CityId and PersonA.PersonId=pkp1.Person1Id and pkp1.Person2Id=pkp2.Person1Id and pkp2.Person2Id=pkp3.Person1Id;
create or replace view semiJoinView4282455637121576178 as select v14, v16, v4 from bag670 where (v4, v14) in (select (v4, v14) from bag671);
create or replace view bag669 as select PersonC.PersonId as v16, CityC.isPartOf_CountryId as v4 from City as CityC, Person as PersonC where CityC.CityId=PersonC.isLocatedIn_CityId;
create or replace view semiJoinView7774163318782003271 as select v16, v4 from bag669 where (v16, v4) in (select (v16, v4) from semiJoinView4282455637121576178);
create or replace view semiEnum8759680764680119358 as select v14, v4, count(*) as annot from semiJoinView7774163318782003271 join semiJoinView4282455637121576178 using(v16, v4) group by (v14, v4);
select sum(annot) from semiEnum8759680764680119358 join bag671 using(v4, v14);
