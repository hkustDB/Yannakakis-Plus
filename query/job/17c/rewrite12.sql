create or replace view aggJoin5683665487337787022 as (
with aggView7387434352841473656 as (select id as v26, name as v47 from name as n where name LIKE 'X%')
select movie_id as v3, v47 from cast_info as ci, aggView7387434352841473656 where ci.person_id=aggView7387434352841473656.v26);
create or replace view aggJoin5637648611808308406 as (
with aggView7535908096134179785 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView7535908096134179785 where mk.keyword_id=aggView7535908096134179785.v25);
create or replace view aggJoin7447715286360830039 as (
with aggView1678580774211105227 as (select id as v20 from company_name as cn)
select movie_id as v3 from movie_companies as mc, aggView1678580774211105227 where mc.company_id=aggView1678580774211105227.v20);
create or replace view aggJoin5526342726520396287 as (
with aggView5979725057026720752 as (select id as v3 from title as t)
select v3 from aggJoin5637648611808308406 join aggView5979725057026720752 using(v3));
create or replace view aggJoin3105880697010298475 as (
with aggView5795358185874883891 as (select v3 from aggJoin5526342726520396287 group by v3)
select v3 from aggJoin7447715286360830039 join aggView5795358185874883891 using(v3));
create or replace view aggJoin5573227965042393123 as (
with aggView7128148387798808081 as (select v3 from aggJoin3105880697010298475 group by v3)
select v47 as v47 from aggJoin5683665487337787022 join aggView7128148387798808081 using(v3));
select MIN(v47) as v47 from aggJoin5573227965042393123;
