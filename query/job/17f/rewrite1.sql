create or replace view aggJoin8964564362288564224 as (
with aggView2003076750598405412 as (select id as v3 from title as t)
select person_id as v26, movie_id as v3 from cast_info as ci, aggView2003076750598405412 where ci.movie_id=aggView2003076750598405412.v3);
create or replace view aggJoin4658610502571083420 as (
with aggView4982143224718753324 as (select id as v25 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v3 from movie_keyword as mk, aggView4982143224718753324 where mk.keyword_id=aggView4982143224718753324.v25);
create or replace view aggJoin7436930086521085308 as (
with aggView7202434944589205364 as (select v3 from aggJoin4658610502571083420 group by v3)
select movie_id as v3, company_id as v20 from movie_companies as mc, aggView7202434944589205364 where mc.movie_id=aggView7202434944589205364.v3);
create or replace view aggJoin5354206393399567480 as (
with aggView2242295555548228059 as (select id as v20 from company_name as cn)
select v3 from aggJoin7436930086521085308 join aggView2242295555548228059 using(v20));
create or replace view aggJoin1730218844978691332 as (
with aggView7632228878925028386 as (select v3 from aggJoin5354206393399567480 group by v3)
select v26 from aggJoin8964564362288564224 join aggView7632228878925028386 using(v3));
create or replace view aggJoin7402073867515547979 as (
with aggView2943470091247726150 as (select v26 from aggJoin1730218844978691332 group by v26)
select name as v27 from name as n, aggView2943470091247726150 where n.id=aggView2943470091247726150.v26 and name LIKE '%B%');
create or replace view aggView3559534441661995271 as select v27 from aggJoin7402073867515547979 group by v27;
select MIN(v27) as v47 from aggView3559534441661995271;
