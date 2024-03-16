create or replace view aggView7307983509959234239 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin5639673430452134188 as select person_id as v14, movie_id as v23, v37 from cast_info as ci, aggView7307983509959234239 where ci.movie_id=aggView7307983509959234239.v23;
create or replace view aggView2197041517347813399 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin7705135461290964200 as select movie_id as v23, v35 from movie_keyword as mk, aggView2197041517347813399 where mk.keyword_id=aggView2197041517347813399.v8;
create or replace view aggView6275077577424557947 as select v23, MIN(v35) as v35 from aggJoin7705135461290964200 group by v23;
create or replace view aggJoin6948729229047636353 as select v14, v37 as v37, v35 from aggJoin5639673430452134188 join aggView6275077577424557947 using(v23);
create or replace view aggView7361133220507294853 as select v14, MIN(v37) as v37, MIN(v35) as v35 from aggJoin6948729229047636353 group by v14;
create or replace view aggJoin3281517920242127809 as select name as v15, v37, v35 from name as n, aggView7361133220507294853 where n.id=aggView7361133220507294853.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin3281517920242127809;
