create or replace view aggView1902993352262491446 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin5477301198753265376 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView1902993352262491446 where mk.movie_id=aggView1902993352262491446.v12;
create or replace view aggView6944891264821669342 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1737794426497709405 as select v12, v24 from aggJoin5477301198753265376 join aggView6944891264821669342 using(v1);
create or replace view aggView696554601852042271 as select v12, MIN(v24) as v24 from aggJoin1737794426497709405 group by v12;
create or replace view aggJoin4774585156341013495 as select info as v7, v24 from movie_info as mi, aggView696554601852042271 where mi.movie_id=aggView696554601852042271.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
select MIN(v24) as v24 from aggJoin4774585156341013495;
