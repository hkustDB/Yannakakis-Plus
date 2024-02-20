
##Reduce Phase: 

# Reduce0
# 0. Prepare
create or replace view bag854 as select CityC.CityId as v12, PersonC.PersonId as v16, CityC.isPartOf_CountryId as v4 from City as CityC, Person as PersonC where CityC.CityId=PersonC.isLocatedIn_CityId;
create or replace view bag853 as select CityB.CityId as v10, pkp1.Person1Id as v13, PersonB.PersonId as v14, pkp2.Person2Id as v16, CityB.isPartOf_CountryId as v4 from City as CityB, Person as PersonB, Person_knows_Person as pkp1, Person_knows_Person as pkp2, Person_knows_Person as pkp3 where CityB.CityId=PersonB.isLocatedIn_CityId and PersonB.PersonId=pkp1.Person2Id and pkp1.Person2Id=pkp2.Person1Id and pkp2.Person2Id=pkp3.Person1Id;
# +. SemiJoin
create or replace view semiJoinView6656388559595121350 as select v13, v16, v4 from bag853 where (v16, v4) in (select v16, v4 from bag854);

# Reduce1
# 0. Prepare
create or replace view bag852 as select PersonA.PersonId as v13, CityA.isPartOf_CountryId as v4, CityA.CityId as v8 from City as CityA, Person as PersonA where CityA.CityId=PersonA.isLocatedIn_CityId;
# +. SemiJoin
create or replace view semiJoinView6876899830514201885 as select v13, v4 from bag852 where (v13, v4) in (select v13, v4 from semiJoinView6656388559595121350);

## Enumerate Phase: 

# Enumerate0
# +. SemiEnumerate
create or replace view semiEnum4950919228760193726 as select v16, v4 from semiJoinView6876899830514201885 join semiJoinView6656388559595121350 using(v13, v4);

# Enumerate1
# +. SemiEnumerate
create or replace view semiEnum8760677224068876323 as select  from semiEnum4950919228760193726 join bag854 using(v16, v4);
# Final result: 
select COUNT(v19) as v19 from semiEnum8760677224068876323 group by ;

# drop view bag854, bag853, semiJoinView6656388559595121350, bag852, semiJoinView6876899830514201885, semiEnum4950919228760193726, semiEnum8760677224068876323;
