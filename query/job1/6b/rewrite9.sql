create or replace view aggView260081732446684909 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin8337767038602201227 as select movie_id as v23, v36 from cast_info as ci, aggView260081732446684909 where ci.person_id=aggView260081732446684909.v14;
create or replace view aggView9078483758141866621 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin1142376945522872584 as select movie_id as v23, v35 from movie_keyword as mk, aggView9078483758141866621 where mk.keyword_id=aggView9078483758141866621.v8;
create or replace view aggView7084298316597243227 as select v23, MIN(v35) as v35 from aggJoin1142376945522872584 group by v23;
create or replace view aggJoin157334173345435309 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView7084298316597243227 where t.id=aggView7084298316597243227.v23 and production_year>2014;
create or replace view aggView3795628299891916959 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin157334173345435309 group by v23;
create or replace view aggJoin4155356660490997687 as select v36 as v36, v35, v37 from aggJoin8337767038602201227 join aggView3795628299891916959 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin4155356660490997687;
