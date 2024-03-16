create or replace view aggView70273318499580369 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin7275275140424005072 as select movie_id as v23, v35 from movie_keyword as mk, aggView70273318499580369 where mk.keyword_id=aggView70273318499580369.v8;
create or replace view aggView8444062308533798194 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3829004802960579557 as select movie_id as v23, v36 from cast_info as ci, aggView8444062308533798194 where ci.person_id=aggView8444062308533798194.v14;
create or replace view aggView6459444646838313524 as select v23, MIN(v36) as v36 from aggJoin3829004802960579557 group by v23;
create or replace view aggJoin3964778246330086107 as select v23, v35 as v35, v36 from aggJoin7275275140424005072 join aggView6459444646838313524 using(v23);
create or replace view aggView3934636449549967917 as select v23, MIN(v35) as v35, MIN(v36) as v36 from aggJoin3964778246330086107 group by v23;
create or replace view aggJoin8168198092904953040 as select title as v24, v35, v36 from title as t, aggView3934636449549967917 where t.id=aggView3934636449549967917.v23 and production_year>2014;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin8168198092904953040;
