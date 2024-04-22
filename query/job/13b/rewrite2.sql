create or replace view aggView2912046347530513143 as select id as v1, name as v2 from company_name as cn where country_code= '[us]';
create or replace view aggJoin856520838072564065 as (
with aggView5992318622804944237 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView5992318622804944237 where mi.info_type_id=aggView5992318622804944237.v12);
create or replace view aggJoin8966355526252268449 as (
with aggView2512621394549955232 as (select v22 from aggJoin856520838072564065 group by v22)
select movie_id as v22, info_type_id as v10, info as v29 from movie_info_idx as miidx, aggView2512621394549955232 where miidx.movie_id=aggView2512621394549955232.v22);
create or replace view aggJoin4827911079465635925 as (
with aggView139458874091393429 as (select id as v10 from info_type as it where info= 'rating')
select v22, v29 from aggJoin8966355526252268449 join aggView139458874091393429 using(v10));
create or replace view aggView6257929676467920405 as select v22, v29 from aggJoin4827911079465635925 group by v22,v29;
create or replace view aggJoin2188156165678799513 as (
with aggView4219671088916443329 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView4219671088916443329 where t.kind_id=aggView4219671088916443329.v14 and title<> '' and ((title LIKE '%Champion%') OR (title LIKE '%Loser%')));
create or replace view aggView8412731358337406293 as select v22, v32 from aggJoin2188156165678799513 group by v22,v32;
create or replace view aggJoin4585506637625412275 as (
with aggView1916731511143543422 as (select v22, MIN(v32) as v45 from aggView8412731358337406293 group by v22)
select v22, v29, v45 from aggView6257929676467920405 join aggView1916731511143543422 using(v22));
create or replace view aggJoin6231327382373646676 as (
with aggView4788391419943197795 as (select v22, MIN(v45) as v45, MIN(v29) as v44 from aggJoin4585506637625412275 group by v22,v45)
select company_id as v1, company_type_id as v8, v45, v44 from movie_companies as mc, aggView4788391419943197795 where mc.movie_id=aggView4788391419943197795.v22);
create or replace view aggJoin6204903784105921318 as (
with aggView7021138365395772442 as (select id as v8 from company_type as ct where kind= 'production companies')
select v1, v45, v44 from aggJoin6231327382373646676 join aggView7021138365395772442 using(v8));
create or replace view aggJoin3415665228070454243 as (
with aggView5192961586434159074 as (select v1, MIN(v45) as v45, MIN(v44) as v44 from aggJoin6204903784105921318 group by v1,v44,v45)
select v2, v45, v44 from aggView2912046347530513143 join aggView5192961586434159074 using(v1));
select MIN(v2) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin3415665228070454243;
