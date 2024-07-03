create or replace view aggView1520375620536456206 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin3581551146255236212 as select id as v12, title as v13, production_year as v16 from title as t, aggView1520375620536456206 where t.id=aggView1520375620536456206.v12 and production_year>2005;
create or replace view aggView5003274125138979128 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4984482900162988562 as select movie_id as v12 from movie_keyword as mk, aggView5003274125138979128 where mk.keyword_id=aggView5003274125138979128.v1;
create or replace view aggView6606029332545229056 as select v12, MIN(v13) as v24 from aggJoin3581551146255236212 group by v12;
create or replace view aggJoin3512295351452961603 as select v24 from aggJoin4984482900162988562 join aggView6606029332545229056 using(v12);
select MIN(v24) as v24 from aggJoin3512295351452961603;
