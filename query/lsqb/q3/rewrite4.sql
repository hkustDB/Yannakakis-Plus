
##Reduce Phase: 

# Reduce8
# 0. Prepare
create or replace view bag866 as select PersonA.PersonId as v13, CityA.isPartOf_CountryId as v4, CityA.CityId as v8 from City as CityA, Person as PersonA where CityA.CityId=PersonA.isLocatedIn_CityId;
create or replace view bag865 as select CityB.CityId as v10, pkp1.Person1Id as v13, PersonB.PersonId as v14, pkp2.Person2Id as v16, CityB.isPartOf_CountryId as v4 from City as CityB, Person as PersonB, Person_knows_Person as pkp1, Person_knows_Person as pkp2, Person_knows_Person as pkp3 where CityB.CityId=PersonB.isLocatedIn_CityId and PersonB.PersonId=pkp1.Person2Id and pkp1.Person2Id=pkp2.Person1Id and pkp2.Person2Id=pkp3.Person1Id;
# +. SemiJoin
create or replace view semiJoinView2490223390810793343 as select v13, v16, v4 from bag865 where (v13, v4) in (select v13, v4 from bag866);

# Reduce9
# 0. Prepare
create or replace view bag864 as select CityC.CityId as v12, PersonC.PersonId as v16, CityC.isPartOf_CountryId as v4 from City as CityC, Person as PersonC where CityC.CityId=PersonC.isLocatedIn_CityId;
# +. SemiJoin
create or replace view semiJoinView2394411632608645827 as select v16, v4 from bag864 where (v16, v4) in (select v16, v4 from semiJoinView2490223390810793343);

## Enumerate Phase: 

# Enumerate8
# +. SemiEnumerate
create or replace view semiEnum7740006805369916974 as select v4, v13 from semiJoinView2394411632608645827 join semiJoinView2490223390810793343 using(v16, v4);

# Enumerate9
# +. SemiEnumerate
create or replace view semiEnum5354724624237431260 as select  from semiEnum7740006805369916974 join bag866 using(v13, v4);
# Final result: 
select COUNT(v19) as v19 from semiEnum5354724624237431260 group by ;

# drop view bag866, bag865, semiJoinView2490223390810793343, bag864, semiJoinView2394411632608645827, semiEnum7740006805369916974, semiEnum5354724624237431260;
