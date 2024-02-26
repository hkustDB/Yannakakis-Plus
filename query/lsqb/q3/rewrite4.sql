create or replace view bag677 as select PersonA.PersonId as v13, CityA.isPartOf_CountryId as v4 from City as CityA, Person as PersonA where CityA.CityId=PersonA.isLocatedIn_CityId;
create or replace view bag676 as select CityB.CityId as v10, pkp1.Person1Id as v13, PersonB.PersonId as v14, pkp2.Person2Id as v16, CityB.isPartOf_CountryId as v4 from City as CityB, Person as PersonB, Person_knows_Person as pkp1, Person_knows_Person as pkp2, Person_knows_Person as pkp3 where CityB.CityId=PersonB.isLocatedIn_CityId and PersonB.PersonId=pkp1.Person2Id and pkp1.Person2Id=pkp2.Person1Id and pkp2.Person2Id=pkp3.Person1Id;
create or replace view semiJoinView7961751725273341843 as select v13, v16, v4 from bag676 where (v13, v4) in (select (v13, v4) from bag677);
create or replace view bag675 as select PersonC.PersonId as v16, CityC.isPartOf_CountryId as v4 from City as CityC, Person as PersonC where CityC.CityId=PersonC.isLocatedIn_CityId;
create or replace view semiJoinView7696364890517298932 as select v16, v4 from bag675 where (v16, v4) in (select (v16, v4) from semiJoinView7961751725273341843);
create or replace view semiEnum4600253541921895445 as select v13, v4, count(*) as annot from semiJoinView7696364890517298932 join semiJoinView7961751725273341843 using(v16, v4) group by (v13, v4);
select sum(annot) from semiEnum4600253541921895445 join bag677 using(v13, v4);
