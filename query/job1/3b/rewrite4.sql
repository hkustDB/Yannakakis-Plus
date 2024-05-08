create or replace view aggView3156801689193238082 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin3179914204814441715 as select id as v12, title as v13, production_year as v16 from title as t, aggView3156801689193238082 where t.id=aggView3156801689193238082.v12 and production_year>2010;
create or replace view aggView7389334233404562789 as select v12, MIN(v13) as v24 from aggJoin3179914204814441715 group by v12;
create or replace view aggJoin7091635212102109428 as select keyword_id as v1, v24 from movie_keyword as mk, aggView7389334233404562789 where mk.movie_id=aggView7389334233404562789.v12;
create or replace view aggView4877827290086732137 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin80285044434448388 as select v24 from aggJoin7091635212102109428 join aggView4877827290086732137 using(v1);
select MIN(v24) as v24 from aggJoin80285044434448388;
