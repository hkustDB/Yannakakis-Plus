create or replace view aggView23643274242687635 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin4670969394743628090 as select movie_id as v23, v35 from movie_keyword as mk, aggView23643274242687635 where mk.keyword_id=aggView23643274242687635.v8;
create or replace view aggView2308099867411656121 as select id as v14, name as v36 from name as n;
create or replace view aggJoin5873605547192169464 as select movie_id as v23, v36 from cast_info as ci, aggView2308099867411656121 where ci.person_id=aggView2308099867411656121.v14;
create or replace view aggView2703458411875968943 as select v23, MIN(v35) as v35 from aggJoin4670969394743628090 group by v23,v35;
create or replace view aggJoin3146189121360042868 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView2703458411875968943 where t.id=aggView2703458411875968943.v23 and production_year>2000;
create or replace view aggView7375998988692634563 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin3146189121360042868 group by v23,v35;
create or replace view aggJoin9140498116146718650 as select v36 as v36, v35, v37 from aggJoin5873605547192169464 join aggView7375998988692634563 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin9140498116146718650;
