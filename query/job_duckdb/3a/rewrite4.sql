create or replace view aggView3459896495031869340 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin5746208718200702068 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView3459896495031869340 where mi.movie_id=aggView3459896495031869340.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView6523070698556410276 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4109713101371233862 as select movie_id as v12 from movie_keyword as mk, aggView6523070698556410276 where mk.keyword_id=aggView6523070698556410276.v1;
create or replace view aggView7356595147537843882 as select v12, MIN(v24) as v24 from aggJoin5746208718200702068 group by v12,v24;
create or replace view aggJoin5818850154637620399 as select v24 from aggJoin4109713101371233862 join aggView7356595147537843882 using(v12);
select MIN(v24) as v24 from aggJoin5818850154637620399;
