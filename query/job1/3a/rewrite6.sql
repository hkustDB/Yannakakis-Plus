create or replace view aggView7310641794662333176 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin3956593865902800758 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView7310641794662333176 where mk.movie_id=aggView7310641794662333176.v12;
create or replace view aggView2416393126641881217 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3685970318515910976 as select v12, v24 from aggJoin3956593865902800758 join aggView2416393126641881217 using(v1);
create or replace view aggView1451840859669001717 as select v12, MIN(v24) as v24 from aggJoin3685970318515910976 group by v12;
create or replace view aggJoin587989603513448428 as select info as v7, v24 from movie_info as mi, aggView1451840859669001717 where mi.movie_id=aggView1451840859669001717.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view res as select MIN(v24) as v24 from aggJoin587989603513448428;
select sum(v24) from res;