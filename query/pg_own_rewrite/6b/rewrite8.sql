create or replace view aggView7521639503580454596 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin8952685633524373209 as select movie_id as v23, v35 from movie_keyword as mk, aggView7521639503580454596 where mk.keyword_id=aggView7521639503580454596.v8;
create or replace view aggView6711568526250847108 as select v23, MIN(v35) as v35 from aggJoin8952685633524373209 group by v23,v35;
create or replace view aggJoin4158089460158274000 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView6711568526250847108 where t.id=aggView6711568526250847108.v23 and production_year>2014;
create or replace view aggView6443826917170020674 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8430152142635499292 as select movie_id as v23, v36 from cast_info as ci, aggView6443826917170020674 where ci.person_id=aggView6443826917170020674.v14;
create or replace view aggView5372098358740486544 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin4158089460158274000 group by v23,v35;
create or replace view aggJoin2640688073620765714 as select v36 as v36, v35, v37 from aggJoin8430152142635499292 join aggView5372098358740486544 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin2640688073620765714;
