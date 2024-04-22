create or replace view aggJoin4755595885590947929 as (
with aggView6617866197194881721 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView6617866197194881721 where mc.company_id=aggView6617866197194881721.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin2830275481889435112 as (
with aggView7204946356610325195 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView7204946356610325195 where mi_idx.info_type_id=aggView7204946356610325195.v20 and info>'6.5');
create or replace view aggJoin1125994896150812609 as (
with aggView2413585086426750419 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView2413585086426750419 where cc.status_id=aggView2413585086426750419.v7);
create or replace view aggJoin3133249347297770798 as (
with aggView6345243160617532949 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin4755595885590947929 join aggView6345243160617532949 using(v16));
create or replace view aggJoin5978607646652963722 as (
with aggView7117086627667738241 as (select v45, MIN(v57) as v57 from aggJoin3133249347297770798 group by v45,v57)
select v45, v5, v57 from aggJoin1125994896150812609 join aggView7117086627667738241 using(v45));
create or replace view aggJoin5172228203474116120 as (
with aggView2381518062032922416 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView2381518062032922416 where t.kind_id=aggView2381518062032922416.v25 and production_year>2005);
create or replace view aggJoin5110793048477502130 as (
with aggView8334872342478452381 as (select v45, MIN(v46) as v59 from aggJoin5172228203474116120 group by v45)
select v45, v5, v57 as v57, v59 from aggJoin5978607646652963722 join aggView8334872342478452381 using(v45));
create or replace view aggJoin7002303753649529374 as (
with aggView3387763783110836750 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45, v57, v59 from aggJoin5110793048477502130 join aggView3387763783110836750 using(v5));
create or replace view aggJoin2504469328596495059 as (
with aggView170333814542374122 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView170333814542374122 where mi.info_type_id=aggView170333814542374122.v18 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin1284364394101230925 as (
with aggView4505564753875490632 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView4505564753875490632 where mk.keyword_id=aggView4505564753875490632.v22);
create or replace view aggJoin2880163861443000289 as (
with aggView301056089285995429 as (select v45, MIN(v57) as v57, MIN(v59) as v59 from aggJoin7002303753649529374 group by v45,v59,v57)
select v45, v40, v57, v59 from aggJoin2830275481889435112 join aggView301056089285995429 using(v45));
create or replace view aggJoin2606287539804607576 as (
with aggView3618518983910074643 as (select v45, MIN(v57) as v57, MIN(v59) as v59, MIN(v40) as v58 from aggJoin2880163861443000289 group by v45,v59,v57)
select v45, v35, v57, v59, v58 from aggJoin2504469328596495059 join aggView3618518983910074643 using(v45));
create or replace view aggJoin9037837666960169352 as (
with aggView1788515896841561462 as (select v45, MIN(v57) as v57, MIN(v59) as v59, MIN(v58) as v58 from aggJoin2606287539804607576 group by v45,v59,v58,v57)
select v57, v59, v58 from aggJoin1284364394101230925 join aggView1788515896841561462 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin9037837666960169352;
