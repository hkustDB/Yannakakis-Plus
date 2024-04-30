create or replace view aggView8803539753657410689 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin3216371976072380833 as select movie_id as v23, v35 from movie_keyword as mk, aggView8803539753657410689 where mk.keyword_id=aggView8803539753657410689.v8;
create or replace view aggView4396121081094041173 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin287535015277395145 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView4396121081094041173 where ci.movie_id=aggView4396121081094041173.v23;
create or replace view aggView4890611668750358074 as select v23, MIN(v35) as v35 from aggJoin3216371976072380833 group by v23;
create or replace view aggJoin5656792036669536653 as select v14, v37 as v37, v35 from aggJoin287535015277395145 join aggView4890611668750358074 using(v23);
create or replace view aggView2173233907659226762 as select v14, MIN(v37) as v37, MIN(v35) as v35 from aggJoin5656792036669536653 group by v14;
create or replace view aggJoin8719433083884642006 as select name as v15, v37, v35 from name as n, aggView2173233907659226762 where n.id=aggView2173233907659226762.v14;
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin8719433083884642006;
