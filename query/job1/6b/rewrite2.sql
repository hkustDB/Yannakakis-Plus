create or replace view aggView6127135621118820320 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin1886574365025168597 as select movie_id as v23, v35 from movie_keyword as mk, aggView6127135621118820320 where mk.keyword_id=aggView6127135621118820320.v8;
create or replace view aggView7170756498991305750 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin7735399063065828049 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView7170756498991305750 where ci.movie_id=aggView7170756498991305750.v23;
create or replace view aggView2141178925824211894 as select v23, MIN(v35) as v35 from aggJoin1886574365025168597 group by v23;
create or replace view aggJoin8412259035097051377 as select v14, v37 as v37, v35 from aggJoin7735399063065828049 join aggView2141178925824211894 using(v23);
create or replace view aggView2497765101534694897 as select v14, MIN(v37) as v37, MIN(v35) as v35 from aggJoin8412259035097051377 group by v14;
create or replace view aggJoin6208217247828127151 as select name as v15, v37, v35 from name as n, aggView2497765101534694897 where n.id=aggView2497765101534694897.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin6208217247828127151;
