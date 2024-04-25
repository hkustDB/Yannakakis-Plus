create or replace view aggJoin5124461813312257163 as (
with aggView166432708514999743 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView166432708514999743 where mc.company_id=aggView166432708514999743.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1227380777201858343 as (
with aggView7651429147870611936 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView7651429147870611936 where t.kind_id=aggView7651429147870611936.v25 and production_year>2005);
create or replace view aggJoin6333828554288617909 as (
with aggView8405373147846361941 as (select v45, MIN(v46) as v59 from aggJoin1227380777201858343 group by v45)
select v45, v16, v31, v57 as v57, v59 from aggJoin5124461813312257163 join aggView8405373147846361941 using(v45));
create or replace view aggJoin1326394892281598280 as (
with aggView3011071854039343123 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView3011071854039343123 where mi_idx.info_type_id=aggView3011071854039343123.v20 and info<'8.5');
create or replace view aggJoin1547332455126207766 as (
with aggView8050409513217431796 as (select v45, MIN(v40) as v58 from aggJoin1326394892281598280 group by v45)
select movie_id as v45, info_type_id as v18, info as v35, v58 from movie_info as mi, aggView8050409513217431796 where mi.movie_id=aggView8050409513217431796.v45 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin7232608349170072621 as (
with aggView5523337770738437407 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView5523337770738437407 where cc.subject_id=aggView5523337770738437407.v5);
create or replace view aggJoin1318605003459553316 as (
with aggView8567598988582830350 as (select id as v16 from company_type as ct)
select v45, v31, v57, v59 from aggJoin6333828554288617909 join aggView8567598988582830350 using(v16));
create or replace view aggJoin1968962174962479188 as (
with aggView4203687139776823234 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin7232608349170072621 join aggView4203687139776823234 using(v7));
create or replace view aggJoin1943810616676624589 as (
with aggView3560923073206625954 as (select v45, MIN(v57) as v57, MIN(v59) as v59 from aggJoin1318605003459553316 group by v45)
select v45, v18, v35, v58 as v58, v57, v59 from aggJoin1547332455126207766 join aggView3560923073206625954 using(v45));
create or replace view aggJoin2555937409182969812 as (
with aggView3772136430990483774 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35, v58, v57, v59 from aggJoin1943810616676624589 join aggView3772136430990483774 using(v18));
create or replace view aggJoin6814244279679935082 as (
with aggView1154482306302810519 as (select v45, MIN(v58) as v58, MIN(v57) as v57, MIN(v59) as v59 from aggJoin2555937409182969812 group by v45)
select v45, v58, v57, v59 from aggJoin1968962174962479188 join aggView1154482306302810519 using(v45));
create or replace view aggJoin8333305910412241341 as (
with aggView5912148082480292229 as (select v45, MIN(v58) as v58, MIN(v57) as v57, MIN(v59) as v59 from aggJoin6814244279679935082 group by v45)
select keyword_id as v22, v58, v57, v59 from movie_keyword as mk, aggView5912148082480292229 where mk.movie_id=aggView5912148082480292229.v45);
create or replace view aggJoin5718084140971022829 as (
with aggView7763934941851380407 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v58, v57, v59 from aggJoin8333305910412241341 join aggView7763934941851380407 using(v22));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin5718084140971022829;
