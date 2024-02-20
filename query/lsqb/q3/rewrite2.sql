
##Reduce Phase: 

# Reduce4
# 0. Prepare
create or replace view bag860 as select CityB.CityId as v10, PersonB.PersonId as v14, CityB.isPartOf_CountryId as v4 from City as CityB, Person as PersonB where CityB.CityId=PersonB.isLocatedIn_CityId;
create or replace view bag859 as select PersonA.PersonId as v13, pkp1.Person2Id as v14, pkp2.Person2Id as v16, CityA.isPartOf_CountryId as v4, CityA.CityId as v8 from City as CityA, Person as PersonA, Person_knows_Person as pkp1, Person_knows_Person as pkp2, Person_knows_Person as pkp3 where CityA.CityId=PersonA.isLocatedIn_CityId and PersonA.PersonId=pkp1.Person1Id and pkp1.Person2Id=pkp2.Person1Id and pkp2.Person2Id=pkp3.Person1Id;
# +. SemiJoin
create or replace view semiJoinView7715406640099064589 as select v14, v16, v4 from bag859 where (v14, v4) in (select v14, v4 from bag860);

# Reduce5
# 0. Prepare
create or replace view bag858 as select CityC.CityId as v12, PersonC.PersonId as v16, CityC.isPartOf_CountryId as v4 from City as CityC, Person as PersonC where CityC.CityId=PersonC.isLocatedIn_CityId;
# +. SemiJoin
create or replace view semiJoinView1040331431220535106 as select v16, v4 from bag858 where (v16, v4) in (select v16, v4 from semiJoinView7715406640099064589);

## Enumerate Phase: 

# Enumerate4
# +. SemiEnumerate
create or replace view semiEnum2031165594971961013 as select v4, v14 from semiJoinView1040331431220535106 join semiJoinView7715406640099064589 using(v16, v4);

# Enumerate5
# +. SemiEnumerate
create or replace view semiEnum5788695274396079470 as select  from semiEnum2031165594971961013 join bag860 using(v14, v4);
# Final result: 
select COUNT(v19) as v19 from semiEnum5788695274396079470 group by ;

# drop view bag860, bag859, semiJoinView7715406640099064589, bag858, semiJoinView1040331431220535106, semiEnum2031165594971961013, semiEnum5788695274396079470;
