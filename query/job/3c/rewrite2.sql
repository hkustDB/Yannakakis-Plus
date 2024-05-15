create or replace view aggView8431400801833734962 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3355967786511611661 as select movie_id as v12 from movie_keyword as mk, aggView8431400801833734962 where mk.keyword_id=aggView8431400801833734962.v1;
create or replace view aggView8633595132600283128 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin7432257238146908414 as select v12 from aggJoin3355967786511611661 join aggView8633595132600283128 using(v12);
create or replace view aggView1286420654954678955 as select v12 from aggJoin7432257238146908414 group by v12;
create or replace view aggJoin757685314314148862 as select title as v13, production_year as v16 from title as t, aggView1286420654954678955 where t.id=aggView1286420654954678955.v12 and production_year>1990;
create or replace view aggView3971105573612798910 as select v13 from aggJoin757685314314148862;
select MIN(v13) as v24 from aggView3971105573612798910;
