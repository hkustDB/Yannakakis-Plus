create or replace view aggView6402308598238219344 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin5860936439437848559 as select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView6402308598238219344 where mk.movie_id=aggView6402308598238219344.v12;
create or replace view aggView2912046433849065655 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5440624786559510203 as select v12 from aggJoin5860936439437848559 join aggView2912046433849065655 using(v1);
create or replace view aggView1381707336899131050 as select v12 from aggJoin5440624786559510203 group by v12;
create or replace view aggJoin2982970924527202145 as select title as v13 from title as t, aggView1381707336899131050 where t.id=aggView1381707336899131050.v12 and production_year>1990;
select MIN(v13) as v24 from aggJoin2982970924527202145;
