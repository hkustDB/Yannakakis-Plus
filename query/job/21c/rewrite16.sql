create or replace view aggView1764025047933173424 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin7735154162255360619 as (
with aggView3486004223809946138 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView3486004223809946138 where mk.keyword_id=aggView3486004223809946138.v27);
create or replace view aggJoin7214185129744923338 as (
with aggView8271860013955472058 as (select v29 from aggJoin7735154162255360619 group by v29)
select id as v29, title as v33, production_year as v36 from title as t, aggView8271860013955472058 where t.id=aggView8271860013955472058.v29 and production_year<=2010 and production_year>=1950);
create or replace view aggView8524493520098523750 as select v33, v29 from aggJoin7214185129744923338 group by v33,v29;
create or replace view aggJoin1199646310444306017 as (
with aggView2148315236588140787 as (select id as v13, link as v45 from link_type as lt where link LIKE '%follow%')
select movie_id as v29, v45 from movie_link as ml, aggView2148315236588140787 where ml.link_type_id=aggView2148315236588140787.v13);
create or replace view aggJoin5469915840512649264 as (
with aggView3421976164840516629 as (select v17, MIN(v2) as v44 from aggView1764025047933173424 group by v17)
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView3421976164840516629 where mc.company_id=aggView3421976164840516629.v17);
create or replace view aggJoin6724053077582086758 as (
with aggView8468738014857570470 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select v29, v18, v44 as v44 from aggJoin5469915840512649264 join aggView8468738014857570470 using(v29));
create or replace view aggJoin8778015131728550628 as (
with aggView2758552128713229312 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin6724053077582086758 join aggView2758552128713229312 using(v18));
create or replace view aggJoin6925473023845642693 as (
with aggView3668826111700089708 as (select v29, MIN(v45) as v45 from aggJoin1199646310444306017 group by v29,v45)
select v29, v44 as v44, v45 from aggJoin8778015131728550628 join aggView3668826111700089708 using(v29));
create or replace view aggJoin5771451724431710758 as (
with aggView3544709805366427751 as (select v29, MIN(v44) as v44, MIN(v45) as v45 from aggJoin6925473023845642693 group by v29,v44,v45)
select v33, v44, v45 from aggView8524493520098523750 join aggView3544709805366427751 using(v29));
select MIN(v44) as v44,MIN(v45) as v45,MIN(v33) as v46 from aggJoin5771451724431710758;
