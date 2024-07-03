create or replace view aggView4466030833609197249 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4257842797627720610 as select movie_id as v12 from movie_keyword as mk, aggView4466030833609197249 where mk.keyword_id=aggView4466030833609197249.v1;
create or replace view aggView368453472464729771 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin8107511644463765768 as select v12 from aggJoin4257842797627720610 join aggView368453472464729771 using(v12);
create or replace view aggView162687990552693274 as select v12 from aggJoin8107511644463765768 group by v12;
create or replace view aggJoin788818554720755945 as select title as v13, production_year as v16 from title as t, aggView162687990552693274 where t.id=aggView162687990552693274.v12 and production_year>1990;
create or replace view aggView50678969774129928 as select v13 from aggJoin788818554720755945;
select MIN(v13) as v24 from aggView50678969774129928;
