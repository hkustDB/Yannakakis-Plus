create or replace view aggJoin8377521926384920765 as (
with aggView6955054387757432123 as (select id as v40, title as v53 from title as t where production_year<=2010 and production_year>=2005)
select movie_id as v40, info_type_id as v22, info as v35, note as v36, v53 from movie_info as mi, aggView6955054387757432123 where mi.movie_id=aggView6955054387757432123.v40 and note LIKE '%internet%' and info LIKE 'USA:% 200%');
create or replace view aggJoin1269985621937109706 as (
with aggView6605434910520344278 as (select id as v22 from info_type as it1 where info= 'release dates')
select v40, v35, v36, v53 from aggJoin8377521926384920765 join aggView6605434910520344278 using(v22));
create or replace view aggJoin3666034954176088141 as (
with aggView2891932488665546434 as (select id as v13 from company_name as cn where name= 'YouTube' and country_code= '[us]')
select movie_id as v40, company_type_id as v20, note as v31 from movie_companies as mc, aggView2891932488665546434 where mc.company_id=aggView2891932488665546434.v13 and note LIKE '%(200%)%' and note LIKE '%(worldwide)%');
create or replace view aggJoin1504516131991862916 as (
with aggView167864570869483802 as (select id as v20 from company_type as ct)
select v40, v31 from aggJoin3666034954176088141 join aggView167864570869483802 using(v20));
create or replace view aggJoin6896028851495216238 as (
with aggView1382163561953461399 as (select v40 from aggJoin1504516131991862916 group by v40)
select v40, v35, v36, v53 as v53 from aggJoin1269985621937109706 join aggView1382163561953461399 using(v40));
create or replace view aggJoin1661293890065309294 as (
with aggView5278265333715262611 as (select v40, MIN(v53) as v53, MIN(v35) as v52 from aggJoin6896028851495216238 group by v40,v53)
select movie_id as v40, v53, v52 from aka_title as aka_t, aggView5278265333715262611 where aka_t.movie_id=aggView5278265333715262611.v40);
create or replace view aggJoin6101555561335148288 as (
with aggView1807869683189599722 as (select v40, MIN(v53) as v53, MIN(v52) as v52 from aggJoin1661293890065309294 group by v40,v53,v52)
select keyword_id as v24, v53, v52 from movie_keyword as mk, aggView1807869683189599722 where mk.movie_id=aggView1807869683189599722.v40);
create or replace view aggJoin8390921994142586749 as (
with aggView846534153435210105 as (select id as v24 from keyword as k)
select v53, v52 from aggJoin6101555561335148288 join aggView846534153435210105 using(v24));
select MIN(v52) as v52,MIN(v53) as v53 from aggJoin8390921994142586749;
