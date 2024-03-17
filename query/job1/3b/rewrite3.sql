create or replace view aggView3174027896974449091 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5381046785810569614 as select movie_id as v12 from movie_keyword as mk, aggView3174027896974449091 where mk.keyword_id=aggView3174027896974449091.v1;
create or replace view aggView8270333906123266784 as select v12 from aggJoin5381046785810569614 group by v12;
create or replace view aggJoin7528339673345466247 as select movie_id as v12, info as v7 from movie_info as mi, aggView8270333906123266784 where mi.movie_id=aggView8270333906123266784.v12 and info= 'Bulgaria';
create or replace view aggView7272007385489835133 as select v12 from aggJoin7528339673345466247 group by v12;
create or replace view aggJoin1089206386634133418 as select title as v13 from title as t, aggView7272007385489835133 where t.id=aggView7272007385489835133.v12 and production_year>2010;
create or replace view res as select MIN(v13) as v24 from aggJoin1089206386634133418;
select sum(v24) from res;