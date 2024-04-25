create or replace view aggView8247007004088828699 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin4892777354238438966 as (
with aggView9137164305533652689 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView9137164305533652689 where t.kind_id=aggView9137164305533652689.v25 and production_year>2005);
create or replace view aggJoin4749189747762355263 as (
with aggView2327796968587691049 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView2327796968587691049 where cc.subject_id=aggView2327796968587691049.v5);
create or replace view aggJoin6289843613242808662 as (
with aggView449741110240489702 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView449741110240489702 where mi_idx.info_type_id=aggView449741110240489702.v20 and info<'8.5');
create or replace view aggView3408890141215385264 as select v45, v40 from aggJoin6289843613242808662 group by v45,v40;
create or replace view aggJoin1131376131802808104 as (
with aggView4070517436865331265 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin4749189747762355263 join aggView4070517436865331265 using(v7));
create or replace view aggJoin3013400720551747727 as (
with aggView6830302438365342814 as (select v45 from aggJoin1131376131802808104 group by v45)
select v45, v46, v49 from aggJoin4892777354238438966 join aggView6830302438365342814 using(v45));
create or replace view aggJoin4210586678324507906 as (
with aggView1481182216095067650 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView1481182216095067650 where mk.keyword_id=aggView1481182216095067650.v22);
create or replace view aggJoin6483324402991469510 as (
with aggView2580719859986851691 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView2580719859986851691 where mi.info_type_id=aggView2580719859986851691.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin115020149405675781 as (
with aggView8171498605274520205 as (select v45 from aggJoin6483324402991469510 group by v45)
select v45 from aggJoin4210586678324507906 join aggView8171498605274520205 using(v45));
create or replace view aggJoin66753098334596985 as (
with aggView1941142755599170394 as (select v45 from aggJoin115020149405675781 group by v45)
select v45, v46, v49 from aggJoin3013400720551747727 join aggView1941142755599170394 using(v45));
create or replace view aggView414879110679172913 as select v45, v46 from aggJoin66753098334596985 group by v45,v46;
create or replace view aggJoin2227288417550426845 as (
with aggView5695036162341973213 as (select v45, MIN(v46) as v59 from aggView414879110679172913 group by v45)
select v45, v40, v59 from aggView3408890141215385264 join aggView5695036162341973213 using(v45));
create or replace view aggJoin1665112864807881727 as (
with aggView1545794114280760467 as (select v45, MIN(v59) as v59, MIN(v40) as v58 from aggJoin2227288417550426845 group by v45)
select company_id as v9, company_type_id as v16, note as v31, v59, v58 from movie_companies as mc, aggView1545794114280760467 where mc.movie_id=aggView1545794114280760467.v45 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin6027234009484090113 as (
with aggView5399961486609759313 as (select id as v16 from company_type as ct)
select v9, v31, v59, v58 from aggJoin1665112864807881727 join aggView5399961486609759313 using(v16));
create or replace view aggJoin3425464633864675430 as (
with aggView5403474753408472083 as (select v9, MIN(v59) as v59, MIN(v58) as v58 from aggJoin6027234009484090113 group by v9)
select v10, v59, v58 from aggView8247007004088828699 join aggView5403474753408472083 using(v9));
select MIN(v10) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin3425464633864675430;
