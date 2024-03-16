create or replace view aggView7358691378390728088 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin5818236550023607534 as select id as v12, title as v13 from title as t, aggView7358691378390728088 where t.id=aggView7358691378390728088.v12 and production_year>1990;
create or replace view aggView1298746658955958061 as select v12, MIN(v13) as v24 from aggJoin5818236550023607534 group by v12;
create or replace view aggJoin3688964051367675506 as select keyword_id as v1, v24 from movie_keyword as mk, aggView1298746658955958061 where mk.movie_id=aggView1298746658955958061.v12;
create or replace view aggView44486556977928930 as select v1, MIN(v24) as v24 from aggJoin3688964051367675506 group by v1;
create or replace view aggJoin489493733384404618 as select v24 from keyword as k, aggView44486556977928930 where k.id=aggView44486556977928930.v1 and keyword LIKE '%sequel%';
create or replace view res as select MIN(v24) as v24 from aggJoin489493733384404618;
select sum(v24) from res;