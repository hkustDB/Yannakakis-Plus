create or replace view aggJoin7383795722823053344 as (
with aggView1891652650185803690 as (select id as v18 from keyword as k where keyword IN ('nerd','loner','alienation','dignity'))
select movie_id as v36 from movie_keyword as mk, aggView1891652650185803690 where mk.keyword_id=aggView1891652650185803690.v18);
create or replace view aggJoin5198149628907644232 as (
with aggView6349341526058358104 as (select id as v16 from info_type as it1 where info= 'release dates')
select movie_id as v36, info as v31, note as v32 from movie_info as mi, aggView6349341526058358104 where mi.info_type_id=aggView6349341526058358104.v16 and info LIKE 'USA:% 200%' and note LIKE '%internet%');
create or replace view aggJoin1787722819548238846 as (
with aggView2724582664385393764 as (select id as v14 from company_type as ct)
select movie_id as v36, company_id as v7 from movie_companies as mc, aggView2724582664385393764 where mc.company_type_id=aggView2724582664385393764.v14);
create or replace view aggJoin2766915139469762706 as (
with aggView3727396237912312069 as (select v36 from aggJoin5198149628907644232 group by v36)
select v36 from aggJoin7383795722823053344 join aggView3727396237912312069 using(v36));
create or replace view aggJoin9055597926168466108 as (
with aggView582018524075513641 as (select id as v5 from comp_cast_type as cct1 where kind= 'complete+verified')
select movie_id as v36 from complete_cast as cc, aggView582018524075513641 where cc.status_id=aggView582018524075513641.v5);
create or replace view aggJoin4818748077875625244 as (
with aggView8634327821238255789 as (select v36 from aggJoin9055597926168466108 group by v36)
select id as v36, title as v37, kind_id as v21, production_year as v40 from title as t, aggView8634327821238255789 where t.id=aggView8634327821238255789.v36 and production_year>2000);
create or replace view aggJoin3954291406990025631 as (
with aggView1929006257662442196 as (select id as v7 from company_name as cn where country_code= '[us]')
select v36 from aggJoin1787722819548238846 join aggView1929006257662442196 using(v7));
create or replace view aggJoin2438040092404346427 as (
with aggView3684462408911525845 as (select v36 from aggJoin2766915139469762706 group by v36)
select v36 from aggJoin3954291406990025631 join aggView3684462408911525845 using(v36));
create or replace view aggJoin4155361106425902726 as (
with aggView68754595743627392 as (select v36 from aggJoin2438040092404346427 group by v36)
select v37, v21, v40 from aggJoin4818748077875625244 join aggView68754595743627392 using(v36));
create or replace view aggView1386541360802376763 as select v37, v21 from aggJoin4155361106425902726 group by v37,v21;
create or replace view aggJoin5055334923541957988 as (
with aggView1453248251924345865 as (select v21, MIN(v37) as v49 from aggView1386541360802376763 group by v21)
select kind as v22, v49 from kind_type as kt, aggView1453248251924345865 where kt.id=aggView1453248251924345865.v21 and kind= 'movie');
select MIN(v22) as v48,MIN(v49) as v49 from aggJoin5055334923541957988;
