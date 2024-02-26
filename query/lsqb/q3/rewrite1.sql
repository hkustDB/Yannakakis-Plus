create or replace view bag668 as select PersonC.PersonId as v16, CityC.isPartOf_CountryId as v4 from City as CityC, Person as PersonC where CityC.CityId=PersonC.isLocatedIn_CityId;
create or replace view bag667 as select pkp1.Person1Id as v13, pkp2.Person2Id as v16, CityB.isPartOf_CountryId as v4 from City as CityB, Person as PersonB, Person_knows_Person as pkp1, Person_knows_Person as pkp2, Person_knows_Person as pkp3 where CityB.CityId=PersonB.isLocatedIn_CityId and PersonB.PersonId=pkp1.Person2Id and pkp1.Person2Id=pkp2.Person1Id and pkp2.Person2Id=pkp3.Person1Id;
create or replace view semiJoinView2073590133286305857 as select v13, v16, v4 from bag667 where (v16, v4) in (select (v16, v4) from bag668);
create or replace view bag666 as select PersonA.PersonId as v13, CityA.isPartOf_CountryId as v4 from City as CityA, Person as PersonA where CityA.CityId=PersonA.isLocatedIn_CityId;
create or replace view semiJoinView7390594292617311732 as select v13, v4 from bag666 where (v13, v4) in (select (v13, v4) from semiJoinView2073590133286305857);
create or replace view semiEnum3944110065189649605 as select v16, v4, count(*) as annot from semiJoinView7390594292617311732 join semiJoinView2073590133286305857 using(v13, v4) group by (v16, v4);
select sum(annot) from semiEnum3944110065189649605 join bag668 using(v16, v4);
