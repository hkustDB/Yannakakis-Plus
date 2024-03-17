create or replace view aggView5684459293790475241 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin610610802006999486 as select movie_id as v12 from movie_keyword as mk, aggView5684459293790475241 where mk.keyword_id=aggView5684459293790475241.v1;
create or replace view aggView5838034797027425634 as select v12 from aggJoin610610802006999486 group by v12;
create or replace view aggJoin421364619918547048 as select id as v12, title as v13 from title as t, aggView5838034797027425634 where t.id=aggView5838034797027425634.v12 and production_year>2005;
create or replace view aggView2252640498904492698 as select v12, MIN(v13) as v24 from aggJoin421364619918547048 group by v12;
create or replace view aggJoin4886046701500128168 as select v24 from movie_info as mi, aggView2252640498904492698 where mi.movie_id=aggView2252640498904492698.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view res as select MIN(v24) as v24 from aggJoin4886046701500128168;
select sum(v24) from res;