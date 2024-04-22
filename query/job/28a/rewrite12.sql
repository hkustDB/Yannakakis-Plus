create or replace view aggView7120432260284096098 as select name as v10, id as v9 from company_name as cn where country_code<> '[us]';
create or replace view aggJoin3255146790856924098 as (
with aggView9092128337718673553 as (select id as v25 from kind_type as kt where kind IN ('movie','episode'))
select id as v45, title as v46, production_year as v49 from title as t, aggView9092128337718673553 where t.kind_id=aggView9092128337718673553.v25 and production_year>2000);
create or replace view aggView2889270149302076829 as select v45, v46 from aggJoin3255146790856924098 group by v45,v46;
create or replace view aggJoin4017749527942221451 as (
with aggView6091249381211038903 as (select id as v20 from info_type as it2 where info= 'rating')
select movie_id as v45, info as v40 from movie_info_idx as mi_idx, aggView6091249381211038903 where mi_idx.info_type_id=aggView6091249381211038903.v20 and info<'8.5');
create or replace view aggView631010888952908543 as select v40, v45 from aggJoin4017749527942221451 group by v40,v45;
create or replace view aggJoin1000762967623553738 as (
with aggView3326380956743280053 as (select v9, MIN(v10) as v57 from aggView7120432260284096098 group by v9)
select movie_id as v45, company_type_id as v16, note as v31, v57 from movie_companies as mc, aggView3326380956743280053 where mc.company_id=aggView3326380956743280053.v9 and note NOT LIKE '%(USA)%' and note LIKE '%(200%)%');
create or replace view aggJoin5436868951437072261 as (
with aggView7006341870348922605 as (select id as v22 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v45 from movie_keyword as mk, aggView7006341870348922605 where mk.keyword_id=aggView7006341870348922605.v22);
create or replace view aggJoin6618024557179868214 as (
with aggView5690360951548531258 as (select id as v18 from info_type as it1 where info= 'countries')
select movie_id as v45, info as v35 from movie_info as mi, aggView5690360951548531258 where mi.info_type_id=aggView5690360951548531258.v18 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Danish','Norwegian','German','USA','American'));
create or replace view aggJoin4424537659103445130 as (
with aggView5940821434244315827 as (select v45 from aggJoin6618024557179868214 group by v45)
select v45 from aggJoin5436868951437072261 join aggView5940821434244315827 using(v45));
create or replace view aggJoin3963108092714056216 as (
with aggView778826346561348931 as (select id as v7 from comp_cast_type as cct2 where kind<> 'complete+verified')
select movie_id as v45, subject_id as v5 from complete_cast as cc, aggView778826346561348931 where cc.status_id=aggView778826346561348931.v7);
create or replace view aggJoin6858298715544833898 as (
with aggView6528233765212488361 as (select id as v5 from comp_cast_type as cct1 where kind= 'crew')
select v45 from aggJoin3963108092714056216 join aggView6528233765212488361 using(v5));
create or replace view aggJoin3481819646720592641 as (
with aggView474784771263782153 as (select id as v16 from company_type as ct)
select v45, v31, v57 from aggJoin1000762967623553738 join aggView474784771263782153 using(v16));
create or replace view aggJoin1455448181418516902 as (
with aggView6671190281828560988 as (select v45 from aggJoin6858298715544833898 group by v45)
select v45, v31, v57 as v57 from aggJoin3481819646720592641 join aggView6671190281828560988 using(v45));
create or replace view aggJoin517340200502276200 as (
with aggView8794879827049268150 as (select v45 from aggJoin4424537659103445130 group by v45)
select v45, v31, v57 as v57 from aggJoin1455448181418516902 join aggView8794879827049268150 using(v45));
create or replace view aggJoin8951089337688608044 as (
with aggView804678690667886085 as (select v45, MIN(v57) as v57 from aggJoin517340200502276200 group by v45,v57)
select v45, v46, v57 from aggView2889270149302076829 join aggView804678690667886085 using(v45));
create or replace view aggJoin8718962505770420344 as (
with aggView1262487984445770731 as (select v45, MIN(v57) as v57, MIN(v46) as v59 from aggJoin8951089337688608044 group by v45,v57)
select v40, v57, v59 from aggView631010888952908543 join aggView1262487984445770731 using(v45));
select MIN(v57) as v57,MIN(v40) as v58,MIN(v59) as v59 from aggJoin8718962505770420344;
