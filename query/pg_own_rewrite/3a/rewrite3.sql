create or replace view aggView8111774215017219402 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin2534161527900976326 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView8111774215017219402 where mi.movie_id=aggView8111774215017219402.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView569239150099033799 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8119218086682523675 as select movie_id as v12 from movie_keyword as mk, aggView569239150099033799 where mk.keyword_id=aggView569239150099033799.v1;
create or replace view aggView4194206037779182771 as select v12, MIN(v24) as v24 from aggJoin2534161527900976326 group by v12,v24;
create or replace view aggJoin5480877870524404524 as select v24 from aggJoin8119218086682523675 join aggView4194206037779182771 using(v12);
select MIN(v24) as v24 from aggJoin5480877870524404524;
