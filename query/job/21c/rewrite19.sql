create or replace view aggJoin936363798688018598 as (
with aggView3831849331814027279 as (select id as v17, name as v44 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%')))
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView3831849331814027279 where mc.company_id=aggView3831849331814027279.v17);
create or replace view aggJoin3317152662145016491 as (
with aggView3914211072635416802 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView3914211072635416802 where ml.link_type_id=aggView3914211072635416802.v13);
create or replace view aggJoin6074102187540827172 as (
with aggView7562274515903232204 as (select id as v29, title as v46 from title as t where production_year<=2010 and production_year>=1950)
select movie_id as v29, keyword_id as v27, v46 from movie_keyword as mk, aggView7562274515903232204 where mk.movie_id=aggView7562274515903232204.v29);
create or replace view aggJoin8200554308495701200 as (
with aggView6688256186032551843 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin936363798688018598 join aggView6688256186032551843 using(v18));
create or replace view aggJoin6690150514878528643 as (
with aggView6882042666067477132 as (select id as v27 from keyword as k where keyword= 'sequel')
select v29, v46 from aggJoin6074102187540827172 join aggView6882042666067477132 using(v27));
create or replace view aggJoin2936676369441279051 as (
with aggView603106728037498944 as (select v29, MIN(v44) as v44 from aggJoin8200554308495701200 group by v29,v44)
select v29, v45 as v45, v44 from aggJoin3317152662145016491 join aggView603106728037498944 using(v29));
create or replace view aggJoin7094171587639575093 as (
with aggView7008669588460567416 as (select v29, MIN(v45) as v45, MIN(v44) as v44 from aggJoin2936676369441279051 group by v29,v44,v45)
select v29, v46 as v46, v45, v44 from aggJoin6690150514878528643 join aggView7008669588460567416 using(v29));
create or replace view aggJoin916106846004862514 as (
with aggView2860274909682263932 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select v46 as v46, v45 as v45, v44 as v44 from aggJoin7094171587639575093 join aggView2860274909682263932 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v46) as v46 from aggJoin916106846004862514;
