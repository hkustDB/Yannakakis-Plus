create or replace view aggView7404411480370485567 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin802767064680077217 as select id as v12, title as v13 from title as t, aggView7404411480370485567 where t.id=aggView7404411480370485567.v12 and production_year>2005;
create or replace view aggView2623023194800257372 as select v12, MIN(v13) as v24 from aggJoin802767064680077217 group by v12;
create or replace view aggJoin4743473209493507680 as select keyword_id as v1, v24 from movie_keyword as mk, aggView2623023194800257372 where mk.movie_id=aggView2623023194800257372.v12;
create or replace view aggView2653373296893030831 as select v1, MIN(v24) as v24 from aggJoin4743473209493507680 group by v1;
create or replace view aggJoin5241447063671690298 as select v24 from keyword as k, aggView2653373296893030831 where k.id=aggView2653373296893030831.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin5241447063671690298;
select sum(v24) from res;