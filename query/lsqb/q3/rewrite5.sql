create or replace view bag680 as select PersonA.PersonId as v13, CityA.isPartOf_CountryId as v4 from City as CityA, Person as PersonA where CityA.CityId=PersonA.isLocatedIn_CityId;
create or replace view bag679 as select pkp1.Person1Id as v13, pkp1.Person2Id as v14, CityC.isPartOf_CountryId as v4 from City as CityC, Person as PersonC, Person_knows_Person as pkp1, Person_knows_Person as pkp2, Person_knows_Person as pkp3 where CityC.CityId=PersonC.isLocatedIn_CityId and pkp1.Person2Id=pkp2.Person1Id and pkp2.Person2Id=pkp3.Person1Id;
create or replace view semiJoinView8819173214590886562 as select v13, v14, v4 from bag679 where (v13, v4) in (select (v13, v4) from bag680);
create or replace view bag678 as select PersonB.PersonId as v14, CityB.isPartOf_CountryId as v4 from City as CityB, Person as PersonB where CityB.CityId=PersonB.isLocatedIn_CityId;
create or replace view semiJoinView7694825058163917151 as select v14, v4 from bag678 where (v4, v14) in (select (v4, v14) from semiJoinView8819173214590886562);
create or replace view semiEnum6587047110419425206 as select v13, v4, count(*) as annot from semiJoinView7694825058163917151 join semiJoinView8819173214590886562 using(v4, v14) group by (v13, v4);
select sum(annot) from semiEnum6587047110419425206 join bag680 using(v13, v4);
