create or replace view aggJoin5746096550836573958 as (
with aggView1712713484806183417 as (select id as v1 from keyword as k where keyword LIKE '%sequel%')
select movie_id as v12 from movie_keyword as mk, aggView1712713484806183417 where mk.keyword_id=aggView1712713484806183417.v1);
create or replace view aggJoin146983803524874725 as (
with aggView5539296337887908271 as (select v12 from aggJoin5746096550836573958 group by v12)
select id as v12, title as v13, production_year as v16 from title as t, aggView5539296337887908271 where t.id=aggView5539296337887908271.v12 and production_year>2005);
create or replace view aggJoin9146057484642433455 as (
with aggView8326512927472651145 as (select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id)
select v13, v16 from aggJoin146983803524874725 join aggView8326512927472651145 using(v12));
create or replace view aggView2233298577599863984 as select v13 from aggJoin9146057484642433455 group by v13;
select MIN(v13) as v24 from aggView2233298577599863984;
