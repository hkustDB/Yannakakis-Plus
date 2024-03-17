create or replace view aggView8242294507648537771 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin44243259143295733 as select movie_id as v23, v36 from cast_info as ci, aggView8242294507648537771 where ci.person_id=aggView8242294507648537771.v14;
create or replace view aggView4157937241750892033 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin6099638660519993637 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView4157937241750892033 where mk.movie_id=aggView4157937241750892033.v23;
create or replace view aggView9163775401858961909 as select v23, MIN(v36) as v36 from aggJoin44243259143295733 group by v23;
create or replace view aggJoin806704385219403057 as select v8, v37 as v37, v36 from aggJoin6099638660519993637 join aggView9163775401858961909 using(v23);
create or replace view aggView7298751823681971177 as select v8, MIN(v37) as v37, MIN(v36) as v36 from aggJoin806704385219403057 group by v8;
create or replace view aggJoin7958818176363667639 as select keyword as v9, v37, v36 from keyword as k, aggView7298751823681971177 where k.id=aggView7298751823681971177.v8 and keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin7958818176363667639;
