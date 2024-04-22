create or replace view aggView6083683966160219289 as select name as v2, id as v17 from company_name as cn where country_code<> '[pl]' and ((name LIKE '%Film%') OR (name LIKE '%Warner%'));
create or replace view aggJoin1764810601223424217 as (
with aggView7779960887343963203 as (select movie_id as v29 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','English') group by movie_id)
select id as v29, title as v33, production_year as v36 from title as t, aggView7779960887343963203 where t.id=aggView7779960887343963203.v29 and production_year<=2010 and production_year>=1950);
create or replace view aggView8668440957714724848 as select v33, v29 from aggJoin1764810601223424217 group by v33,v29;
create or replace view aggJoin1833923323344333200 as (
with aggView3223036388894048909 as (select v29, MIN(v33) as v46 from aggView8668440957714724848 group by v29)
select movie_id as v29, link_type_id as v13, v46 from movie_link as ml, aggView3223036388894048909 where ml.movie_id=aggView3223036388894048909.v29);
create or replace view aggJoin3531944289248105053 as (
with aggView7983472709046754898 as (select v17, MIN(v2) as v44 from aggView6083683966160219289 group by v17)
select movie_id as v29, company_type_id as v18, v44 from movie_companies as mc, aggView7983472709046754898 where mc.company_id=aggView7983472709046754898.v17);
create or replace view aggJoin2194966116158019181 as (
with aggView1665784615639111594 as (select id as v18 from company_type as ct where kind= 'production companies')
select v29, v44 from aggJoin3531944289248105053 join aggView1665784615639111594 using(v18));
create or replace view aggJoin1147009628375139000 as (
with aggView9124485375153487696 as (select id as v27 from keyword as k where keyword= 'sequel')
select movie_id as v29 from movie_keyword as mk, aggView9124485375153487696 where mk.keyword_id=aggView9124485375153487696.v27);
create or replace view aggJoin4815886095157205444 as (
with aggView2729563263332482916 as (select v29 from aggJoin1147009628375139000 group by v29)
select v29, v13, v46 as v46 from aggJoin1833923323344333200 join aggView2729563263332482916 using(v29));
create or replace view aggJoin5103439884190366850 as (
with aggView8019565888310010046 as (select v29, MIN(v44) as v44 from aggJoin2194966116158019181 group by v29,v44)
select v13, v46 as v46, v44 from aggJoin4815886095157205444 join aggView8019565888310010046 using(v29));
create or replace view aggJoin4999214287649903851 as (
with aggView2084207646738687260 as (select v13, MIN(v46) as v46, MIN(v44) as v44 from aggJoin5103439884190366850 group by v13,v44,v46)
select link as v14, v46, v44 from link_type as lt, aggView2084207646738687260 where lt.id=aggView2084207646738687260.v13 and link LIKE '%follow%');
select MIN(v44) as v44,MIN(v14) as v45,MIN(v46) as v46 from aggJoin4999214287649903851;
