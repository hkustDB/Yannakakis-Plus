create or replace view aggView2246971602262475689 as select id as v14 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4837288577093831157 as select movie_id as v23 from cast_info as ci, aggView2246971602262475689 where ci.person_id=aggView2246971602262475689.v14;
create or replace view aggView3297888926846584524 as select id as v8 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin4003805689856157717 as select movie_id as v23 from movie_keyword as mk, aggView3297888926846584524 where mk.keyword_id=aggView3297888926846584524.v8;
create or replace view aggView2132988444054917956 as select id as v23 from title as t where production_year>2000;
create or replace view aggJoin8284461114679139411 as select v23 from aggJoin4003805689856157717 join aggView2132988444054917956 using(v23);
create or replace view aggView7096269347445415208 as select v23, COUNT(*) as annot from aggJoin8284461114679139411 group by v23;
create or replace view aggJoin4427410686340969079 as select annot from aggJoin4837288577093831157 join aggView7096269347445415208 using(v23);
select SUM(annot) as v35 from aggJoin4427410686340969079;
