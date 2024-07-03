create or replace view aggView4571659865053716693 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4124768536251638990 as select movie_id as v15, note as v9 from movie_companies as mc, aggView4571659865053716693 where mc.company_type_id=aggView4571659865053716693.v1 and note LIKE '%(co-production)%' and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView8737838513564838322 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2010;
create or replace view aggJoin1863250439150730865 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView8737838513564838322 where mi_idx.movie_id=aggView8737838513564838322.v15;
create or replace view aggView3753491498052278001 as select v15, MIN(v9) as v27 from aggJoin4124768536251638990 group by v15;
create or replace view aggJoin4376983289256654352 as select v3, v28 as v28, v29 as v29, v27 from aggJoin1863250439150730865 join aggView3753491498052278001 using(v15);
create or replace view aggView6562943245346552260 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin6421618211961561028 as select v28, v29, v27 from aggJoin4376983289256654352 join aggView6562943245346552260 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin6421618211961561028;
