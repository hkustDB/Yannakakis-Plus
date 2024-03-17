create or replace view aggView2907554558050756005 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin8580034112787219998 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView2907554558050756005 where mi.movie_id=aggView2907554558050756005.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView234597072226051356 as select v12, MIN(v24) as v24 from aggJoin8580034112787219998 group by v12;
create or replace view aggJoin1962963824305655464 as select keyword_id as v1, v24 from movie_keyword as mk, aggView234597072226051356 where mk.movie_id=aggView234597072226051356.v12;
create or replace view aggView3783873146484878637 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4567366888049695408 as select v24 from aggJoin1962963824305655464 join aggView3783873146484878637 using(v1);
create or replace view res as select MIN(v24) as v24 from aggJoin4567366888049695408;
select sum(v24) from res;