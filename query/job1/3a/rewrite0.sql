create or replace view aggView8426199886605413815 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin91089181829341552 as select movie_id as v12 from movie_keyword as mk, aggView8426199886605413815 where mk.keyword_id=aggView8426199886605413815.v1;
create or replace view aggView888579876155588509 as select v12 from aggJoin91089181829341552 group by v12;
create or replace view aggJoin8806565524123729613 as select id as v12, title as v13 from title as t, aggView888579876155588509 where t.id=aggView888579876155588509.v12 and production_year>2005;
create or replace view aggView1281245402848462707 as select v12, MIN(v13) as v24 from aggJoin8806565524123729613 group by v12;
create or replace view aggJoin79783184382145158 as select v24 from movie_info as mi, aggView1281245402848462707 where mi.movie_id=aggView1281245402848462707.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
select MIN(v24) as v24 from aggJoin79783184382145158;
