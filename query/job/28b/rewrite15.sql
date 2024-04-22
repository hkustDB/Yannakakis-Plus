create or replace view aggJoin4722997131147315140 as (
with aggView2725176578378040549 as (select id as v9, name as v57 from company_name as cn where country_code<> '[us]')
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView2725176578378040549 where mc.company_id=aggView2725176578378040549.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin1231447438720339898 as (
with aggView7095054436022253550 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView7095054436022253550 where mi_idx.info_type_id=aggView7095054436022253550.v20 and info>'6.5');
create or replace view aggJoin8693416745364645398 as (
with aggView3702546195580642357 as (select v45, MIN(v40) as v58 from aggJoin1231447438720339898 group by v45)
select movie_id as v45, keyword_id as v22, v58 from movie_keyword as mk, aggView3702546195580642357 where mk.movie_id=aggView3702546195580642357.v45);
create or replace view aggJoin3601882193847796690 as (
with aggView553199001491744789 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView553199001491744789 where cc.status_id=aggView553199001491744789.v7);
create or replace view aggJoin533788025456203207 as (
with aggView4269859210098313140 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin4722997131147315140 join aggView4269859210098313140 using(v16));
create or replace view aggJoin7948997984183313648 as (
with aggView804496151976313699 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView804496151976313699 where t.kind_id=aggView804496151976313699.v25 and production_year>2005);
create or replace view aggJoin3252868244519058662 as (
with aggView1424797269667267620 as (select v45, MIN(v46) as v59 from aggJoin7948997984183313648 group by v45)
select movie_id as v45, info_type_id as v18, info as v35, v59 from movie_info as mi, aggView1424797269667267620 where mi.movie_id=aggView1424797269667267620.v45 and info IN ('Sweden','Germany','Swedish','German'));
create or replace view aggJoin1662759219171538138 as (
with aggView1449836738223330171 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin3601882193847796690 join aggView1449836738223330171 using(v5));
create or replace view aggJoin4126667745160817517 as (
with aggView2778123116198778846 as (select v45 from aggJoin1662759219171538138 group by v45)
select v45, v18, v35, v59 as v59 from aggJoin3252868244519058662 join aggView2778123116198778846 using(v45));
create or replace view aggJoin1668703757291024309 as (
with aggView8102875532731662087 as (select id as v18 from info_type as it1 where info= 'countries')
select v45, v35, v59 from aggJoin4126667745160817517 join aggView8102875532731662087 using(v18));
create or replace view aggJoin1827371116870692465 as (
with aggView9204754042032203675 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select v45, v58 from aggJoin8693416745364645398 join aggView9204754042032203675 using(v22));
create or replace view aggJoin5976806495972166217 as (
with aggView4604390966914794946 as (select v45, MIN(v57) as v57 from aggJoin533788025456203207 group by v45,v57)
select v45, v35, v59 as v59, v57 from aggJoin1668703757291024309 join aggView4604390966914794946 using(v45));
create or replace view aggJoin1004225056626239905 as (
with aggView3018058954456763279 as (select v45, MIN(v59) as v59, MIN(v57) as v57 from aggJoin5976806495972166217 group by v45,v59,v57)
select v58 as v58, v59, v57 from aggJoin1827371116870692465 join aggView3018058954456763279 using(v45));
select MIN(v57) as v57,MIN(v58) as v58,MIN(v59) as v59 from aggJoin1004225056626239905;
