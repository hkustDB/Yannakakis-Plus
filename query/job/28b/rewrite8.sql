create or replace view aggJoin2499025917109180633 as (
with aggView4407894626758339825 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView4407894626758339825 where mc.company_id=aggView4407894626758339825.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin4558414347246408589 as (
with aggView3066623141507382247 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView3066623141507382247 where mi_idx.info_type_id=aggView3066623141507382247.v20 and info>'6.5');
create or replace view aggJoin3271816885744131944 as (
with aggView2888972254640754728 as (select v45, MIN(v40) as v58 from aggJoin4558414347246408589 group by v45)
select id as v45, title as v46, kind_id as v25, production_year as v49, v58 from title as t, aggView2888972254640754728 where t.id=aggView2888972254640754728.v45 and production_year>2005);
create or replace view aggJoin3246021153515348550 as (
with aggView2127719912111308354 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView2127719912111308354 where cc.status_id=aggView2127719912111308354.v7);
create or replace view aggJoin4600200736331759630 as (
with aggView802164213312899271 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin2499025917109180633 join aggView802164213312899271 using(v16));
create or replace view aggJoin5284496451952849295 as (
with aggView725624606595120458 as (select v45, MIN(v57) as v57 from aggJoin4600200736331759630 group by v45,v57)
select v45, v5, v57 from aggJoin3246021153515348550 join aggView725624606595120458 using(v45));
create or replace view aggJoin7730894709680775400 as (
with aggView5351608773243460277 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select v45, v46, v49, v58 from aggJoin3271816885744131944 join aggView5351608773243460277 using(v25));
create or replace view aggJoin1729281257140717628 as (
with aggView3409724630985714149 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45, v57 from aggJoin5284496451952849295 join aggView3409724630985714149 using(v5));
create or replace view aggJoin4989484812340670049 as (
with aggView6845521638780782950 as (select v45, MIN(v57) as v57 from aggJoin1729281257140717628 group by v45,v57)
select v45, v46, v49, v58 as v58, v57 from aggJoin7730894709680775400 join aggView6845521638780782950 using(v45));
create or replace view aggJoin1441437115858742693 as (
with aggView3643109212799443225 as (select v45, MIN(v58) as v58, MIN(v57) as v57, MIN(v46) as v59 from aggJoin4989484812340670049 group by v45,v58,v57)
select movie_id as v45, info_type_id as v18, info as v35, v58, v57, v59 from movie_info as mi, aggView3643109212799443225 where mi.movie_id=aggView3643109212799443225.v45 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin8259123442528058091 as (
with aggView5396316634593769944 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35, v58, v57, v59 from aggJoin1441437115858742693 join aggView5396316634593769944 using(v18));
create or replace view aggJoin6624394748554587295 as (
with aggView7020440352822514996 as (select v45, MIN(v58) as v58, MIN(v57) as v57, MIN(v59) as v59 from aggJoin8259123442528058091 group by v45,v59,v58,v57)
select keyword_id as v22, v58, v57, v59 from movie_keyword as mk, aggView7020440352822514996 where mk.movie_id=aggView7020440352822514996.v45);
create or replace view aggJoin3829473857007021092 as (
with aggView6438478772256405874 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v58, v57, v59 from aggJoin6624394748554587295 join aggView6438478772256405874 using(v22));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin3829473857007021092;
