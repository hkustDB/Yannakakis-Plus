create or replace view aggView4476105556710858848 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin5663106771329455217 as (
with aggView6541447560351928137 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select id as v29, title as v33, production_year as v36 from title as t, aggView6541447560351928137 where t.id=aggView6541447560351928137.v29 and production_year<=2010 and production_year>=1950);
create or replace view aggView4918022221466657052 as select v33, v29 from aggJoin5663106771329455217 group by v33,v29;
create or replace view aggJoin8836755377627967007 as (
with aggView6026100865590050654 as (select v29, MIN(v33) as v46 from aggView4918022221466657052 group by v29)
select movie_id as v29, company_id as v17, company_type_id as v18, v46 from movie_companies as mc, aggView6026100865590050654 where mc.movie_id=aggView6026100865590050654.v29);
create or replace view aggJoin5289367787432713422 as (
with aggView6834712218549567722 as (select v17, MIN(v2) as v44 from aggView4476105556710858848 group by v17)
select v29, v18, v46 as v46, v44 from aggJoin8836755377627967007 join aggView6834712218549567722 using(v17));
create or replace view aggJoin7999736228053895967 as (
with aggView7120883308629971657 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v46, v44 from aggJoin5289367787432713422 join aggView7120883308629971657 using(v18));
create or replace view aggJoin6540242445873558194 as (
with aggView3888871690341822214 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView3888871690341822214 where mk.keyword_id=aggView3888871690341822214.v27);
create or replace view aggJoin8049278959594567654 as (
with aggView24813988653113445 as (select v29 from aggJoin6540242445873558194 group by v29)
select movie_id as v29, link_type_id as v13 from movie_link as ml, aggView24813988653113445 where ml.movie_id=aggView24813988653113445.v29);
create or replace view aggJoin6467533627722315320 as (
with aggView3545683856876402194 as (select v29, MIN(v46) as v46, MIN(v44) as v44 from aggJoin7999736228053895967 group by v29,v44,v46)
select v13, v46, v44 from aggJoin8049278959594567654 join aggView3545683856876402194 using(v29));
create or replace view aggJoin789262916980358971 as (
with aggView6342522566434757734 as (select v13, MIN(v46) as v46, MIN(v44) as v44 from aggJoin6467533627722315320 group by v13,v44,v46)
select link as v14, v46, v44 from link_type as lt, aggView6342522566434757734 where lt.id=aggView6342522566434757734.v13 and link LIKE '%follow%');
select MIN(v44) as v44,MIN(v14) as v45,MIN(v46) as v46 from aggJoin789262916980358971;
