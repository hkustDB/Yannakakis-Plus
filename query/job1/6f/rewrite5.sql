create or replace view aggView7934640319809748500 as select id as v14, name as v36 from name as n;
create or replace view aggJoin3425042757571079428 as select movie_id as v23, v36 from cast_info as ci, aggView7934640319809748500 where ci.person_id=aggView7934640319809748500.v14;
create or replace view aggView8097651504197222787 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin7935196486775668149 as select movie_id as v23, v35 from movie_keyword as mk, aggView8097651504197222787 where mk.keyword_id=aggView8097651504197222787.v8;
create or replace view aggView2056267143925301159 as select v23, MIN(v36) as v36 from aggJoin3425042757571079428 group by v23;
create or replace view aggJoin6800799076267850231 as select id as v23, title as v24, v36 from title as t, aggView2056267143925301159 where t.id=aggView2056267143925301159.v23 and production_year>2000;
create or replace view aggView2478312209194744856 as select v23, MIN(v35) as v35 from aggJoin7935196486775668149 group by v23;
create or replace view aggJoin6627130209901364805 as select v24, v36 as v36, v35 from aggJoin6800799076267850231 join aggView2478312209194744856 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin6627130209901364805;
