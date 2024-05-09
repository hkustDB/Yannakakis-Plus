create or replace view aggView3986998088816149770 as select id as v12 from title as t where production_year>1990;
create or replace view aggJoin6293667067122729302 as select movie_id as v12, info as v7 from movie_info as mi, aggView3986998088816149770 where mi.movie_id=aggView3986998088816149770.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView107321964349948138 as select v12, COUNT(*) as annot from aggJoin6293667067122729302 group by v12;
create or replace view aggJoin4963126636627080968 as select keyword_id as v1, annot from movie_keyword as mk, aggView107321964349948138 where mk.movie_id=aggView107321964349948138.v12;
create or replace view aggView944570142105699885 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4521435175603381174 as select annot from aggJoin4963126636627080968 join aggView944570142105699885 using(v1);
select SUM(annot) as v24 from aggJoin4521435175603381174;
