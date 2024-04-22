create or replace view aggView6957309221231831161 as select title as v44, id as v11 from title as t;
create or replace view aggJoin8739554129363317071 as (
with aggView2850806480889920964 as (select id as v2 from name as n)
select person_id as v2, name as v3 from aka_name as an, aggView2850806480889920964 where an.person_id=aggView2850806480889920964.v2);
create or replace view aggView4729792571099149105 as select v3, v2 from aggJoin8739554129363317071 group by v3,v2;
create or replace view aggJoin5047215639550936070 as (
with aggView3268855865052222183 as (select v2, MIN(v3) as v55 from aggView4729792571099149105 group by v2)
select movie_id as v11, v55 from cast_info as ci, aggView3268855865052222183 where ci.person_id=aggView3268855865052222183.v2);
create or replace view aggJoin3668563563555884205 as (
with aggView7295814670068827064 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView7295814670068827064 where mk.keyword_id=aggView7295814670068827064.v33);
create or replace view aggJoin7457592714680377163 as (
with aggView8892891505572742529 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView8892891505572742529 where mc.company_id=aggView8892891505572742529.v28);
create or replace view aggJoin6713879959375274981 as (
with aggView3350374604262128885 as (select v11 from aggJoin3668563563555884205 group by v11)
select v11 from aggJoin7457592714680377163 join aggView3350374604262128885 using(v11));
create or replace view aggJoin8851205891476690998 as (
with aggView8558703685044033610 as (select v11 from aggJoin6713879959375274981 group by v11)
select v11, v55 as v55 from aggJoin5047215639550936070 join aggView8558703685044033610 using(v11));
create or replace view aggJoin5400608640890980238 as (
with aggView4788277682651114156 as (select v11, MIN(v55) as v55 from aggJoin8851205891476690998 group by v11,v55)
select v44, v55 from aggView6957309221231831161 join aggView4788277682651114156 using(v11));
select MIN(v55) as v55,MIN(v44) as v56 from aggJoin5400608640890980238;
