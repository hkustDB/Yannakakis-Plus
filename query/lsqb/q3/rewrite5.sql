
##Reduce Phase: 

# Reduce10
# 0. Prepare
create or replace view bag869 as select CityB.CityId as v10, PersonB.PersonId as v14, CityB.isPartOf_CountryId as v4 from City as CityB, Person as PersonB where CityB.CityId=PersonB.isLocatedIn_CityId;
create or replace view bag868 as select CityC.CityId as v12, pkp1.Person1Id as v13, pkp1.Person2Id as v14, PersonC.PersonId as v16, CityC.isPartOf_CountryId as v4 from City as CityC, Person as PersonC, Person_knows_Person as pkp1, Person_knows_Person as pkp2, Person_knows_Person as pkp3 where CityC.CityId=PersonC.isLocatedIn_CityId and pkp1.Person2Id=pkp2.Person1Id and pkp2.Person2Id=pkp3.Person1Id;
# +. SemiJoin
create or replace view semiJoinView7088831985441022963 as select v13, v14, v4 from bag868 where (v14, v4) in (select v14, v4 from bag869);

# Reduce11
# 0. Prepare
create or replace view bag867 as select PersonA.PersonId as v13, CityA.isPartOf_CountryId as v4, CityA.CityId as v8 from City as CityA, Person as PersonA where CityA.CityId=PersonA.isLocatedIn_CityId;
# +. SemiJoin
create or replace view semiJoinView7716297501419442195 as select v13, v4 from bag867 where (v13, v4) in (select v13, v4 from semiJoinView7088831985441022963);

## Enumerate Phase: 

# Enumerate10
# +. SemiEnumerate
create or replace view semiEnum4666956724699465006 as select v4, v14 from semiJoinView7716297501419442195 join semiJoinView7088831985441022963 using(v13, v4);

# Enumerate11
# +. SemiEnumerate
create or replace view semiEnum8597986185521440446 as select  from semiEnum4666956724699465006 join bag869 using(v14, v4);
# Final result: 
select COUNT(v19) as v19 from semiEnum8597986185521440446 group by ;

# drop view bag869, bag868, semiJoinView7088831985441022963, bag867, semiJoinView7716297501419442195, semiEnum4666956724699465006, semiEnum8597986185521440446;
