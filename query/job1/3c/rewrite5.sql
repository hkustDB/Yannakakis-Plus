create or replace view aggView4872329738163960114 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin3653620992298904933 as select movie_id as v12, keyword_id as v1, v24 from movie_keyword as mk, aggView4872329738163960114 where mk.movie_id=aggView4872329738163960114.v12;
create or replace view aggView4541948424311764389 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6574229209918647061 as select v12, v24 from aggJoin3653620992298904933 join aggView4541948424311764389 using(v1);
create or replace view aggView2045758160094756283 as select v12, MIN(v24) as v24 from aggJoin6574229209918647061 group by v12,v24;
create or replace view aggJoin6982364631105919015 as select v24 from movie_info as mi, aggView2045758160094756283 where mi.movie_id=aggView2045758160094756283.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
select MIN(v24) as v24 from aggJoin6982364631105919015;
