create or replace view aggView1910614298250995350 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin7562555784338721838 as (
with aggView2262633155024641393 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView2262633155024641393 where mi_idx.info_type_id=aggView2262633155024641393.v20 and info>'6.5');
create or replace view aggView8237287439391173507 as select v45, v40 from aggJoin7562555784338721838 group by v45,v40;
create or replace view aggJoin6950421592501717103 as (
with aggView8123558166844518660 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView8123558166844518660 where t.kind_id=aggView8123558166844518660.v25 and production_year>2005);
create or replace view aggJoin4619334347408532003 as (
with aggView2530370487914966413 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView2530370487914966413 where mk.keyword_id=aggView2530370487914966413.v22);
create or replace view aggJoin7046309460452627100 as (
with aggView6467491654737466405 as (select v45 from aggJoin4619334347408532003 group by v45)
select movie_id as v45, info_type_id as v18, info as v35 from movie_info as mi, aggView6467491654737466405 where mi.movie_id=aggView6467491654737466405.v45 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin2002431272943405189 as (
with aggView6915707105459335088 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35 from aggJoin7046309460452627100 join aggView6915707105459335088 using(v18));
create or replace view aggJoin6514809591497437572 as (
with aggView1614871157161314461 as (select v45 from aggJoin2002431272943405189 group by v45)
select v45, v46, v49 from aggJoin6950421592501717103 join aggView1614871157161314461 using(v45));
create or replace view aggView5578707088313182214 as select v46, v45 from aggJoin6514809591497437572 group by v46,v45;
create or replace view aggJoin4972955482165555488 as (
with aggView263353145544152173 as (select v45, MIN(v40) as v58 from aggView8237287439391173507 group by v45)
select movie_id as v45, company_id as v9, company_type_id as v16, note as v31, v58 from movie_companies as mc, aggView263353145544152173 where mc.movie_id=aggView263353145544152173.v45 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin2681982294817981811 as (
with aggView5350079263785182280 as (select v45, MIN(v46) as v59 from aggView5578707088313182214 group by v45)
select v45, v9, v16, v31, v58 as v58, v59 from aggJoin4972955482165555488 join aggView5350079263785182280 using(v45));
create or replace view aggJoin2907932501719255657 as (
with aggView2254944767335519689 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView2254944767335519689 where cc.status_id=aggView2254944767335519689.v7);
create or replace view aggJoin6628170240926664502 as (
with aggView7969546979914073311 as (select id as v16 from company_type as ct)
select v45, v9, v31, v58, v59 from aggJoin2681982294817981811 join aggView7969546979914073311 using(v16));
create or replace view aggJoin2258886654118496367 as (
with aggView4856659955299807070 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin2907932501719255657 join aggView4856659955299807070 using(v5));
create or replace view aggJoin1937885919151381735 as (
with aggView3709555501152993270 as (select v45 from aggJoin2258886654118496367 group by v45)
select v9, v31, v58 as v58, v59 as v59 from aggJoin6628170240926664502 join aggView3709555501152993270 using(v45));
create or replace view aggJoin7095223272752274059 as (
with aggView1321132550107646064 as (select v9, MIN(v58) as v58, MIN(v59) as v59 from aggJoin1937885919151381735 group by v9,v59,v58)
select v10, v58, v59 from aggView1910614298250995350 join aggView1321132550107646064 using(v9));
select MIN(v10) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin7095223272752274059;
