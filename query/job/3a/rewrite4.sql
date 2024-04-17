create or replace view aggView4027253017212272237 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin4727388697696787923 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView4027253017212272237 where mk.movie_id=aggView4027253017212272237.v12;
create or replace view aggView4989531002886615551 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1599996714091942210 as select v12, v24 from aggJoin4727388697696787923 join aggView4989531002886615551 using(v1);
create or replace view aggView385351643462870623 as select v12, MIN(v24) as v24 from aggJoin1599996714091942210 group by v12,v24;
create or replace view aggJoin6580307959243574177 as select v24 from movie_info as mi, aggView385351643462870623 where mi.movie_id=aggView385351643462870623.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
select MIN(v24) as v24 from aggJoin6580307959243574177;
