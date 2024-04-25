create or replace view aggView8684350548579129383 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin5793253591162883932 as (
with aggView993653643670194215 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView993653643670194215 where t.kind_id=aggView993653643670194215.v25 and production_year>2005);
create or replace view aggView5347482148023371546 as select v45, v46 from aggJoin5793253591162883932 group by v45,v46;
create or replace view aggJoin944804187384633642 as (
with aggView6418500852426874536 as (select id as v5 from comp_cast_type as cct1 where kind= 'cast')
select movie_id as v45, status_id as v7 from complete_cast as cc, aggView6418500852426874536 where cc.subject_id=aggView6418500852426874536.v5);
create or replace view aggJoin8018560464680352889 as (
with aggView5510534245417762764 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView5510534245417762764 where mi_idx.info_type_id=aggView5510534245417762764.v20 and info<'8.5');
create or replace view aggJoin1280303498433217307 as (
with aggView3784055033805230569 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v45 from aggJoin944804187384633642 join aggView3784055033805230569 using(v7));
create or replace view aggJoin315231398910209160 as (
with aggView6718158097071908911 as (select v45 from aggJoin1280303498433217307 group by v45)
select movie_id as v45, keyword_id as v22 from movie_keyword as mk, aggView6718158097071908911 where mk.movie_id=aggView6718158097071908911.v45);
create or replace view aggJoin6471669654994094489 as (
with aggView8158143244650048166 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v45 from aggJoin315231398910209160 join aggView8158143244650048166 using(v22));
create or replace view aggJoin6412096163960692570 as (
with aggView1839292443239273287 as (select v45 from aggJoin6471669654994094489 group by v45)
select movie_id as v45, info_type_id as v18, info as v35 from movie_info as mi, aggView1839292443239273287 where mi.movie_id=aggView1839292443239273287.v45 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin3768246745733278991 as (
with aggView3160152996188209318 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35 from aggJoin6412096163960692570 join aggView3160152996188209318 using(v18));
create or replace view aggJoin1142070667769780155 as (
with aggView4625621721839978311 as (select v45 from aggJoin3768246745733278991 group by v45)
select v45, v40 from aggJoin8018560464680352889 join aggView4625621721839978311 using(v45));
create or replace view aggView3329845051670026495 as select v45, v40 from aggJoin1142070667769780155 group by v45,v40;
create or replace view aggJoin560233502059233957 as (
with aggView2313633289720482703 as (select v45, MIN(v40) as v58 from aggView3329845051670026495 group by v45)
select v45, v46, v58 from aggView5347482148023371546 join aggView2313633289720482703 using(v45));
create or replace view aggJoin2624934035531849950 as (
with aggView8736172220678156737 as (select v9, MIN(v10) as v57 from aggView8684350548579129383 group by v9)
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView8736172220678156737 where mc.company_id=aggView8736172220678156737.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin6405950207269336181 as (
with aggView9041893710776522668 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin2624934035531849950 join aggView9041893710776522668 using(v16));
create or replace view aggJoin5878960700672002818 as (
with aggView1537050708582940068 as (select v45, MIN(v57) as v57 from aggJoin6405950207269336181 group by v45)
select v46, v58 as v58, v57 from aggJoin560233502059233957 join aggView1537050708582940068 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v46) as v59 from aggJoin5878960700672002818;
