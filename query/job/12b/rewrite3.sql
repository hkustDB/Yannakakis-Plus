create or replace view aggView2400482294305973492 as select id as v29, title as v30 from title as t where production_year>2000 and ((title LIKE 'Birdemic%') OR (title LIKE '%Movie%'));
create or replace view aggJoin6500521121074791267 as (
with aggView2007430444912195825 as (select id as v21 from info_type as it1 where info= 'budget')
select movie_id as v29, info as v22 from movie_info as mi, aggView2007430444912195825 where mi.info_type_id=aggView2007430444912195825.v21);
create or replace view aggJoin3056168929272242830 as (
with aggView2059161639914277591 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8 from movie_companies as mc, aggView2059161639914277591 where mc.company_id=aggView2059161639914277591.v1);
create or replace view aggJoin4617090319500159784 as (
with aggView5140335109851443424 as (select id as v8 from company_type as ct where kind IN ('production companies','distributors'))
select v29 from aggJoin3056168929272242830 join aggView5140335109851443424 using(v8));
create or replace view aggJoin7208252553092515879 as (
with aggView5079987480161808630 as (select v29 from aggJoin4617090319500159784 group by v29)
select movie_id as v29, info_type_id as v26 from movie_info_idx as mi_idx, aggView5079987480161808630 where mi_idx.movie_id=aggView5079987480161808630.v29);
create or replace view aggJoin4896750779960629418 as (
with aggView6197024623926256206 as (select id as v26 from info_type as it2 where info= 'bottom 10 rank')
select v29 from aggJoin7208252553092515879 join aggView6197024623926256206 using(v26));
create or replace view aggJoin4508918382675102517 as (
with aggView5092170647377602207 as (select v29 from aggJoin4896750779960629418 group by v29)
select v29, v22 from aggJoin6500521121074791267 join aggView5092170647377602207 using(v29));
create or replace view aggView5521269979734060444 as select v29, v22 from aggJoin4508918382675102517 group by v29,v22;
create or replace view aggJoin1407925180851202410 as (
with aggView7751129617843426181 as (select v29, MIN(v22) as v41 from aggView5521269979734060444 group by v29)
select v30, v41 from aggView2400482294305973492 join aggView7751129617843426181 using(v29));
select MIN(v41) as v41,MIN(v30) as v42 from aggJoin1407925180851202410;
