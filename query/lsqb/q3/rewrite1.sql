
##Reduce Phase: 

# Reduce2
# 0. Prepare
create or replace view bag857 as select CityC.CityId as v12, PersonC.PersonId as v16, CityC.isPartOf_CountryId as v4 from City as CityC, Person as PersonC where CityC.CityId=PersonC.isLocatedIn_CityId;
create or replace view bag856 as select PersonA.PersonId as v13, pkp1.Person2Id as v14, pkp2.Person2Id as v16, CityA.isPartOf_CountryId as v4, CityA.CityId as v8 from City as CityA, Person as PersonA, Person_knows_Person as pkp1, Person_knows_Person as pkp2, Person_knows_Person as pkp3 where CityA.CityId=PersonA.isLocatedIn_CityId and PersonA.PersonId=pkp1.Person1Id and pkp1.Person2Id=pkp2.Person1Id and pkp2.Person2Id=pkp3.Person1Id;
# +. SemiJoin
create or replace view semiJoinView4861419769249048060 as select v14, v16, v4 from bag856 where (v16, v4) in (select v16, v4 from bag857);

# Reduce3
# 0. Prepare
create or replace view bag855 as select CityB.CityId as v10, PersonB.PersonId as v14, CityB.isPartOf_CountryId as v4 from City as CityB, Person as PersonB where CityB.CityId=PersonB.isLocatedIn_CityId;
# +. SemiJoin
create or replace view semiJoinView8741662401709106696 as select v14, v4 from bag855 where (v14, v4) in (select v14, v4 from semiJoinView4861419769249048060);

## Enumerate Phase: 

# Enumerate2
# +. SemiEnumerate
create or replace view semiEnum1706969062564545274 as select v16, v4 from semiJoinView8741662401709106696 join semiJoinView4861419769249048060 using(v14, v4);

# Enumerate3
# +. SemiEnumerate
create or replace view semiEnum3245536036863875025 as select  from semiEnum1706969062564545274 join bag857 using(v16, v4);
# Final result: 
select COUNT(v19) as v19 from semiEnum3245536036863875025 group by ;

# drop view bag857, bag856, semiJoinView4861419769249048060, bag855, semiJoinView8741662401709106696, semiEnum1706969062564545274, semiEnum3245536036863875025;
