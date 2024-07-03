create or replace view aggView7190338843378143313 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1078907703669459541 as select movie_id as v12 from movie_keyword as mk, aggView7190338843378143313 where mk.keyword_id=aggView7190338843378143313.v1;
create or replace view aggView1323907443071679152 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin1845387872166731825 as select v12 from aggJoin1078907703669459541 join aggView1323907443071679152 using(v12);
create or replace view aggView7876818657241562754 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin5653281166021510344 as select v24 from aggJoin1845387872166731825 join aggView7876818657241562754 using(v12);
select MIN(v24) as v24 from aggJoin5653281166021510344;
