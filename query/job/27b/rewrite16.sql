create or replace view aggJoin2709602128861409513 as (
with aggView5882156007555042706 as (select id as v25, name as v52 from company_name as cn where ((name LIKE '%Film%') OR (name LIKE '%Warner%')) and country_code<> '[pl]')
select movie_id as v37, company_type_id as v26, v52 from movie_companies as mc, aggView5882156007555042706 where mc.company_id=aggView5882156007555042706.v25);
create or replace view aggJoin3713170621592270057 as (
with aggView5011826148170260278 as (select id as v21, link as v53 from link_type as lt where link LIKE '%follow%')
select movie_id as v37, v53 from movie_link as ml, aggView5011826148170260278 where ml.link_type_id=aggView5011826148170260278.v21);
create or replace view aggJoin8783231479932899336 as (
with aggView6089915022596738991 as (select id as v5 from comp_cast_type as cct1 where kind IN ('cast','crew'))
select movie_id as v37, status_id as v7 from complete_cast as cc, aggView6089915022596738991 where cc.subject_id=aggView6089915022596738991.v5);
create or replace view aggJoin841160402493483250 as (
with aggView109191482174491886 as (select movie_id as v37 from movie_info as mi where info IN ('Sweden','Germany','Swedish','German') group by movie_id)
select movie_id as v37, keyword_id as v35 from movie_keyword as mk, aggView109191482174491886 where mk.movie_id=aggView109191482174491886.v37);
create or replace view aggJoin5879286423778778708 as (
with aggView1677301880753200620 as (select id as v35 from keyword as k where keyword= 'sequel')
select v37 from aggJoin841160402493483250 join aggView1677301880753200620 using(v35));
create or replace view aggJoin1357314652267047113 as (
with aggView7818745195271567736 as (select id as v7 from comp_cast_type as cct2 where kind= 'complete')
select v37 from aggJoin8783231479932899336 join aggView7818745195271567736 using(v7));
create or replace view aggJoin6105223511611290881 as (
with aggView144872589539429664 as (select id as v26 from company_type as ct where kind= 'production companies')
select v37, v52 from aggJoin2709602128861409513 join aggView144872589539429664 using(v26));
create or replace view aggJoin8383237439750699327 as (
with aggView5071225156752319485 as (select v37, MIN(v52) as v52 from aggJoin6105223511611290881 group by v37,v52)
select id as v37, title as v41, production_year as v44, v52 from title as t, aggView5071225156752319485 where t.id=aggView5071225156752319485.v37 and production_year= 1998);
create or replace view aggJoin4950411564039614269 as (
with aggView4264547051052790072 as (select v37, MIN(v52) as v52, MIN(v41) as v54 from aggJoin8383237439750699327 group by v37,v52)
select v37, v52, v54 from aggJoin1357314652267047113 join aggView4264547051052790072 using(v37));
create or replace view aggJoin3531238230285333166 as (
with aggView830594512542817061 as (select v37, MIN(v53) as v53 from aggJoin3713170621592270057 group by v37,v53)
select v37, v52 as v52, v54 as v54, v53 from aggJoin4950411564039614269 join aggView830594512542817061 using(v37));
create or replace view aggJoin8962985110152944084 as (
with aggView1571430033471968803 as (select v37, MIN(v52) as v52, MIN(v54) as v54, MIN(v53) as v53 from aggJoin3531238230285333166 group by v37,v53,v52,v54)
select v52, v54, v53 from aggJoin5879286423778778708 join aggView1571430033471968803 using(v37));
select MIN(v52) as v52,MIN(v53) as v53,MIN(v54) as v54 from aggJoin8962985110152944084;
