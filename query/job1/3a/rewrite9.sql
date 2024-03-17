create or replace view aggView7696626876404281113 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin5606866801608719518 as select id as v12, title as v13 from title as t, aggView7696626876404281113 where t.id=aggView7696626876404281113.v12 and production_year>2005;
create or replace view aggView1000024989247599880 as select v12, MIN(v13) as v24 from aggJoin5606866801608719518 group by v12;
create or replace view aggJoin9211903530283813694 as select keyword_id as v1, v24 from movie_keyword as mk, aggView1000024989247599880 where mk.movie_id=aggView1000024989247599880.v12;
create or replace view aggView8543015641836276363 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6824227941837035648 as select v24 from aggJoin9211903530283813694 join aggView8543015641836276363 using(v1);
select MIN(v24) as v24 from aggJoin6824227941837035648;
