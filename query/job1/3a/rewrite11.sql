create or replace view aggView2407011452369840346 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin5481108322646499089 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView2407011452369840346 where mk.movie_id=aggView2407011452369840346.v12;
create or replace view aggView2748294760048505965 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin7395519365262398561 as select v1, v24 as v24 from aggJoin5481108322646499089 join aggView2748294760048505965 using(v12);
create or replace view aggView6736903700008079923 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2266708578190361401 as select v24 from aggJoin7395519365262398561 join aggView6736903700008079923 using(v1);
select MIN(v24) as v24 from aggJoin2266708578190361401;
