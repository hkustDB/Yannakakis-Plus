create or replace view aggView2282077060970292225 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2073701343446941610 as select movie_id as v12 from movie_keyword as mk, aggView2282077060970292225 where mk.keyword_id=aggView2282077060970292225.v1;
create or replace view aggView5172963395655890855 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin8563241917497025650 as select id as v12, title as v13, production_year as v16 from title as t, aggView5172963395655890855 where t.id=aggView5172963395655890855.v12 and production_year>1990;
create or replace view aggView154487370299994425 as select v12 from aggJoin2073701343446941610 group by v12;
create or replace view aggJoin7950192078558366149 as select v13, v16 from aggJoin8563241917497025650 join aggView154487370299994425 using(v12);
create or replace view aggView5370495724183952185 as select v13 from aggJoin7950192078558366149;
select MIN(v13) as v24 from aggView5370495724183952185;
