create or replace view aggJoin7337916466865404564 as (
with aggView3153962654318560565 as (select id as v25, name as v52 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]')
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView3153962654318560565 where mc.company_id=aggView3153962654318560565.v25);
create or replace view aggJoin4518333184919568930 as (
with aggView6473772702752012993 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView6473772702752012993 where ml.link_type_id=aggView6473772702752012993.v21);
create or replace view aggJoin8129912870107915257 as (
with aggView4016178483583847388 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView4016178483583847388 where cc.subject_id=aggView4016178483583847388.v5);
create or replace view aggJoin7837678935329087875 as (
with aggView2776824214313622135 as (select id as v35 from keyword as k where keyword= 'sequel')
select movie_id as v37 from movie_keyword as mk, aggView2776824214313622135 where mk.keyword_id=aggView2776824214313622135.v35);
create or replace view aggJoin1567970962462717303 as (
with aggView5860734981670077925 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v37 from aggJoin8129912870107915257 join aggView5860734981670077925 using(v7));
create or replace view aggJoin4303578484555465236 as (
with aggView9015894301531780105 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin7337916466865404564 join aggView9015894301531780105 using(v26));
create or replace view aggJoin8070240640756748852 as (
with aggView9196096249871366405 as (select v37, MIN(v52) as v52 from aggJoin4303578484555465236 group by v37,v52)
select v37, v53 as v53, v52 from aggJoin4518333184919568930 join aggView9196096249871366405 using(v37));
create or replace view aggJoin3103306705051215288 as (
with aggView6844355873439055161 as (select v37, MIN(v53) as v53, MIN(v52) as v52 from aggJoin8070240640756748852 group by v37,v53,v52)
select v37, v53, v52 from aggJoin1567970962462717303 join aggView6844355873439055161 using(v37));
create or replace view aggJoin1312355251840555664 as (
with aggView6866696925844658430 as (select v37, MIN(v53) as v53, MIN(v52) as v52 from aggJoin3103306705051215288 group by v37,v53,v52)
select id as v37, title as v41, production_year as v44, v53, v52 from title as t, aggView6866696925844658430 where t.id=aggView6866696925844658430.v37 and production_year= 1998);
create or replace view aggJoin5612126898082305690 as (
with aggView3838154162227959634 as (select movie_id as v37 from movie_info as mi where info IN ('Sweden','Germany','Swedish','German') group by movie_id)
select v37, v41, v44, v53 as v53, v52 as v52 from aggJoin1312355251840555664 join aggView3838154162227959634 using(v37));
create or replace view aggJoin3604490875016345806 as (
with aggView4121204951667377958 as (select v37, MIN(v53) as v53, MIN(v52) as v52, MIN(v41) as v54 from aggJoin5612126898082305690 group by v37,v53,v52)
select v53, v52, v54 from aggJoin7837678935329087875 join aggView4121204951667377958 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin3604490875016345806;
