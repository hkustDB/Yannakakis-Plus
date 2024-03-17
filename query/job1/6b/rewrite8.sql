create or replace view aggView3363693386287057166 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2816881843173714971 as select movie_id as v23, v36 from cast_info as ci, aggView3363693386287057166 where ci.person_id=aggView3363693386287057166.v14;
create or replace view aggView6170691499984016295 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin5050239449581664862 as select movie_id as v23, v35 from movie_keyword as mk, aggView6170691499984016295 where mk.keyword_id=aggView6170691499984016295.v8;
create or replace view aggView848761206002775962 as select v23, MIN(v36) as v36 from aggJoin2816881843173714971 group by v23;
create or replace view aggJoin765898730528594642 as select v23, v35 as v35, v36 from aggJoin5050239449581664862 join aggView848761206002775962 using(v23);
create or replace view aggView1658988854413577315 as select v23, MIN(v35) as v35, MIN(v36) as v36 from aggJoin765898730528594642 group by v23;
create or replace view aggJoin7978172558305142760 as select title as v24, v35, v36 from title as t, aggView1658988854413577315 where t.id=aggView1658988854413577315.v23 and production_year>2014;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin7978172558305142760;
