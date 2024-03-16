create or replace view aggView3099087525025516506 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin4878003517442538145 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView3099087525025516506 where mi_idx.movie_id=aggView3099087525025516506.v15;
create or replace view aggView3825159592570277987 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin2250372461838845808 as select v15, v28, v29 from aggJoin4878003517442538145 join aggView3825159592570277987 using(v3);
create or replace view aggView6465854481311943849 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin2250372461838845808 group by v15;
create or replace view aggJoin8194022055937864927 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView6465854481311943849 where mc.movie_id=aggView6465854481311943849.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3846628813392718655 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin8194022055937864927 group by v1;
create or replace view aggJoin8318407656260467862 as select kind as v2, v28, v29, v27 from company_type as ct, aggView3846628813392718655 where ct.id=aggView3846628813392718655.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin8318407656260467862;
