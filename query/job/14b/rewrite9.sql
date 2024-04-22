create or replace view aggJoin2215999215309216104 as (
with aggView79472647442638583 as (select id as v8 from kind_type as kt where kind= 'movie')
select id as v23, title as v24, production_year as v27 from title as t, aggView79472647442638583 where t.kind_id=aggView79472647442638583.v8 and production_year>2010 and ((title LIKE '%murder%') OR (title LIKE '%Murder%')));
create or replace view aggJoin7797272019166762589 as (
with aggView6087027859358443718 as (select id as v1 from info_type as it1 where info= 'countries')
select movie_id as v23, info as v13 from movie_info as mi, aggView6087027859358443718 where mi.info_type_id=aggView6087027859358443718.v1 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American'));
create or replace view aggJoin7714352918355506516 as (
with aggView9101624459086531872 as (select id as v3 from info_type as it2 where info= 'rating')
select movie_id as v23, info as v18 from movie_info_idx as mi_idx, aggView9101624459086531872 where mi_idx.info_type_id=aggView9101624459086531872.v3);
create or replace view aggJoin2021968313012106944 as (
with aggView8220910986318244217 as (select id as v5 from keyword as k where keyword IN ('murder','murder-in-title'))
select movie_id as v23 from movie_keyword as mk, aggView8220910986318244217 where mk.keyword_id=aggView8220910986318244217.v5);
create or replace view aggJoin944052029242605701 as (
with aggView8611633869982243032 as (select v23 from aggJoin2021968313012106944 group by v23)
select v23, v18 from aggJoin7714352918355506516 join aggView8611633869982243032 using(v23));
create or replace view aggJoin8497205197053587012 as (
with aggView9201939009372962399 as (select v23, v18 from aggJoin944052029242605701 group by v23,v18)
select v23, v18 from aggView9201939009372962399 where v18>'6.0');
create or replace view aggJoin952182396212072337 as (
with aggView538197414019616788 as (select v23 from aggJoin7797272019166762589 group by v23)
select v23, v24, v27 from aggJoin2215999215309216104 join aggView538197414019616788 using(v23));
create or replace view aggView8145687057443890755 as select v23, v24 from aggJoin952182396212072337 group by v23,v24;
create or replace view aggJoin3664415823461782843 as (
with aggView9124623655997452769 as (select v23, MIN(v24) as v36 from aggView8145687057443890755 group by v23)
select v18, v36 from aggJoin8497205197053587012 join aggView9124623655997452769 using(v23));
select MIN(v18) as v35,MIN(v36) as v36 from aggJoin3664415823461782843;
