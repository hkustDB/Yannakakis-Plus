create or replace view aggView1605599691926646806 as select title as v44, id as v11 from title as t;
create or replace view aggJoin506895733304228985 as (
with aggView6518962719496735384 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView6518962719496735384 where an.person_id=aggView6518962719496735384.v2);
create or replace view aggView8733520932720464151 as select v3, v2 from aggJoin506895733304228985 group by v3,v2;
create or replace view aggJoin4750887405477595751 as (
with aggView4018922862746670130 as (select v11, MIN(v44) as v56 from aggView1605599691926646806 group by v11)
select person_id as v2, movie_id as v11, v56 from cast_info as ci, aggView4018922862746670130 where ci.movie_id=aggView4018922862746670130.v11);
create or replace view aggJoin4955116652399230184 as (
with aggView3760529249431457265 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView3760529249431457265 where mc.company_id=aggView3760529249431457265.v28);
create or replace view aggJoin6240883703508769760 as (
with aggView6396626090969791298 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView6396626090969791298 where mk.keyword_id=aggView6396626090969791298.v33);
create or replace view aggJoin421084738531814974 as (
with aggView9170657564109613575 as (select v11 from aggJoin6240883703508769760 group by v11)
select v2, v11, v56 as v56 from aggJoin4750887405477595751 join aggView9170657564109613575 using(v11));
create or replace view aggJoin2372476786969832811 as (
with aggView403979961902925482 as (select v11 from aggJoin4955116652399230184 group by v11)
select v2, v56 as v56 from aggJoin421084738531814974 join aggView403979961902925482 using(v11));
create or replace view aggJoin1296414785207724434 as (
with aggView1240043207775249914 as (select v2, MIN(v56) as v56 from aggJoin2372476786969832811 group by v2,v56)
select v3, v56 from aggView8733520932720464151 join aggView1240043207775249914 using(v2));
select MIN(v3) as v55,MIN(v56) as v56 from aggJoin1296414785207724434;
