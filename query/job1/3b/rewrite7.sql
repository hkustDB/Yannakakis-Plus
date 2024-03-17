create or replace view aggView7028950401668341491 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin4973222957662194998 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView7028950401668341491 where mk.movie_id=aggView7028950401668341491.v12;
create or replace view aggView3754812748994368947 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin7606581943149910769 as select v1, v24 as v24 from aggJoin4973222957662194998 join aggView3754812748994368947 using(v12);
create or replace view aggView8078576472032540835 as select v1, MIN(v24) as v24 from aggJoin7606581943149910769 group by v1;
create or replace view aggJoin7947688388098882823 as select keyword as v2, v24 from keyword as k, aggView8078576472032540835 where k.id=aggView8078576472032540835.v1 and keyword LIKE '%sequel%';
select MIN(v24) as v24 from aggJoin7947688388098882823;
