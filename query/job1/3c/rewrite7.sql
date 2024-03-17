create or replace view aggView1633263431775784854 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin4620498189364023046 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView1633263431775784854 where mi.movie_id=aggView1633263431775784854.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView7145574167231082863 as select v12, MIN(v24) as v24 from aggJoin4620498189364023046 group by v12;
create or replace view aggJoin7813608299958327197 as select keyword_id as v1, v24 from movie_keyword as mk, aggView7145574167231082863 where mk.movie_id=aggView7145574167231082863.v12;
create or replace view aggView3698594967286587157 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3127878880995958018 as select v24 from aggJoin7813608299958327197 join aggView3698594967286587157 using(v1);
select MIN(v24) as v24 from aggJoin3127878880995958018;
