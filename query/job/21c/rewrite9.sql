create or replace view aggJoin4561836423543279237 as (
with aggView905977270245848024 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView905977270245848024 where mc.company_id=aggView905977270245848024.v17);
create or replace view aggJoin3607228369033346196 as (
with aggView921978561476142820 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView921978561476142820 where ml.link_type_id=aggView921978561476142820.v13);
create or replace view aggJoin7959469312371922456 as (
with aggView6089930132752692413 as (select v29, MIN(v45) as v45 from aggJoin3607228369033346196 group by v29,v45)
select movie_id as v29, keyword_id as v27, v45 from movie_keyword as mk, aggView6089930132752692413 where mk.movie_id=aggView6089930132752692413.v29);
create or replace view aggJoin3274797101071069746 as (
with aggView8897167491919889960 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin4561836423543279237 join aggView8897167491919889960 using(v18));
create or replace view aggJoin5114956890266418497 as (
with aggView910271012738588253 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select id as v29, title as v33, production_year as v36 from title as t, aggView910271012738588253 where t.id=aggView910271012738588253.v29 and production_year<=2010 and production_year>=1950);
create or replace view aggJoin566381994133976559 as (
with aggView4172176835067961894 as (select id as v27 from keyword as k where keyword= 'sequel')
select v29, v45 from aggJoin7959469312371922456 join aggView4172176835067961894 using(v27));
create or replace view aggJoin5112652873577280507 as (
with aggView1779294803556646151 as (select v29, MIN(v44) as v44 from aggJoin3274797101071069746 group by v29,v44)
select v29, v33, v36, v44 from aggJoin5114956890266418497 join aggView1779294803556646151 using(v29));
create or replace view aggJoin3136433734621006486 as (
with aggView7126736377284138579 as (select v29, MIN(v44) as v44, MIN(v33) as v46 from aggJoin5112652873577280507 group by v29,v44)
select v45 as v45, v44, v46 from aggJoin566381994133976559 join aggView7126736377284138579 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin3136433734621006486;
