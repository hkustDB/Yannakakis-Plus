create or replace view aggView5245097118177826183 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin5287190594578207165 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView5245097118177826183 where ci.movie_id=aggView5245097118177826183.v23;
create or replace view aggView8262964683057875534 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin5103521575957021492 as select v23, v37 from aggJoin5287190594578207165 join aggView8262964683057875534 using(v14);
create or replace view aggView8837553569601635904 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin1883616038215808428 as select movie_id as v23, v35 from movie_keyword as mk, aggView8837553569601635904 where mk.keyword_id=aggView8837553569601635904.v8;
create or replace view aggView4797704528174250285 as select v23, MIN(v37) as v37 from aggJoin5103521575957021492 group by v23;
create or replace view aggJoin441334425411678263 as select v35 as v35, v37 from aggJoin1883616038215808428 join aggView4797704528174250285 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin441334425411678263;
