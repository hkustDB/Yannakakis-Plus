create or replace view aggView6796075357878005697 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin1894686849261416029 as select movie_id as v23, v35 from movie_keyword as mk, aggView6796075357878005697 where mk.keyword_id=aggView6796075357878005697.v8;
create or replace view aggView5162818406649814328 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8253282772075418587 as select movie_id as v23, v36 from cast_info as ci, aggView5162818406649814328 where ci.person_id=aggView5162818406649814328.v14;
create or replace view aggView5763078665424888646 as select v23, MIN(v35) as v35 from aggJoin1894686849261416029 group by v23;
create or replace view aggJoin2973479274884704146 as select id as v23, title as v24, v35 from title as t, aggView5763078665424888646 where t.id=aggView5763078665424888646.v23 and production_year>2014;
create or replace view aggView554625621689896603 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin2973479274884704146 group by v23;
create or replace view aggJoin8933960305722425132 as select v36 as v36, v35, v37 from aggJoin8253282772075418587 join aggView554625621689896603 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin8933960305722425132;
