create or replace view bag671 as select CityB.CityId as v10, PersonB.PersonId as v14, CityB.isPartOf_CountryId as v4 from City as CityB, Person as PersonB where CityB.CityId=PersonB.isLocatedIn_CityId;
create or replace view bag670 as select PersonA.PersonId as v13, pkp1.Person2Id as v14, pkp2.Person2Id as v16, CityA.isPartOf_CountryId as v4, CityA.CityId as v8 from City as CityA, Person as PersonA, Person_knows_Person as pkp1, Person_knows_Person as pkp2, Person_knows_Person as pkp3 where CityA.CityId=PersonA.isLocatedIn_CityId and PersonA.PersonId=pkp1.Person1Id and pkp1.Person2Id=pkp2.Person1Id and pkp2.Person2Id=pkp3.Person1Id;
create or replace view semiJoinView4282455637121576178 as select v14, v16, v4 from bag670 where (v4, v14) in (select v4, v14 from bag671);
create or replace view bag669 as select CityC.CityId as v12, PersonC.PersonId as v16, CityC.isPartOf_CountryId as v4 from City as CityC, Person as PersonC where CityC.CityId=PersonC.isLocatedIn_CityId;
create or replace view semiJoinView7774163318782003271 as select v16, v4 from bag669 where (v16, v4) in (select v16, v4 from semiJoinView4282455637121576178);
create or replace view semiEnum8759680764680119358 as select v14, v4 from semiJoinView7774163318782003271 join semiJoinView4282455637121576178 using(v16, v4);
create or replace view semiEnum2684903872384553399 as select  from semiEnum8759680764680119358 join bag671 using(v4, v14);
select COUNT(v19) as v19 from semiEnum2684903872384553399 group by ;
