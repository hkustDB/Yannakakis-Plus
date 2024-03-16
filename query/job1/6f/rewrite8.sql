create or replace view aggView6646033898633791096 as select id as v14, name as v36 from name as n;
create or replace view aggJoin3404201089647174508 as select movie_id as v23, v36 from cast_info as ci, aggView6646033898633791096 where ci.person_id=aggView6646033898633791096.v14;
create or replace view aggView2943544112089975551 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin9030120005639844207 as select movie_id as v23, v35 from movie_keyword as mk, aggView2943544112089975551 where mk.keyword_id=aggView2943544112089975551.v8;
create or replace view aggView5626856335388957397 as select v23, MIN(v35) as v35 from aggJoin9030120005639844207 group by v23;
create or replace view aggJoin7391806286828356436 as select v23, v36 as v36, v35 from aggJoin3404201089647174508 join aggView5626856335388957397 using(v23);
create or replace view aggView2761644362612224682 as select v23, MIN(v36) as v36, MIN(v35) as v35 from aggJoin7391806286828356436 group by v23;
create or replace view aggJoin1243771089651896746 as select title as v24, v36, v35 from title as t, aggView2761644362612224682 where t.id=aggView2761644362612224682.v23 and production_year>2000;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin1243771089651896746;
