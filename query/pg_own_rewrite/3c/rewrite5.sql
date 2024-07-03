create or replace view aggView1099584132113864578 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8703014838102570942 as select movie_id as v12 from movie_keyword as mk, aggView1099584132113864578 where mk.keyword_id=aggView1099584132113864578.v1;
create or replace view aggView346301298332180679 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin1572864453093676607 as select v12 from aggJoin8703014838102570942 join aggView346301298332180679 using(v12);
create or replace view aggView7594819248044815029 as select id as v12, title as v24 from title as t where production_year>1990;
create or replace view aggJoin1073156556744560698 as select v24 from aggJoin1572864453093676607 join aggView7594819248044815029 using(v12);
select MIN(v24) as v24 from aggJoin1073156556744560698;
