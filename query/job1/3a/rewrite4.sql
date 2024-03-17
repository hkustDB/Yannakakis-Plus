create or replace view aggView127457969554086437 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin4128357181449933701 as select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView127457969554086437 where mk.movie_id=aggView127457969554086437.v12;
create or replace view aggView8193939454017446755 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2984962642551786127 as select v12 from aggJoin4128357181449933701 join aggView8193939454017446755 using(v1);
create or replace view aggView207645962015836244 as select v12 from aggJoin2984962642551786127 group by v12;
create or replace view aggJoin6093422706219748654 as select title as v13 from title as t, aggView207645962015836244 where t.id=aggView207645962015836244.v12 and production_year>2005;
create or replace view res as select MIN(v13) as v24 from aggJoin6093422706219748654;
select sum(v24) from res;