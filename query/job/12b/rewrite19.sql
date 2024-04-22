create or replace view aggJoin650931764285957838 as (
with aggView1367413181086909278 as (select id as v21 from info_type as it1 where info= 'budget')
select movie_id as v29, info as v22 from movie_info as mi, aggView1367413181086909278 where mi.info_type_id=aggView1367413181086909278.v21);
create or replace view aggJoin5074164636605490177 as (
with aggView7847310282376014272 as (select id as v1 from company_name as cn where country_code= '[us]')
select movie_id as v29, company_type_id as v8 from movie_companies as mc, aggView7847310282376014272 where mc.company_id=aggView7847310282376014272.v1);
create or replace view aggJoin8067931489040575058 as (
with aggView9034083163675374533 as (select id as v26 from info_type as it2 where info= 'bottom 10 rank')
select movie_id as v29 from movie_info_idx as mi_idx, aggView9034083163675374533 where mi_idx.info_type_id=aggView9034083163675374533.v26);
create or replace view aggJoin4080188265121907905 as (
with aggView4399608926026403914 as (select id as v8 from company_type as ct where kind IN ('production companies','distributors'))
select v29 from aggJoin5074164636605490177 join aggView4399608926026403914 using(v8));
create or replace view aggJoin1028308154729452835 as (
with aggView5087047265830524910 as (select v29 from aggJoin8067931489040575058 group by v29)
select id as v29, title as v30, production_year as v33 from title as t, aggView5087047265830524910 where t.id=aggView5087047265830524910.v29 and production_year>2000 and ((title LIKE 'Birdemic%') OR (title LIKE '%Movie%')));
create or replace view aggJoin4014065367949111029 as (
with aggView8840225863891604905 as (select v29, MIN(v30) as v42 from aggJoin1028308154729452835 group by v29)
select v29, v42 from aggJoin4080188265121907905 join aggView8840225863891604905 using(v29));
create or replace view aggJoin3522835859376071379 as (
with aggView2747163927676322180 as (select v29, MIN(v42) as v42 from aggJoin4014065367949111029 group by v29,v42)
select v22, v42 from aggJoin650931764285957838 join aggView2747163927676322180 using(v29));
select MIN(v22) as v41,MIN(v42) as v42 from aggJoin3522835859376071379;
