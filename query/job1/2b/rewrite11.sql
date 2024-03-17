create or replace view aggView7846516518498614713 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin6969695927138830540 as select movie_id as v12 from movie_companies as mc, aggView7846516518498614713 where mc.company_id=aggView7846516518498614713.v1;
create or replace view aggView2179542556525209963 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6862162613087917877 as select movie_id as v12 from movie_keyword as mk, aggView2179542556525209963 where mk.keyword_id=aggView2179542556525209963.v18;
create or replace view aggView9122071943922300444 as select v12 from aggJoin6862162613087917877 group by v12;
create or replace view aggJoin8269186630725738445 as select id as v12, title as v20 from title as t, aggView9122071943922300444 where t.id=aggView9122071943922300444.v12;
create or replace view aggView4004682562875801215 as select v12, MIN(v20) as v31 from aggJoin8269186630725738445 group by v12;
create or replace view aggJoin4144429196956107950 as select v31 from aggJoin6969695927138830540 join aggView4004682562875801215 using(v12);
select MIN(v31) as v31 from aggJoin4144429196956107950;
