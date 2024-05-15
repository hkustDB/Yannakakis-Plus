create or replace view aggView6070158548513550340 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin3884350044671891059 as select movie_id as v23, v35 from movie_keyword as mk, aggView6070158548513550340 where mk.keyword_id=aggView6070158548513550340.v8;
create or replace view aggView8611065936920946904 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin108206577222475391 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView8611065936920946904 where ci.movie_id=aggView8611065936920946904.v23;
create or replace view aggView3613710830638602190 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin681267590918078777 as select v23, v37, v36 from aggJoin108206577222475391 join aggView3613710830638602190 using(v14);
create or replace view aggView2768122119405686075 as select v23, MIN(v35) as v35 from aggJoin3884350044671891059 group by v23;
create or replace view aggJoin3632299281635621884 as select v37 as v37, v36 as v36, v35 from aggJoin681267590918078777 join aggView2768122119405686075 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3632299281635621884;
