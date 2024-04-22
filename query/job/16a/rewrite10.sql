create or replace view aggView5551113349404166256 as select person_id as v2, name as v3 from aka_name as an group by person_id,name;
create or replace view aggJoin9144175588974688580 as (
with aggView6280799242027035247 as (select id as v33 from keyword as k where keyword= 'character-name-in-title')
select movie_id as v11 from movie_keyword as mk, aggView6280799242027035247 where mk.keyword_id=aggView6280799242027035247.v33);
create or replace view aggJoin4936470242164181900 as (
with aggView3482709577599104255 as (select v11 from aggJoin9144175588974688580 group by v11)
select id as v11, title as v44, episode_nr as v52 from title as t, aggView3482709577599104255 where t.id=aggView3482709577599104255.v11 and episode_nr>=50 and episode_nr<100);
create or replace view aggView5893316328553841317 as select v11, v44 from aggJoin4936470242164181900 group by v11,v44;
create or replace view aggJoin7318313111061998156 as (
with aggView8196899158836167908 as (select v11, MIN(v44) as v56 from aggView5893316328553841317 group by v11)
select person_id as v2, movie_id as v11, v56 from cast_info as ci, aggView8196899158836167908 where ci.movie_id=aggView8196899158836167908.v11);
create or replace view aggJoin1919983124816811256 as (
with aggView1485641990492930425 as (select id as v2 from name as n)
select v2, v11, v56 from aggJoin7318313111061998156 join aggView1485641990492930425 using(v2));
create or replace view aggJoin779672303917567940 as (
with aggView8378242250324723424 as (select id as v28 from company_name as cn where country_code= '[us]')
select movie_id as v11 from movie_companies as mc, aggView8378242250324723424 where mc.company_id=aggView8378242250324723424.v28);
create or replace view aggJoin6991349737772109049 as (
with aggView4408355925205508951 as (select v11 from aggJoin779672303917567940 group by v11)
select v2, v56 as v56 from aggJoin1919983124816811256 join aggView4408355925205508951 using(v11));
create or replace view aggJoin7644346531145954528 as (
with aggView2997731198933883289 as (select v2, MIN(v56) as v56 from aggJoin6991349737772109049 group by v2,v56)
select v3, v56 from aggView5551113349404166256 join aggView2997731198933883289 using(v2));
select MIN(v3) as v55,MIN(v56) as v56 from aggJoin7644346531145954528;
