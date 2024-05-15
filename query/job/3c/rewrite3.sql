create or replace view aggView4463057299020796382 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin3234316454644216717 as select id as v12, title as v13, production_year as v16 from title as t, aggView4463057299020796382 where t.id=aggView4463057299020796382.v12 and production_year>1990;
create or replace view aggView8935875037341945924 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2849474930872249879 as select movie_id as v12 from movie_keyword as mk, aggView8935875037341945924 where mk.keyword_id=aggView8935875037341945924.v1;
create or replace view aggView716762803543423729 as select v12, MIN(v13) as v24 from aggJoin3234316454644216717 group by v12;
create or replace view aggJoin5765094856671908568 as select v24 from aggJoin2849474930872249879 join aggView716762803543423729 using(v12);
select MIN(v24) as v24 from aggJoin5765094856671908568;
