create or replace view aggView4640638218074931472 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin9208205966067076040 as select movie_id as v12 from movie_keyword as mk, aggView4640638218074931472 where mk.keyword_id=aggView4640638218074931472.v1;
create or replace view aggView7861237584157642566 as select movie_id as v12 from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin457914066326409228 as select v12 from aggJoin9208205966067076040 join aggView7861237584157642566 using(v12);
create or replace view aggView6453252658226776394 as select v12 from aggJoin457914066326409228 group by v12;
create or replace view aggJoin4959216941803601169 as select title as v13, production_year as v16 from title as t, aggView6453252658226776394 where t.id=aggView6453252658226776394.v12 and production_year>1990;
create or replace view aggView5627407125024387171 as select v13 from aggJoin4959216941803601169;
select MIN(v13) as v24 from aggView5627407125024387171;
