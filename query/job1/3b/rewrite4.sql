create or replace view aggView7746439391527397456 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin526416553450496447 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView7746439391527397456 where mi.movie_id=aggView7746439391527397456.v12 and info= 'Bulgaria';
create or replace view aggView3749230302782197358 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4362821658658692679 as select movie_id as v12 from movie_keyword as mk, aggView3749230302782197358 where mk.keyword_id=aggView3749230302782197358.v1;
create or replace view aggView3600870348003233118 as select v12 from aggJoin4362821658658692679 group by v12;
create or replace view aggJoin2471157511714463501 as select v7, v24 as v24 from aggJoin526416553450496447 join aggView3600870348003233118 using(v12);
select MIN(v24) as v24 from aggJoin2471157511714463501;
