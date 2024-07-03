create or replace view aggView4613435650112806257 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin4048571449825836631 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView4613435650112806257 where mi.movie_id=aggView4613435650112806257.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView1050554913403283140 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2837430351973269314 as select movie_id as v12 from movie_keyword as mk, aggView1050554913403283140 where mk.keyword_id=aggView1050554913403283140.v1;
create or replace view aggView583293580647534121 as select v12, MIN(v24) as v24 from aggJoin4048571449825836631 group by v12,v24;
create or replace view aggJoin3649774095672186374 as select v24 from aggJoin2837430351973269314 join aggView583293580647534121 using(v12);
select MIN(v24) as v24 from aggJoin3649774095672186374;
