create or replace view aggJoin8303305003091030352 as (
with aggView3368331664542809997 as (select id as v20 from company_name as cn where country_code= '[us]')
select movie_id as v3 from movie_companies as mc, aggView3368331664542809997 where mc.company_id=aggView3368331664542809997.v20);
create or replace view aggJoin3605081384721615474 as (
with aggView6870997516692156990 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView6870997516692156990 where mk.keyword_id=aggView6870997516692156990.v25);
create or replace view aggJoin186041522340517899 as (
with aggView6883125671457616807 as (select v3 from aggJoin8303305003091030352 group by v3)
select id as v3 from title as t, aggView6883125671457616807 where t.id=aggView6883125671457616807.v3);
create or replace view aggJoin9038778135193395622 as (
with aggView1856768778032879156 as (select v3 from aggJoin186041522340517899 group by v3)
select v3 from aggJoin3605081384721615474 join aggView1856768778032879156 using(v3));
create or replace view aggJoin3798724438703633520 as (
with aggView7221682026525514319 as (select v3 from aggJoin9038778135193395622 group by v3)
select person_id as v26 from cast_info as ci, aggView7221682026525514319 where ci.movie_id=aggView7221682026525514319.v3);
create or replace view aggJoin3513645370698765809 as (
with aggView6690521781352080105 as (select v26 from aggJoin3798724438703633520 group by v26)
select name as v27 from name as n, aggView6690521781352080105 where n.id=aggView6690521781352080105.v26 and name LIKE 'B%');
create or replace view aggView3814158312938915465 as select v27 from aggJoin3513645370698765809 group by v27;
select MIN(v27) as v47 from aggView3814158312938915465;
