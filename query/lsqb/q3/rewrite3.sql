create or replace view bag674 as select CityB.CityId as v10, PersonB.PersonId as v14, CityB.isPartOf_CountryId as v4 from City as CityB, Person as PersonB where CityB.CityId=PersonB.isLocatedIn_CityId;
create or replace view bag673 as select CityC.CityId as v12, pkp1.Person1Id as v13, pkp1.Person2Id as v14, PersonC.PersonId as v16, CityC.isPartOf_CountryId as v4 from City as CityC, Person as PersonC, Person_knows_Person as pkp1, Person_knows_Person as pkp2, Person_knows_Person as pkp3 where CityC.CityId=PersonC.isLocatedIn_CityId and pkp1.Person2Id=pkp2.Person1Id and pkp2.Person2Id=pkp3.Person1Id;
create or replace view semiJoinView528913966665547803 as select v13, v14, v4 from bag673 where (v4, v14) in (select v4, v14 from bag674);
create or replace view bag672 as select PersonA.PersonId as v13, CityA.isPartOf_CountryId as v4, CityA.CityId as v8 from City as CityA, Person as PersonA where CityA.CityId=PersonA.isLocatedIn_CityId;
create or replace view semiJoinView1089132190131443162 as select v13, v4 from bag672 where (v13, v4) in (select v13, v4 from semiJoinView528913966665547803);
create or replace view semiEnum2633882173758843133 as select v14, v4 from semiJoinView1089132190131443162 join semiJoinView528913966665547803 using(v13, v4);
create or replace view semiEnum2316954565783775050 as select  from semiEnum2633882173758843133 join bag674 using(v4, v14);
select COUNT(v19) as v19 from semiEnum2316954565783775050 group by ;
