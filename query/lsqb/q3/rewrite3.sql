
##Reduce Phase: 

# Reduce6
# 0. Prepare
create or replace view bag863 as select PersonA.PersonId as v13, CityA.isPartOf_CountryId as v4, CityA.CityId as v8 from City as CityA, Person as PersonA where CityA.CityId=PersonA.isLocatedIn_CityId;
create or replace view bag862 as select CityC.CityId as v12, pkp1.Person1Id as v13, pkp1.Person2Id as v14, PersonC.PersonId as v16, CityC.isPartOf_CountryId as v4 from City as CityC, Person as PersonC, Person_knows_Person as pkp1, Person_knows_Person as pkp2, Person_knows_Person as pkp3 where CityC.CityId=PersonC.isLocatedIn_CityId and pkp1.Person2Id=pkp2.Person1Id and pkp2.Person2Id=pkp3.Person1Id;
# +. SemiJoin
create or replace view semiJoinView7481123424601422066 as select v13, v14, v4 from bag862 where (v13, v4) in (select v13, v4 from bag863);

# Reduce7
# 0. Prepare
create or replace view bag861 as select CityB.CityId as v10, PersonB.PersonId as v14, CityB.isPartOf_CountryId as v4 from City as CityB, Person as PersonB where CityB.CityId=PersonB.isLocatedIn_CityId;
# +. SemiJoin
create or replace view semiJoinView5308948420978573658 as select v14, v4 from bag861 where (v14, v4) in (select v14, v4 from semiJoinView7481123424601422066);

## Enumerate Phase: 

# Enumerate6
# +. SemiEnumerate
create or replace view semiEnum818801082169437788 as select v4, v13 from semiJoinView5308948420978573658 join semiJoinView7481123424601422066 using(v14, v4);

# Enumerate7
# +. SemiEnumerate
create or replace view semiEnum6280284368866449489 as select  from semiEnum818801082169437788 join bag863 using(v13, v4);
# Final result: 
select COUNT(v19) as v19 from semiEnum6280284368866449489 group by ;

# drop view bag863, bag862, semiJoinView7481123424601422066, bag861, semiJoinView5308948420978573658, semiEnum818801082169437788, semiEnum6280284368866449489;
