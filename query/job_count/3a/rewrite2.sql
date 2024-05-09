create or replace view aggView1413195936199493589 as select id as v12 from title as t where production_year>2005;
create or replace view aggJoin8730985891195105598 as select movie_id as v12, info as v7 from movie_info as mi, aggView1413195936199493589 where mi.movie_id=aggView1413195936199493589.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView390965047263887364 as select v12, COUNT(*) as annot from aggJoin8730985891195105598 group by v12;
create or replace view aggJoin8644327305123665223 as select keyword_id as v1, annot from movie_keyword as mk, aggView390965047263887364 where mk.movie_id=aggView390965047263887364.v12;
create or replace view aggView1613274874956457610 as select v1, SUM(annot) as annot from aggJoin8644327305123665223 group by v1;
create or replace view aggJoin8738528659042035831 as select keyword as v2, annot from keyword as k, aggView1613274874956457610 where k.id=aggView1613274874956457610.v1 and keyword LIKE '%sequel%';
select SUM(annot) as v24 from aggJoin8738528659042035831;
