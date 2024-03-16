create or replace view aggView7496769508828788859 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin2040618360577402346 as select movie_id as v12, keyword_id as v1 from movie_keyword as mk, aggView7496769508828788859 where mk.movie_id=aggView7496769508828788859.v12;
create or replace view aggView8621028884195607608 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5739874752253411844 as select v12 from aggJoin2040618360577402346 join aggView8621028884195607608 using(v1);
create or replace view aggView4692072503755502881 as select v12 from aggJoin5739874752253411844 group by v12;
create or replace view aggJoin2298583668443138335 as select title as v13 from title as t, aggView4692072503755502881 where t.id=aggView4692072503755502881.v12 and production_year>1990;
create or replace view res as select MIN(v13) as v24 from aggJoin2298583668443138335;
select sum(v24) from res;