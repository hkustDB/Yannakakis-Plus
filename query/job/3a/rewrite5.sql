create or replace view aggView8280634586458590635 as select id as v12, title as v24 from title as t where production_year>2005;
create or replace view aggJoin8662521843599075423 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView8280634586458590635 where mi.movie_id=aggView8280634586458590635.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView6847687416838043072 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4878820609231039289 as select movie_id as v12 from movie_keyword as mk, aggView6847687416838043072 where mk.keyword_id=aggView6847687416838043072.v1;
create or replace view aggView1305864728443542778 as select v12 from aggJoin4878820609231039289 group by v12;
create or replace view aggJoin6694718568969541645 as select v24 as v24 from aggJoin8662521843599075423 join aggView1305864728443542778 using(v12);
select MIN(v24) as v24 from aggJoin6694718568969541645;
