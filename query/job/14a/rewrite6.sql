create or replace view aggJoin8316610291230100472 as (
with aggView1580499462852547732 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView1580499462852547732 where mi_idx.info_type_id=aggView1580499462852547732.v3);
create or replace view aggJoin8760127289605920086 as (
with aggView2229315139605752386 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title','blood','violence'))
select movie_id as v23 from movie_keyword as mk, aggView2229315139605752386 where mk.keyword_id=aggView2229315139605752386.v5);
create or replace view aggJoin8296312566874086693 as (
with aggView4998169421831161084 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView4998169421831161084 where mi.info_type_id=aggView4998169421831161084.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin6885647920449333870 as (
with aggView9088601752061508352 as (select v23 from aggJoin8760127289605920086 group by v23)
select v23, v13 from aggJoin8296312566874086693 join aggView9088601752061508352 using(v23));
create or replace view aggJoin5468043391219859778 as (
with aggView1966594450095747566 as (select v23 from aggJoin6885647920449333870 group by v23)
select v23, v18 from aggJoin8316610291230100472 join aggView1966594450095747566 using(v23));
create or replace view aggJoin1562679603066949197 as (
with aggView6043818543888125273 as (select v23, v18 from aggJoin5468043391219859778 group by v23,v18)
select v23, v18 from aggView6043818543888125273 where v18<'8.5');
create or replace view aggJoin6258966148070609519 as (
with aggView6551837065491100028 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView6551837065491100028 where t.kind_id=aggView6551837065491100028.v8 and production_year>2010);
create or replace view aggView4954582009852731588 as select v23, v24 from aggJoin6258966148070609519 group by v23,v24;
create or replace view aggJoin150846572360686589 as (
with aggView8778800756996521424 as (select v23, MIN(v24) as v36 from aggView4954582009852731588 group by v23)
select v18, v36 from aggJoin1562679603066949197 join aggView8778800756996521424 using(v23));
select MIN(v18) as v35,MIN(v36) as v36 from aggJoin150846572360686589;
