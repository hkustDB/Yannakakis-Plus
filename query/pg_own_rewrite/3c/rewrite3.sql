create or replace view aggView4537898371485887690 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin5232228373037089378 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView4537898371485887690 where mi.movie_id=aggView4537898371485887690.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView6186376072657574174 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4496454931985829763 as select movie_id as v12 from movie_keyword as mk, aggView6186376072657574174 where mk.keyword_id=aggView6186376072657574174.v1;
create or replace view aggView7131565157271665341 as select v12, MIN(v24) as v24 from aggJoin5232228373037089378 group by v12,v24;
create or replace view aggJoin5780701128710162255 as select v24 from aggJoin4496454931985829763 join aggView7131565157271665341 using(v12);
select MIN(v24) as v24 from aggJoin5780701128710162255;
