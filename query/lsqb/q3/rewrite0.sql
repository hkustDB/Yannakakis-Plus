create or replace view bag665 as select CityC.CityId as v12, PersonC.PersonId as v16, CityC.isPartOf_CountryId as v4 from City as CityC, Person as PersonC where CityC.CityId=PersonC.isLocatedIn_CityId;
create or replace view bag664 as select PersonA.PersonId as v13, pkp1.Person2Id as v14, pkp2.Person2Id as v16, CityA.isPartOf_CountryId as v4, CityA.CityId as v8 from City as CityA, Person as PersonA, Person_knows_Person as pkp1, Person_knows_Person as pkp2, Person_knows_Person as pkp3 where CityA.CityId=PersonA.isLocatedIn_CityId and PersonA.PersonId=pkp1.Person1Id and pkp1.Person2Id=pkp2.Person1Id and pkp2.Person2Id=pkp3.Person1Id;
create or replace view semiJoinView1138372543856337821 as select v14, v16, v4 from bag664 where (v16, v4) in (select v16, v4 from bag665);
create or replace view bag663 as select CityB.CityId as v10, PersonB.PersonId as v14, CityB.isPartOf_CountryId as v4 from City as CityB, Person as PersonB where CityB.CityId=PersonB.isLocatedIn_CityId;
create or replace view semiJoinView346066695289826482 as select v14, v4 from bag663 where (v4, v14) in (select v4, v14 from semiJoinView1138372543856337821);
create or replace view semiEnum4726413724319691367 as select v16, v4 from semiJoinView346066695289826482 join semiJoinView1138372543856337821 using(v4, v14);
create or replace view semiEnum4388548182336884774 as select  from semiEnum4726413724319691367 join bag665 using(v16, v4);
select COUNT(v19) as v19 from semiEnum4388548182336884774 group by ;
