create or replace view aggView8893057926446019954 as select id as v37, title as v41 from title as t where production_year= 1998;
create or replace view aggView280502113412512915 as select id as v25, name as v10 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]';
create or replace view aggJoin5690376086125394912 as (
with aggView6669668841496705088 as (select v25, MIN(v10) as v52 from aggView280502113412512915 group by v25)
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView6669668841496705088 where mc.company_id=aggView6669668841496705088.v25);
create or replace view aggJoin1297961603308961663 as (
with aggView6813658142731040962 as (select v37, MIN(v41) as v54 from aggView8893057926446019954 group by v37)
select v37, v26, v52 as v52, v54 from aggJoin5690376086125394912 join aggView6813658142731040962 using(v37));
create or replace view aggJoin8148046684697825501 as (
with aggView4937363731322673537 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView4937363731322673537 where cc.subject_id=aggView4937363731322673537.v5);
create or replace view aggJoin5889943041619958456 as (
with aggView6489898496473499317 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView6489898496473499317 where mk.keyword_id=aggView6489898496473499317.v35);
create or replace view aggJoin4459688462514699116 as (
with aggView7600136664807408326 as (select v37 from aggJoin5889943041619958456 group by v37)
select v37, v26, v52 as v52, v54 as v54 from aggJoin1297961603308961663 join aggView7600136664807408326 using(v37));
create or replace view aggJoin6297345310633333905 as (
with aggView7255442933289664137 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v37 from aggJoin8148046684697825501 join aggView7255442933289664137 using(v7));
create or replace view aggJoin5454225609055245337 as (
with aggView6574468326932139748 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52, v54 from aggJoin4459688462514699116 join aggView6574468326932139748 using(v26));
create or replace view aggJoin1757261527909598508 as (
with aggView5177909600422657214 as (select v37 from aggJoin6297345310633333905 group by v37)
select v37, v52 as v52, v54 as v54 from aggJoin5454225609055245337 join aggView5177909600422657214 using(v37));
create or replace view aggJoin2434975065936283253 as (
with aggView6025177382154635863 as (select movie_id as v37 from movie_info as mi where info IN ('Sweden','Germany','Swedish','German') group by movie_id)
select v37, v52 as v52, v54 as v54 from aggJoin1757261527909598508 join aggView6025177382154635863 using(v37));
create or replace view aggJoin4314115186144460873 as (
with aggView4853147729022470592 as (select v37, MIN(v52) as v52, MIN(v54) as v54 from aggJoin2434975065936283253 group by v37,v52,v54)
select link_type_id as v21, v52, v54 from movie_link as ml, aggView4853147729022470592 where ml.movie_id=aggView4853147729022470592.v37);
create or replace view aggJoin1547846678604938891 as (
with aggView3578738699700192819 as (select v21, MIN(v52) as v52, MIN(v54) as v54 from aggJoin4314115186144460873 group by v21,v52,v54)
select link as v22, v52, v54 from link_type as lt, aggView3578738699700192819 where lt.id=aggView3578738699700192819.v21 and link LIKE '%follow%');
select MIN(v52) as v52,MIN(v22) as v53,MIN(v54) as v54 from aggJoin1547846678604938891;
