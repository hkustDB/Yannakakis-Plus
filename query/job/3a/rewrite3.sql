create or replace view aggView4320542052346258671 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1816076743880955552 as select movie_id as v12 from movie_keyword as mk, aggView4320542052346258671 where mk.keyword_id=aggView4320542052346258671.v1;
create or replace view aggView2419462468481715340 as select v12 from aggJoin1816076743880955552 group by v12;
create or replace view aggJoin3422902622452953809 as select movie_id as v12, info as v7 from movie_info as mi, aggView2419462468481715340 where mi.movie_id=aggView2419462468481715340.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView1463882801994787748 as select v12 from aggJoin3422902622452953809 group by v12;
create or replace view aggJoin2091029126878437500 as select title as v13 from title as t, aggView1463882801994787748 where t.id=aggView1463882801994787748.v12 and production_year>2005;
create or replace view res as select MIN(v13) as v24 from aggJoin2091029126878437500;
select sum(v24) from res;